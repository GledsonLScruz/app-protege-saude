// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'cep_validation.dart';
import 'json_helpers.dart';

part 'complaint_models.freezed.dart';
part 'complaint_models.g.dart';

@freezed
class ComplaintAddress with _$ComplaintAddress {
  const ComplaintAddress._();

  const factory ComplaintAddress({
    @Default('') String cep,
    @Default('') String rua,
    @Default('') String numero,
    @Default('') String estado,
    @Default('') String cidade,
    @Default('') String bairro,
    @JsonKey(fromJson: nullableIntFromJson) int? conselhoId,
    String? conselhoNome,
    String? conselhoContato,
    String? conselhoRegiao,
    String? validatedCep,
  }) = _ComplaintAddress;

  factory ComplaintAddress.fromJson(Map<String, dynamic> json) =>
      _$ComplaintAddressFromJson(json);

  factory ComplaintAddress.fromCepResult({
    required String cep,
    required CepAllowed result,
    String? currentStreet,
    String? currentNumber,
  }) {
    return ComplaintAddress(
      cep: cep,
      rua: result.endereco.street.isNotEmpty
          ? result.endereco.street
          : (currentStreet ?? ''),
      numero: currentNumber ?? '',
      estado: result.endereco.estado,
      cidade: result.endereco.cidade,
      bairro: result.endereco.bairro,
      conselhoId: result.conselho.id,
      conselhoNome: result.conselho.nome,
      conselhoContato: result.conselho.contato,
      conselhoRegiao: result.conselho.regiao,
      validatedCep: cep,
    );
  }

  bool get hasValidatedCep => validatedCep != null && validatedCep == cep;
}

@freezed
class PhotoRef with _$PhotoRef {
  const factory PhotoRef({
    required String id,
    required String name,
    required String mimeType,
    required int sizeBytes,
    required String localPath,
    required DateTime createdAt,
  }) = _PhotoRef;

  factory PhotoRef.fromJson(Map<String, dynamic> json) =>
      _$PhotoRefFromJson(json);
}

@freezed
class ComplaintDraft with _$ComplaintDraft {
  const factory ComplaintDraft({
    required int professionId,
    ComplaintAddress? address,
    @Default(<String, Map<String, dynamic>>{})
    Map<String, Map<String, dynamic>> dynamicAnswers,
    @Default(<String, List<PhotoRef>>{}) Map<String, List<PhotoRef>> photoRefs,
    required DateTime updatedAt,
  }) = _ComplaintDraft;

  factory ComplaintDraft.fromJson(Map<String, dynamic> json) =>
      _$ComplaintDraftFromJson(json);
}

@freezed
class ConfirmationRecord with _$ConfirmationRecord {
  const factory ConfirmationRecord({
    required String protocol,
    required String pdfPath,
    required DateTime sentAt,
    required int professionId,
    required String professionName,
    String? councilName,
  }) = _ConfirmationRecord;

  factory ConfirmationRecord.fromJson(Map<String, dynamic> json) =>
      _$ConfirmationRecordFromJson(json);
}
