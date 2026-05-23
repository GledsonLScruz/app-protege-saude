import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';

import '../../../shared/models/cep_validation.dart';
import '../../../shared/models/complaint_models.dart';
import '../../../shared/models/profession.dart';
import '../../../shared/models/public_form.dart';
import '../../../shared/network/api_exception.dart';
import '../../../shared/network/public_api.dart';
import '../../../shared/persistence/draft_repository.dart';
import '../../../shared/persistence/draft_sanitizer.dart';
import '../../../shared/services/dynamic_field_validator.dart';
import '../../../shared/services/pdf_service.dart';
import '../../../shared/services/photo_service.dart';
import '../../../shared/services/protocol_generator.dart';
import '../../../shared/utils/display_text.dart';
import '../../../shared/utils/text_normalizer.dart';

class DenunciaController extends ChangeNotifier {
  DenunciaController({
    required PublicApi api,
    required DraftRepository draftRepository,
    required PdfService pdfService,
    required PhotoService photoService,
    ProtocolGenerator? protocolGenerator,
    DynamicFieldValidator? fieldValidator,
  }) : _api = api,
       _draftRepository = draftRepository,
       _pdfService = pdfService,
       _photoService = photoService,
       _protocolGenerator = protocolGenerator ?? ProtocolGenerator(),
       _fieldValidator = fieldValidator ?? const DynamicFieldValidator();

  final PublicApi _api;
  final DraftRepository _draftRepository;
  final PdfService _pdfService;
  final PhotoService _photoService;
  final ProtocolGenerator _protocolGenerator;
  final DynamicFieldValidator _fieldValidator;

  List<Profession> professions = const [];
  Profession? pendingProfession;
  Profession? selectedProfession;
  PublicForm? loadedForm;
  ComplaintDraft? availableDraft;
  ComplaintAddress address = const ComplaintAddress();
  Map<String, Map<String, dynamic>> dynamicAnswers = {};
  Map<String, List<PhotoRef>> photoRefs = {};
  int currentStep = 0;

  bool isLoadingProfessions = false;
  bool isLoadingForm = false;
  bool wizardStarted = false;
  bool isValidatingCep = false;
  bool isSubmitting = false;
  String? loadError;
  String? formError;
  String? cepMessage;
  String? cepError;
  String? submitError;
  final Set<String> touchedFields = {};
  bool attemptedAdvance = false;

  Future<void> loadProfessions() async {
    isLoadingProfessions = true;
    loadError = null;
    notifyListeners();
    try {
      professions = await _api.fetchPublicProfessions();
    } on Object catch (error) {
      loadError = _messageFor(error);
    } finally {
      isLoadingProfessions = false;
      notifyListeners();
    }
  }

  Future<void> selectProfession(Profession profession) async {
    pendingProfession = profession;
    loadedForm = null;
    availableDraft = null;
    formError = null;
    isLoadingForm = true;
    notifyListeners();
    try {
      loadedForm = await _api.fetchPublicForm(profession.id);
      availableDraft = await _draftRepository.loadDraft(profession.id);
    } on Object catch (error) {
      formError = _messageFor(error);
    } finally {
      isLoadingForm = false;
      notifyListeners();
    }
  }

  Future<void> continueWithDraft() async {
    final form = loadedForm;
    final draft = availableDraft;
    final profession = pendingProfession;
    if (form == null || draft == null || profession == null) {
      return;
    }
    final sanitized = sanitizeDraft(draft, form);
    selectedProfession = profession;
    address = sanitized.address ?? const ComplaintAddress();
    dynamicAnswers = _cloneAnswers(sanitized.dynamicAnswers);
    photoRefs = await _existingPhotosOnly(sanitized.photoRefs);
    wizardStarted = true;
    currentStep = 0;
    attemptedAdvance = false;
    touchedFields.clear();
    await _saveDraft();
    notifyListeners();
  }

  Future<void> startFresh() async {
    final profession = pendingProfession;
    if (profession == null || loadedForm == null) {
      return;
    }
    await _draftRepository.deleteDraft(profession.id);
    selectedProfession = profession;
    availableDraft = null;
    address = const ComplaintAddress();
    dynamicAnswers = {};
    photoRefs = {};
    wizardStarted = true;
    currentStep = 0;
    attemptedAdvance = false;
    touchedFields.clear();
    await _saveDraft();
    notifyListeners();
  }

  void touchField(int stepId, int fieldId) {
    touchedFields.add(_fieldKey(stepId, fieldId));
    notifyListeners();
  }

