// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'json_helpers.dart';

part 'profession.freezed.dart';
part 'profession.g.dart';

@freezed
class Profession with _$Profession {
  const Profession._();

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Profession({
    @JsonKey(fromJson: intFromJson) required int id,
    required String nome,
    String? descricao,
    String? cor,
    @JsonKey(fromJson: nullableIntFromJson) int? status,
    @JsonKey(fromJson: nullableDateTimeFromJson) DateTime? dataCriacao,
    @JsonKey(fromJson: nullableDateTimeFromJson) DateTime? dataUpdate,
    @JsonKey(fromJson: nullableDateTimeFromJson) DateTime? dataDelete,
  }) = _Profession;

  factory Profession.fromJson(Map<String, dynamic> json) =>
      _$ProfessionFromJson(json);

  String get displayDescription => descricao?.trim().isNotEmpty == true
      ? descricao!.trim()
      : 'Formulario configurado para esta profissao.';
}
