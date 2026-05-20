// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complaint_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ComplaintAddressImpl _$$ComplaintAddressImplFromJson(
  Map<String, dynamic> json,
) => _$ComplaintAddressImpl(
  cep: json['cep'] as String? ?? '',
  rua: json['rua'] as String? ?? '',
  numero: json['numero'] as String? ?? '',
  estado: json['estado'] as String? ?? '',
  cidade: json['cidade'] as String? ?? '',
  bairro: json['bairro'] as String? ?? '',
  conselhoId: nullableIntFromJson(json['conselhoId']),
  conselhoNome: json['conselhoNome'] as String?,
  conselhoContato: json['conselhoContato'] as String?,
  conselhoRegiao: json['conselhoRegiao'] as String?,
  validatedCep: json['validatedCep'] as String?,
);

Map<String, dynamic> _$$ComplaintAddressImplToJson(
  _$ComplaintAddressImpl instance,
) => <String, dynamic>{
  'cep': instance.cep,
  'rua': instance.rua,
  'numero': instance.numero,
  'estado': instance.estado,
  'cidade': instance.cidade,
  'bairro': instance.bairro,
  'conselhoId': instance.conselhoId,
  'conselhoNome': instance.conselhoNome,
  'conselhoContato': instance.conselhoContato,
  'conselhoRegiao': instance.conselhoRegiao,
  'validatedCep': instance.validatedCep,
};

_$PhotoRefImpl _$$PhotoRefImplFromJson(Map<String, dynamic> json) =>
    _$PhotoRefImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      mimeType: json['mimeType'] as String,
      sizeBytes: (json['sizeBytes'] as num).toInt(),
      localPath: json['localPath'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$PhotoRefImplToJson(_$PhotoRefImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mimeType': instance.mimeType,
      'sizeBytes': instance.sizeBytes,
      'localPath': instance.localPath,
      'createdAt': instance.createdAt.toIso8601String(),
    };

_$ComplaintDraftImpl _$$ComplaintDraftImplFromJson(Map<String, dynamic> json) =>
    _$ComplaintDraftImpl(
      professionId: (json['professionId'] as num).toInt(),
      address: json['address'] == null
          ? null
          : ComplaintAddress.fromJson(json['address'] as Map<String, dynamic>),
      dynamicAnswers:
          (json['dynamicAnswers'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as Map<String, dynamic>),
          ) ??
          const <String, Map<String, dynamic>>{},
      photoRefs:
          (json['photoRefs'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
              k,
              (e as List<dynamic>)
                  .map((e) => PhotoRef.fromJson(e as Map<String, dynamic>))
                  .toList(),
            ),
          ) ??
          const <String, List<PhotoRef>>{},
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$ComplaintDraftImplToJson(
  _$ComplaintDraftImpl instance,
) => <String, dynamic>{
  'professionId': instance.professionId,
  'address': instance.address,
  'dynamicAnswers': instance.dynamicAnswers,
  'photoRefs': instance.photoRefs,
  'updatedAt': instance.updatedAt.toIso8601String(),
};

_$ConfirmationRecordImpl _$$ConfirmationRecordImplFromJson(
  Map<String, dynamic> json,
) => _$ConfirmationRecordImpl(
  protocol: json['protocol'] as String,
  pdfPath: json['pdfPath'] as String,
  sentAt: DateTime.parse(json['sentAt'] as String),
  professionId: (json['professionId'] as num).toInt(),
  professionName: json['professionName'] as String,
  councilName: json['councilName'] as String?,
);

Map<String, dynamic> _$$ConfirmationRecordImplToJson(
  _$ConfirmationRecordImpl instance,
) => <String, dynamic>{
  'protocol': instance.protocol,
  'pdfPath': instance.pdfPath,
  'sentAt': instance.sentAt.toIso8601String(),
  'professionId': instance.professionId,
  'professionName': instance.professionName,
  'councilName': instance.councilName,
};
