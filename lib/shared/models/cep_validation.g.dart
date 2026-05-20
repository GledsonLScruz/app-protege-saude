// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cep_validation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddressDataImpl _$$AddressDataImplFromJson(Map<String, dynamic> json) =>
    _$AddressDataImpl(
      cep: json['cep'] as String,
      estado: json['estado'] as String,
      cidade: json['cidade'] as String,
      bairro: json['bairro'] as String,
      logradouro: json['logradouro'] as String?,
      rua: json['rua'] as String?,
    );

Map<String, dynamic> _$$AddressDataImplToJson(_$AddressDataImpl instance) =>
    <String, dynamic>{
      'cep': instance.cep,
      'estado': instance.estado,
      'cidade': instance.cidade,
      'bairro': instance.bairro,
      'logradouro': instance.logradouro,
      'rua': instance.rua,
    };

_$CouncilDataImpl _$$CouncilDataImplFromJson(Map<String, dynamic> json) =>
    _$CouncilDataImpl(
      id: intFromJson(json['id']),
      nome: json['nome'] as String,
      contato: json['contato'] as String?,
      regiao: json['regiao'] as String?,
    );

Map<String, dynamic> _$$CouncilDataImplToJson(_$CouncilDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'contato': instance.contato,
      'regiao': instance.regiao,
    };
