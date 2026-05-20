// ignore_for_file: invalid_annotation_target

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/text_normalizer.dart';
import 'json_helpers.dart';

part 'guide_document.freezed.dart';
part 'guide_document.g.dart';

@freezed
class GuideDocument with _$GuideDocument {
  const GuideDocument._();

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory GuideDocument({
    @JsonKey(fromJson: intFromJson) required int id,
    @JsonKey(fromJson: nullableIntFromJson) int? profissaoId,
    required String titulo,
    String? descricao,
    @JsonKey(name: 'pontos_foco', fromJson: focusPointsFromJson)
    @Default(<FocusPoint>[])
    List<FocusPoint> pontosFoco,
    @JsonKey(name: 'url_online') String? urlOnline,
    String? arquivo,
    @JsonKey(name: 'foto_capa') String? fotoCapa,
    @JsonKey(fromJson: nullableDateTimeFromJson) DateTime? dataCriacao,
    @JsonKey(fromJson: nullableDateTimeFromJson) DateTime? dataUpdate,
  }) = _GuideDocument;

  factory GuideDocument.fromJson(Map<String, dynamic> json) =>
      _$GuideDocumentFromJson(json);

  KnownLocalDocument? get localFallback {
    final normalized = normalizeLooseText(titulo);
    if (normalized.contains('eca') ||
        normalized.contains('estatuto da crianca')) {
      return KnownLocalDocument.eca;
    }
    if (normalized.contains('codigo de etica') ||
        normalized.contains('cirurgiao dentista')) {
      return KnownLocalDocument.ethics;
    }
    if (normalized.contains('constituicao')) {
      return KnownLocalDocument.constitution;
    }
    return null;
  }
}

@freezed
class FocusPoint with _$FocusPoint {
  const FocusPoint._();

  const factory FocusPoint({required String titulo, int? pagina}) = _FocusPoint;

  factory FocusPoint.fromJson(Map<String, dynamic> json) {
    return FocusPoint(
      titulo: (json['titulo'] ?? json['title'] ?? '').toString(),
      pagina: nullableIntFromJson(json['pagina'] ?? json['page']),
    );
  }

  Map<String, dynamic> toJson() => {
    'titulo': titulo,
    if (pagina != null) 'pagina': pagina,
  };
}

enum KnownLocalDocument { eca, ethics, constitution }

List<FocusPoint> focusPointsFromJson(Object? value) {
  if (value == null) {
    return const [];
  }
  if (value is List) {
    return value.map(_focusPointFromAny).whereType<FocusPoint>().toList();
  }
  if (value is Map) {
    return [_focusPointFromAny(value)].whereType<FocusPoint>().toList();
  }
  final raw = value.toString().trim();
  if (raw.isEmpty) {
    return const [];
  }
  final decoded = _tryDecodeJson(raw);
  if (decoded != null) {
    return focusPointsFromJson(decoded);
  }
  return raw
      .split(RegExp(r'\r?\n'))
      .map((line) => line.trim())
      .where((line) => line.isNotEmpty)
      .map((line) => FocusPoint(titulo: line))
      .toList();
}

Object? _tryDecodeJson(String raw) {
  try {
    return jsonDecode(raw);
  } on FormatException {
    return null;
  }
}

FocusPoint? _focusPointFromAny(Object? value) {
  if (value == null) {
    return null;
  }
  if (value is FocusPoint) {
    return value;
  }
  if (value is Map<String, dynamic>) {
    return FocusPoint.fromJson(value);
  }
  if (value is Map) {
    return FocusPoint.fromJson(
      value.map((key, val) => MapEntry(key.toString(), val)),
    );
  }
  final title = value.toString().trim();
  return title.isEmpty ? null : FocusPoint(titulo: title);
}
