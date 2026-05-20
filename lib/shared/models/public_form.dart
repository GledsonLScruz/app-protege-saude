// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'json_helpers.dart';
import 'profession.dart';

part 'public_form.freezed.dart';
part 'public_form.g.dart';

@freezed
class PublicForm with _$PublicForm {
  const PublicForm._();

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory PublicForm({
    required Profession profissao,
    @Default(<PublicFormStep>[]) List<PublicFormStep> passos,
  }) = _PublicForm;

  factory PublicForm.fromJson(Map<String, dynamic> json) =>
      _$PublicFormFromJson(json);

  List<PublicFormStep> get orderedSteps {
    final copy = [...passos]
      ..sort((a, b) => a.ordemIndex.compareTo(b.ordemIndex));
    return copy
        .map(
          (step) => step.copyWith(
            campos: [...step.campos]
              ..sort((a, b) => a.ordemIndex.compareTo(b.ordemIndex)),
          ),
        )
        .toList();
  }
}

@freezed
class PublicFormStep with _$PublicFormStep {
  const PublicFormStep._();

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory PublicFormStep({
    @JsonKey(fromJson: intFromJson) required int id,
    @JsonKey(fromJson: nullableIntFromJson) int? profissaoId,
    @JsonKey(fromJson: intFromJson) @Default(0) int ordemIndex,
    required String titulo,
    String? descricao,
    @Default(<PublicFormField>[]) List<PublicFormField> campos,
  }) = _PublicFormStep;

  factory PublicFormStep.fromJson(Map<String, dynamic> json) =>
      _$PublicFormStepFromJson(json);
}

@freezed
class PublicFormField with _$PublicFormField {
  const PublicFormField._();

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory PublicFormField({
    @JsonKey(fromJson: intFromJson) required int id,
    @JsonKey(fromJson: nullableIntFromJson) int? formularioPassoId,
    @JsonKey(fromJson: intFromJson) @Default(0) int ordemIndex,
    required String nome,
    @JsonKey(name: 'tipo_campo') required String tipoCampo,
    @Default(<FormOption>[]) List<FormOption> opcoes,
    @JsonKey(fromJson: nullableIntFromJson) int? maxFotos,
    @JsonKey(fromJson: boolFromJson) @Default(false) bool obrigatorio,
    String? dica,
    FieldValidation? validacoes,
  }) = _PublicFormField;

  factory PublicFormField.fromJson(Map<String, dynamic> json) =>
      _$PublicFormFieldFromJson(_normalizeFieldJson(json));

  int get resolvedMaxPhotos => validacoes?.maxFotos ?? maxFotos ?? 1;

  bool get isRequired => validacoes?.obrigatorio ?? obrigatorio;

  String get type => tipoCampo.trim().toLowerCase();

  List<FormOption> get conditionalOptions {
    final allowed = validacoes?.opcoesCondicionaisPermitidas ?? const [];
    if (allowed.isEmpty) {
      return opcoes;
    }
    return opcoes
        .where((option) => allowed.contains(option.valor))
        .toList(growable: false);
  }
}

Map<String, dynamic> _normalizeFieldJson(Map<String, dynamic> json) {
  final normalized = Map<String, dynamic>.from(json);
  final options = normalized['opcoes'];
  if (options == null) {
    normalized['opcoes'] = <Map<String, dynamic>>[];
  } else if (options is List) {
    normalized['opcoes'] = options.whereType<Object?>().map((option) {
      if (option is Map<String, dynamic>) {
        return option;
      }
      if (option is Map) {
        return option.map((key, value) => MapEntry(key.toString(), value));
      }
      return {'valor': option.toString(), 'label': option.toString()};
    }).toList();
  }
  return normalized;
}

@freezed
class FormOption with _$FormOption {
  const FormOption._();

  const factory FormOption({required String valor, required String label}) =
      _FormOption;

  factory FormOption.fromJson(Map<String, dynamic> json) {
    final value = json['valor'] ?? json['value'] ?? json['id'] ?? '';
    final label = json['label'] ?? json['nome'] ?? json['name'] ?? value;
    return FormOption(valor: value.toString(), label: label.toString());
  }

  Map<String, dynamic> toJson() => {'valor': valor, 'label': label};
}

@freezed
class FieldValidation with _$FieldValidation {
  const FieldValidation._();

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory FieldValidation({
    @JsonKey(fromJson: nullableBoolFromJson) bool? obrigatorio,
    @JsonKey(fromJson: nullableBoolFromJson) bool? aceitaMultiplos,
    @Default(<String>[]) List<String> opcoesPermitidas,
    String? opcoesCondicionaisQuando,
    @Default(<String>[]) List<String> opcoesCondicionaisPermitidas,
    @JsonKey(fromJson: nullableBoolFromJson)
    bool? opcoesCondicionaisAceitaMultiplos,
    @JsonKey(fromJson: nullableIntFromJson) int? maxFotos,
  }) = _FieldValidation;

  factory FieldValidation.fromJson(Map<String, dynamic> json) =>
      _$FieldValidationFromJson(json);
}

bool? nullableBoolFromJson(Object? value) {
  if (value == null) {
    return null;
  }
  return boolFromJson(value);
}