  void updateAddress({String? cep, String? rua, String? numero}) {
    if (cep != null) {
      final formatted = formatCep(cep);
      final cepChanged = formatted != address.cep;
      address = address.copyWith(
        cep: formatted,
        validatedCep: cepChanged ? null : address.validatedCep,
        estado: cepChanged ? '' : address.estado,
        cidade: cepChanged ? '' : address.cidade,
        bairro: cepChanged ? '' : address.bairro,
        conselhoId: cepChanged ? null : address.conselhoId,
        conselhoNome: cepChanged ? null : address.conselhoNome,
        conselhoContato: cepChanged ? null : address.conselhoContato,
        conselhoRegiao: cepChanged ? null : address.conselhoRegiao,
      );
      cepMessage = null;
      cepError = null;
    }
    if (rua != null) {
      address = address.copyWith(rua: rua);
    }
    if (numero != null) {
      address = address.copyWith(numero: numero);
    }
    unawaited(_saveDraft());
    notifyListeners();
  }

  Future<void> validateCep() async {
    final digits = onlyDigits(address.cep);
    if (digits.length != 8) {
      cepError = 'Informe um CEP válido.';
      cepMessage = null;
      notifyListeners();
      return;
    }
    isValidatingCep = true;
    cepError = null;
    cepMessage = 'Validando CEP...';
    notifyListeners();
    try {
      final result = await _api.validateCep(digits);
      result.when(
        allowed: (endereco, conselho) {
          address = ComplaintAddress.fromCepResult(
            cep: formatCep(digits),
            result: CepAllowed(endereco: endereco, conselho: conselho),
            currentStreet: address.rua,
            currentNumber: address.numero,
          );
          cepMessage = 'CEP validado com sucesso.';
          cepError = null;
        },
        blocked: (codigo, mensagem) {
          address = address.copyWith(
            validatedCep: null,
            estado: '',
            cidade: '',
            bairro: '',
            conselhoId: null,
            conselhoNome: null,
            conselhoContato: null,
            conselhoRegiao: null,
          );
          cepMessage = null;
          cepError = mensagem;
        },
      );
      unawaited(_saveDraft());
    } on Object catch (error) {
      cepMessage = null;
      cepError = _messageFor(error);
    } finally {
      isValidatingCep = false;
      notifyListeners();
    }
  }

  void updateAnswer(PublicFormStep step, PublicFormField field, Object? value) {
    final stepKey = step.id.toString();
    final fieldKey = field.id.toString();
    dynamicAnswers = _cloneAnswers(dynamicAnswers)
      ..putIfAbsent(stepKey, () => <String, dynamic>{})[fieldKey] = value;
    touchedFields.add(_fieldKey(step.id, field.id));
    unawaited(_saveDraft());
    notifyListeners();
  }

  Future<String?> addPhotosFromGallery(PublicFormField field) async {
    final existing = photoRefs[field.id.toString()] ?? const [];
    final remaining = field.resolvedMaxPhotos - existing.length;
    if (remaining <= 0) {
      return field.resolvedMaxPhotos == 1
          ? 'Limite de 1 foto atingido.'
          : 'Limite de ${field.resolvedMaxPhotos} fotos atingido.';
    }
    final List<PhotoRef> picked;
    try {
      picked = await _photoService.pickFromGallery(remainingSlots: remaining);
    } on PhotoSelectionException catch (error) {
      return error.message;
    } on Object {
      return 'Não foi possível selecionar fotos. Verifique as permissões e tente novamente.';
    }
    if (picked.isEmpty) {
      return null;
    }
    await _appendPhotos(field, picked);
    return null;
  }

  Future<String?> capturePhoto(PublicFormField field) async {
    final existing = photoRefs[field.id.toString()] ?? const [];
    if (existing.length >= field.resolvedMaxPhotos) {
      return field.resolvedMaxPhotos == 1
          ? 'Limite de 1 foto atingido.'
          : 'Limite de ${field.resolvedMaxPhotos} fotos atingido.';
    }
    final PhotoRef? photo;
    try {
      photo = await _photoService.captureFromCamera();
    } on PhotoSelectionException catch (error) {
      return error.message;
    } on Object {
      return 'Não foi possível capturar a foto. Verifique as permissões e tente novamente.';
    }
    if (photo != null) {
      await _appendPhotos(field, [photo]);
    }
    return null;
  }

  Future<void> removePhoto(PublicFormField field, PhotoRef photo) async {
    await _photoService.deletePhoto(photo);
    final key = field.id.toString();
    final updated = [...(photoRefs[key] ?? const <PhotoRef>[])]
      ..removeWhere((item) => item.id == photo.id);
    photoRefs = {...photoRefs, key: updated};
    _syncPhotoAnswer(field);
    await _saveDraft();
    notifyListeners();
  }

