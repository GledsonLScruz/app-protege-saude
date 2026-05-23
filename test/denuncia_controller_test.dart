import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:protege_saude/features/denuncia/controllers/denuncia_controller.dart';
import 'package:protege_saude/shared/config/api_config.dart';
import 'package:protege_saude/shared/models/complaint_models.dart';
import 'package:protege_saude/shared/models/profession.dart';
import 'package:protege_saude/shared/models/public_form.dart';
import 'package:protege_saude/shared/network/api_client.dart';
import 'package:protege_saude/shared/network/public_api.dart';
import 'package:protege_saude/shared/persistence/draft_repository.dart';
import 'package:protege_saude/shared/services/pdf_service.dart';
import 'package:protege_saude/shared/services/photo_service.dart';

void main() {
  test(
    'controller retorna mensagem clara quando galeria nega permissao',
    () async {
      final controller = _controller(
        photoService: _FailingPhotoService(
          galleryMessage: 'Permissao para acessar a galeria foi negada.',
        ),
      );
      final field = _photoField();

      final message = await controller.addPhotosFromGallery(field);

      expect(message, 'Permissao para acessar a galeria foi negada.');
    },
  );

  test(
    'controller retorna mensagem clara quando camera nega permissao',
    () async {
      final controller = _controller(
        photoService: _FailingPhotoService(
          cameraMessage: 'Permissao para acessar a camera foi negada.',
        ),
      );
      final field = _photoField();

      final message = await controller.capturePhoto(field);

      expect(message, 'Permissao para acessar a camera foi negada.');
    },
  );

  test(
    'controller persiste fotos no rascunho antes de retornar sucesso',
    () async {
      final repository = _MemoryDraftRepository();
      final photo = _photoRef(localPath: '/tmp/foto.jpg');
      final controller =
          _controller(
              draftRepository: repository,
              photoService: _SuccessfulPhotoService(galleryPhotos: [photo]),
            )
            ..selectedProfession = _profession()
            ..loadedForm = _formWithPhotoField();

      final message = await controller.addPhotosFromGallery(_photoField());

      expect(message, isNull);
      expect(repository.savedDraft?.photoRefs['1']?.single.id, photo.id);
    },
  );

  test('controller recupera fotos existentes ao retomar rascunho', () async {
    final directory = Directory.systemTemp.createTempSync(
      'protege_photo_draft_',
    );
    addTearDown(() async {
      if (await directory.exists()) {
        await directory.delete(recursive: true);
      }
    });
    final file = File('${directory.path}/foto.jpg');
    await file.writeAsBytes([1, 2, 3]);
    final photo = _photoRef(localPath: file.path);
    final repository = _MemoryDraftRepository();
    final controller =
        _controller(
            draftRepository: repository,
            photoService: _SuccessfulPhotoService(),
          )
          ..pendingProfession = _profession()
          ..loadedForm = _formWithPhotoField()
          ..availableDraft = ComplaintDraft(
            professionId: 7,
            photoRefs: {
              '1': [photo],
            },
            updatedAt: DateTime(2026),
          );

    await controller.continueWithDraft();

    expect(controller.photoRefs['1']?.single.localPath, file.path);
    expect(repository.savedDraft?.photoRefs['1']?.single.id, photo.id);
  });
}

DenunciaController _controller({
  required PhotoService photoService,
  DraftRepository? draftRepository,
}) {
  return DenunciaController(
    api: PublicApi(
      ApiClient(config: const ApiConfig(baseUrl: 'https://backend.test/api')),
    ),
    draftRepository: draftRepository ?? DraftRepository(),
    pdfService: PdfService(),
    photoService: photoService,
  );
}

PublicFormField _photoField() => PublicFormField.fromJson({
  'id': 1,
  'nome': 'Fotos',
  'tipo_campo': 'foto',
  'max_fotos': 2,
});

PublicForm _formWithPhotoField() => PublicForm.fromJson({
  'profissao': {'id': 7, 'nome': 'Odontologia'},
  'passos': [
    {
      'id': 10,
      'titulo': 'Evidencias',
      'campos': [
        {'id': 1, 'nome': 'Fotos', 'tipo_campo': 'foto', 'max_fotos': 2},
      ],
    },
  ],
});

Profession _profession() => const Profession(id: 7, nome: 'Odontologia');

PhotoRef _photoRef({required String localPath}) => PhotoRef(
  id: 'photo-1',
  name: 'foto.jpg',
  mimeType: 'image/jpeg',
  sizeBytes: 123,
  localPath: localPath,
  createdAt: DateTime(2026),
);

class _MemoryDraftRepository extends DraftRepository {
  ComplaintDraft? savedDraft;

  @override
  Future<void> saveDraft(ComplaintDraft draft) async {
    await Future<void>.delayed(const Duration(milliseconds: 10));
    savedDraft = draft;
  }

  @override
  Future<void> deleteDraft(int professionId) async {}
}

class _FailingPhotoService extends PhotoService {
  _FailingPhotoService({this.galleryMessage, this.cameraMessage});

  final String? galleryMessage;
  final String? cameraMessage;

  @override
  Future<List<PhotoRef>> pickFromGallery({required int remainingSlots}) async {
    throw PhotoSelectionException(galleryMessage ?? 'Erro na galeria.');
  }

  @override
  Future<PhotoRef?> captureFromCamera() async {
    throw PhotoSelectionException(cameraMessage ?? 'Erro na camera.');
  }
}

class _SuccessfulPhotoService extends PhotoService {
  _SuccessfulPhotoService({this.galleryPhotos = const []});

  final List<PhotoRef> galleryPhotos;

  @override
  Future<List<PhotoRef>> pickFromGallery({required int remainingSlots}) async {
    return galleryPhotos.take(remainingSlots).toList();
  }

  @override
  Future<PhotoRef?> captureFromCamera() async {
    return null;
  }
}
