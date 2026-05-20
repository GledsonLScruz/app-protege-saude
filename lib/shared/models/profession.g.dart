// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profession.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfessionImpl _$$ProfessionImplFromJson(Map<String, dynamic> json) =>
    _$ProfessionImpl(
      id: intFromJson(json['id']),
      nome: json['nome'] as String,
      descricao: json['descricao'] as String?,
      cor: json['cor'] as String?,
      status: nullableIntFromJson(json['status']),
      dataCriacao: nullableDateTimeFromJson(json['data_criacao']),
      dataUpdate: nullableDateTimeFromJson(json['data_update']),
      dataDelete: nullableDateTimeFromJson(json['data_delete']),
    );

Map<String, dynamic> _$$ProfessionImplToJson(_$ProfessionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'descricao': instance.descricao,
      'cor': instance.cor,
      'status': instance.status,
      'data_criacao': instance.dataCriacao?.toIso8601String(),
      'data_update': instance.dataUpdate?.toIso8601String(),
      'data_delete': instance.dataDelete?.toIso8601String(),
    };
