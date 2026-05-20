// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PublicFormImpl _$$PublicFormImplFromJson(Map<String, dynamic> json) =>
    _$PublicFormImpl(
      profissao: Profession.fromJson(json['profissao'] as Map<String, dynamic>),
      passos:
          (json['passos'] as List<dynamic>?)
              ?.map((e) => PublicFormStep.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <PublicFormStep>[],
    );

Map<String, dynamic> _$$PublicFormImplToJson(_$PublicFormImpl instance) =>
    <String, dynamic>{
      'profissao': instance.profissao,
      'passos': instance.passos,
    };

_$PublicFormStepImpl _$$PublicFormStepImplFromJson(Map<String, dynamic> json) =>
    _$PublicFormStepImpl(
      id: intFromJson(json['id']),
      profissaoId: nullableIntFromJson(json['profissao_id']),
      ordemIndex: json['ordem_index'] == null
          ? 0
          : intFromJson(json['ordem_index']),
      titulo: json['titulo'] as String,
      descricao: json['descricao'] as String?,
      campos:
          (json['campos'] as List<dynamic>?)
              ?.map((e) => PublicFormField.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <PublicFormField>[],
    );

Map<String, dynamic> _$$PublicFormStepImplToJson(
  _$PublicFormStepImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'profissao_id': instance.profissaoId,
  'ordem_index': instance.ordemIndex,
  'titulo': instance.titulo,
  'descricao': instance.descricao,
  'campos': instance.campos,
};

_$PublicFormFieldImpl _$$PublicFormFieldImplFromJson(
  Map<String, dynamic> json,
) => _$PublicFormFieldImpl(
  id: intFromJson(json['id']),
  formularioPassoId: nullableIntFromJson(json['formulario_passo_id']),
  ordemIndex: json['ordem_index'] == null
      ? 0
      : intFromJson(json['ordem_index']),
  nome: json['nome'] as String,
  tipoCampo: json['tipo_campo'] as String,
  opcoes:
      (json['opcoes'] as List<dynamic>?)
          ?.map((e) => FormOption.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <FormOption>[],
  maxFotos: nullableIntFromJson(json['max_fotos']),
  obrigatorio: json['obrigatorio'] == null
      ? false
      : boolFromJson(json['obrigatorio']),
  dica: json['dica'] as String?,
  validacoes: json['validacoes'] == null
      ? null
      : FieldValidation.fromJson(json['validacoes'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$PublicFormFieldImplToJson(
  _$PublicFormFieldImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'formulario_passo_id': instance.formularioPassoId,
  'ordem_index': instance.ordemIndex,
  'nome': instance.nome,
  'tipo_campo': instance.tipoCampo,
  'opcoes': instance.opcoes,
  'max_fotos': instance.maxFotos,
  'obrigatorio': instance.obrigatorio,
  'dica': instance.dica,
  'validacoes': instance.validacoes,
};

_$FieldValidationImpl _$$FieldValidationImplFromJson(
  Map<String, dynamic> json,
) => _$FieldValidationImpl(
  obrigatorio: nullableBoolFromJson(json['obrigatorio']),
  aceitaMultiplos: nullableBoolFromJson(json['aceita_multiplos']),
  opcoesPermitidas:
      (json['opcoes_permitidas'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  opcoesCondicionaisQuando: json['opcoes_condicionais_quando'] as String?,
  opcoesCondicionaisPermitidas:
      (json['opcoes_condicionais_permitidas'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  opcoesCondicionaisAceitaMultiplos: nullableBoolFromJson(
    json['opcoes_condicionais_aceita_multiplos'],
  ),
  maxFotos: nullableIntFromJson(json['max_fotos']),
);

Map<String, dynamic> _$$FieldValidationImplToJson(
  _$FieldValidationImpl instance,
) => <String, dynamic>{
  'obrigatorio': instance.obrigatorio,
  'aceita_multiplos': instance.aceitaMultiplos,
  'opcoes_permitidas': instance.opcoesPermitidas,
  'opcoes_condicionais_quando': instance.opcoesCondicionaisQuando,
  'opcoes_condicionais_permitidas': instance.opcoesCondicionaisPermitidas,
  'opcoes_condicionais_aceita_multiplos':
      instance.opcoesCondicionaisAceitaMultiplos,
  'max_fotos': instance.maxFotos,
};
