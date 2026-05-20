// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guide_document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GuideDocumentImpl _$$GuideDocumentImplFromJson(Map<String, dynamic> json) =>
    _$GuideDocumentImpl(
      id: intFromJson(json['id']),
      profissaoId: nullableIntFromJson(json['profissao_id']),
      titulo: json['titulo'] as String,
      descricao: json['descricao'] as String?,
      pontosFoco: json['pontos_foco'] == null
          ? const <FocusPoint>[]
          : focusPointsFromJson(json['pontos_foco']),
      urlOnline: json['url_online'] as String?,
      arquivo: json['arquivo'] as String?,
      fotoCapa: json['foto_capa'] as String?,
      dataCriacao: nullableDateTimeFromJson(json['data_criacao']),
      dataUpdate: nullableDateTimeFromJson(json['data_update']),
    );

Map<String, dynamic> _$$GuideDocumentImplToJson(_$GuideDocumentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'profissao_id': instance.profissaoId,
      'titulo': instance.titulo,
      'descricao': instance.descricao,
      'pontos_foco': instance.pontosFoco,
      'url_online': instance.urlOnline,
      'arquivo': instance.arquivo,
      'foto_capa': instance.fotoCapa,
      'data_criacao': instance.dataCriacao?.toIso8601String(),
      'data_update': instance.dataUpdate?.toIso8601String(),
    };