  bool isStepAccessible(int index) {
    if (index <= currentStep) {
      return true;
    }
    for (var i = 0; i < index; i++) {
      if (!isStepValid(i)) {
        return false;
      }
    }
    return true;
  }

  bool goToStep(int index) {
    if (!isStepAccessible(index)) {
      attemptedAdvance = true;
      notifyListeners();
      return false;
    }
    currentStep = index;
    attemptedAdvance = false;
    notifyListeners();
    return true;
  }

  bool previousStep() {
    if (currentStep <= 0) {
      return false;
    }
    currentStep--;
    attemptedAdvance = false;
    notifyListeners();
    return true;
  }

  void returnToProfessionSelection() {
    wizardStarted = false;
    selectedProfession = null;
    currentStep = 0;
    attemptedAdvance = false;
    notifyListeners();
  }

  bool nextStep() {
    if (!isStepValid(currentStep)) {
      attemptedAdvance = true;
      _touchCurrentStep();
      notifyListeners();
      return false;
    }
    if (currentStep < totalSteps - 1) {
      currentStep++;
      attemptedAdvance = false;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<ConfirmationRecord?> submit() async {
    if (isSubmitting) {
      return null;
    }
    if (!isStepValid(currentStep)) {
      attemptedAdvance = true;
      _touchCurrentStep();
      notifyListeners();
      return null;
    }
    final profession = selectedProfession;
    final form = loadedForm;
    if (profession == null || form == null) {
      return null;
    }
    isSubmitting = true;
    submitError = null;
    notifyListeners();
    try {
      var protocol = _protocolGenerator.generate();
      var pdfPath = await _pdfService.generateComplaintPdf(
        protocol: protocol,
        profession: profession,
        address: address,
        form: form,
        answers: dynamicAnswers,
        photos: photoRefs,
      );
      try {
        protocol = await _api.submitComplaint(
          protocol: protocol,
          professionId: profession.id,
          address: address,
          pdfPath: pdfPath,
        );
      } on ApiException catch (error) {
        final isConflict =
            error.statusCode == 409 ||
            error.message.toLowerCase().contains('protocolo');
        if (!isConflict) {
          rethrow;
        }
        protocol = _protocolGenerator.generate();
        pdfPath = await _pdfService.generateComplaintPdf(
          protocol: protocol,
          profession: profession,
          address: address,
          form: form,
          answers: dynamicAnswers,
          photos: photoRefs,
        );
        protocol = await _api.submitComplaint(
          protocol: protocol,
          professionId: profession.id,
          address: address,
          pdfPath: pdfPath,
        );
      }
      final confirmation = ConfirmationRecord(
        protocol: protocol,
        pdfPath: pdfPath,
        sentAt: DateTime.now(),
        professionId: profession.id,
        professionName: profession.nome,
        councilName: address.conselhoNome,
      );
      await _draftRepository.saveConfirmation(confirmation);
      await _draftRepository.deleteDraft(profession.id);
      await _photoService.deletePhotos(
        photoRefs.values.expand((items) => items),
      );
      isSubmitting = false;
      notifyListeners();
      return confirmation;
    } on Object catch (error) {
      submitError = _messageFor(error);
      isSubmitting = false;
      notifyListeners();
      return null;
    }
  }

  int get totalSteps {
    final dynamicCount = loadedForm?.orderedSteps.length ?? 0;
    return wizardStarted ? dynamicCount + 2 : 0;
  }

  bool get isSummaryStep => wizardStarted && currentStep == totalSteps - 1;

  PublicFormStep? get currentDynamicStep {
    if (!wizardStarted || currentStep == 0 || isSummaryStep) {
      return null;
    }
    return loadedForm?.orderedSteps[currentStep - 1];
  }

  String get currentStepTitle {
    if (!wizardStarted) {
      return 'Selecione a profissão';
    }
    if (currentStep == 0) {
      return 'Endereço da Vítima';
    }
    if (isSummaryStep) {
      return 'Resumo';
    }
    return accentPortugueseText(currentDynamicStep?.titulo ?? 'Denúncia');
  }

  List<String> get stepTitles {
    final form = loadedForm;
    if (!wizardStarted || form == null) {
      return const [];
    }
    return [
      'Endereço da Vítima',
      ...form.orderedSteps.map((step) => accentPortugueseText(step.titulo)),
      'Resumo',
    ];
  }

  bool get hasAnyData {
    return address.cep.isNotEmpty ||
        address.rua.isNotEmpty ||
        address.numero.isNotEmpty ||
        dynamicAnswers.values.any((answers) => answers.isNotEmpty) ||
        photoRefs.values.any((photos) => photos.isNotEmpty);
  }

  bool isStepValid(int index) {
    final form = loadedForm;
    if (!wizardStarted || form == null) {
      return false;
    }
    if (index == 0) {
      return isAddressValid;
    }
    if (index == totalSteps - 1) {
      for (var i = 0; i < totalSteps - 1; i++) {
        if (!isStepValid(i)) {
          return false;
        }
      }
      return true;
    }
    final step = form.orderedSteps[index - 1];
    return _isDynamicStepValid(step);
  }

  bool get isAddressValid {
    return onlyDigits(address.cep).length == 8 &&
        address.hasValidatedCep &&
        address.rua.trim().length >= 3 &&
        address.numero.trim().isNotEmpty &&
        address.estado.trim().isNotEmpty &&
        address.cidade.trim().isNotEmpty &&
        address.bairro.trim().isNotEmpty &&
        (address.conselhoId != null ||
            address.conselhoNome?.isNotEmpty == true);
  }

  String? fieldError(PublicFormStep step, PublicFormField field) {
    final shouldShow =
        touchedFields.contains(_fieldKey(step.id, field.id)) ||
        attemptedAdvance;
    if (!shouldShow) {
      return null;
    }
    return _fieldValidator.validateField(
      field,
      dynamicAnswers[step.id.toString()]?[field.id.toString()],
      photos: photoRefs[field.id.toString()] ?? const [],
    );
  }

  Object? answerFor(PublicFormStep step, PublicFormField field) {
    return dynamicAnswers[step.id.toString()]?[field.id.toString()];
  }

  Future<void> _saveDraft() async {
    final profession = selectedProfession ?? pendingProfession;
    if (profession == null) {
      return;
    }
    await _draftRepository.saveDraft(
      ComplaintDraft(
        professionId: profession.id,
        address: address,
        dynamicAnswers: dynamicAnswers,
        photoRefs: photoRefs,
        updatedAt: DateTime.now(),
      ),
    );
  }

  bool _isDynamicStepValid(PublicFormStep step) {
    for (final field in step.campos) {
      final error = _fieldValidator.validateField(
        field,
        dynamicAnswers[step.id.toString()]?[field.id.toString()],
        photos: photoRefs[field.id.toString()] ?? const [],
      );
      if (error != null) {
        return false;
      }
    }
    return true;
  }

  Future<void> _appendPhotos(
    PublicFormField field,
    List<PhotoRef> photos,
  ) async {
    final key = field.id.toString();
    final current = [...(photoRefs[key] ?? const <PhotoRef>[])];
    photoRefs = {
      ...photoRefs,
      key: [...current, ...photos],
    };
    _syncPhotoAnswer(field);
    await _saveDraft();
    notifyListeners();
  }

  void _syncPhotoAnswer(PublicFormField field) {
    final form = loadedForm;
    if (form == null) {
      return;
    }
    for (final step in form.orderedSteps) {
      if (step.campos.any((item) => item.id == field.id)) {
        dynamicAnswers = _cloneAnswers(dynamicAnswers)
          ..putIfAbsent(step.id.toString(), () => <String, dynamic>{})[field.id
                  .toString()] =
              (photoRefs[field.id.toString()] ?? const <PhotoRef>[])
                  .map((photo) => photo.toJson())
                  .toList();
        touchedFields.add(_fieldKey(step.id, field.id));
        return;
      }
    }
  }

  void _touchCurrentStep() {
    final step = currentDynamicStep;
    if (step != null) {
      for (final field in step.campos) {
        touchedFields.add(_fieldKey(step.id, field.id));
      }
    }
  }

  Future<Map<String, List<PhotoRef>>> _existingPhotosOnly(
    Map<String, List<PhotoRef>> photos,
  ) async {
    final result = <String, List<PhotoRef>>{};
    for (final entry in photos.entries) {
      final existing = <PhotoRef>[];
      for (final photo in entry.value) {
        if (await File(photo.localPath).exists()) {
          existing.add(photo);
        }
      }
      if (existing.isNotEmpty) {
        result[entry.key] = existing;
      }
    }
    return result;
  }

  Map<String, Map<String, dynamic>> _cloneAnswers(
    Map<String, Map<String, dynamic>> source,
  ) {
    return {
      for (final entry in source.entries)
        entry.key: Map<String, dynamic>.from(entry.value),
    };
  }

  String _fieldKey(int stepId, int fieldId) => '$stepId:$fieldId';

  String _messageFor(Object error) {
    if (error is ApiException) {
      return error.message;
    }
    return 'Não foi possível concluir a operação. Verifique sua internet e tente novamente.';
  }
}
