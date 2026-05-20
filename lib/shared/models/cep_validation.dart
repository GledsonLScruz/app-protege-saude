// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'json_helpers.dart';

part 'cep_validation.freezed.dart';
part 'cep_validation.g.dart';

@freezed
class AddressData with _$AddressData {
  const AddressData._();

  const factory AddressData({
    required String cep,
    required String estado,
    required String cidade,
    required String bairro,
    @JsonKey(name: 'logradouro') String? logradouro,
    @JsonKey(name: 'rua') String? rua,
  }) = _AddressData;

  factory AddressData.fromJson(Map<String, dynamic> json) =>
      _$AddressDataFromJson(json);

  String get street => (logradouro?.trim().isNotEmpty == true)
      ? logradouro!.trim()
      : (rua ?? '').trim();
}

@freezed
class CouncilData with _$CouncilData {
  const factory CouncilData({
    @JsonKey(fromJson: intFromJson) required int id,
    required String nome,
    String? contato,
    String? regiao,
  }) = _CouncilData;

  factory CouncilData.fromJson(Map<String, dynamic> json) =>
      _$CouncilDataFromJson(json);
}

@freezed
class CepValidationResult with _$CepValidationResult {
  const factory CepValidationResult.allowed({
    required AddressData endereco,
    required CouncilData conselho,
  }) = CepAllowed;

  const factory CepValidationResult.blocked({
    required String codigo,
    required String mensagem,
  }) = CepBlocked;

  factory CepValidationResult.fromJson(Map<String, dynamic> json) {
    final canProceed = json['podeProsseguir'] == true;
    if (canProceed) {
      return CepValidationResult.allowed(
        endereco: AddressData.fromJson(
          Map<String, dynamic>.from(json['endereco'] as Map? ?? const {}),
        ),
        conselho: CouncilData.fromJson(
          Map<String, dynamic>.from(json['conselho'] as Map? ?? const {}),
        ),
      );
    }
    return CepValidationResult.blocked(
      codigo: (json['codigo'] ?? 'CEP_INVALIDO').toString(),
      mensagem:
          (json['mensagem'] ??
                  json['message'] ??
                  'Nao foi possivel validar o CEP informado.')
              .toString(),
    );
  }
}
