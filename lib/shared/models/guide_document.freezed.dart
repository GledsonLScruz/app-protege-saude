// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'guide_document.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GuideDocument _$GuideDocumentFromJson(Map<String, dynamic> json) {
  return _GuideDocument.fromJson(json);
}

/// @nodoc
mixin _$GuideDocument {
  @JsonKey(fromJson: intFromJson)
  int get id => throw _privateConstructorUsedError;
  @JsonKey(fromJson: nullableIntFromJson)
  int? get profissaoId => throw _privateConstructorUsedError;
  String get titulo => throw _privateConstructorUsedError;
  String? get descricao => throw _privateConstructorUsedError;
  @JsonKey(name: 'pontos_foco', fromJson: focusPointsFromJson)
  List<FocusPoint> get pontosFoco => throw _privateConstructorUsedError;
  @JsonKey(name: 'url_online')
  String? get urlOnline => throw _privateConstructorUsedError;
  String? get arquivo => throw _privateConstructorUsedError;
  @JsonKey(name: 'foto_capa')
  String? get fotoCapa => throw _privateConstructorUsedError;
  @JsonKey(fromJson: nullableDateTimeFromJson)
  DateTime? get dataCriacao => throw _privateConstructorUsedError;
  @JsonKey(fromJson: nullableDateTimeFromJson)
  DateTime? get dataUpdate => throw _privateConstructorUsedError;

  /// Serializes this GuideDocument to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GuideDocument
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GuideDocumentCopyWith<GuideDocument> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GuideDocumentCopyWith<$Res> {
  factory $GuideDocumentCopyWith(
    GuideDocument value,
    $Res Function(GuideDocument) then,
  ) = _$GuideDocumentCopyWithImpl<$Res, GuideDocument>;
  @useResult
  $Res call({
    @JsonKey(fromJson: intFromJson) int id,
    @JsonKey(fromJson: nullableIntFromJson) int? profissaoId,
    String titulo,
    String? descricao,
    @JsonKey(name: 'pontos_foco', fromJson: focusPointsFromJson)
    List<FocusPoint> pontosFoco,
    @JsonKey(name: 'url_online') String? urlOnline,
    String? arquivo,
    @JsonKey(name: 'foto_capa') String? fotoCapa,
    @JsonKey(fromJson: nullableDateTimeFromJson) DateTime? dataCriacao,
    @JsonKey(fromJson: nullableDateTimeFromJson) DateTime? dataUpdate,
  });
}

/// @nodoc
class _$GuideDocumentCopyWithImpl<$Res, $Val extends GuideDocument>
    implements $GuideDocumentCopyWith<$Res> {
  _$GuideDocumentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GuideDocument
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? profissaoId = freezed,
    Object? titulo = null,
    Object? descricao = freezed,
    Object? pontosFoco = null,
    Object? urlOnline = freezed,
    Object? arquivo = freezed,
    Object? fotoCapa = freezed,
    Object? dataCriacao = freezed,
    Object? dataUpdate = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            profissaoId: freezed == profissaoId
                ? _value.profissaoId
                : profissaoId // ignore: cast_nullable_to_non_nullable
                      as int?,
            titulo: null == titulo
                ? _value.titulo
                : titulo // ignore: cast_nullable_to_non_nullable
                      as String,
            descricao: freezed == descricao
                ? _value.descricao
                : descricao // ignore: cast_nullable_to_non_nullable
                      as String?,
            pontosFoco: null == pontosFoco
                ? _value.pontosFoco
                : pontosFoco // ignore: cast_nullable_to_non_nullable
                      as List<FocusPoint>,
            urlOnline: freezed == urlOnline
                ? _value.urlOnline
                : urlOnline // ignore: cast_nullable_to_non_nullable
                      as String?,
            arquivo: freezed == arquivo
                ? _value.arquivo
                : arquivo // ignore: cast_nullable_to_non_nullable
                      as String?,
            fotoCapa: freezed == fotoCapa
                ? _value.fotoCapa
                : fotoCapa // ignore: cast_nullable_to_non_nullable
                      as String?,
            dataCriacao: freezed == dataCriacao
                ? _value.dataCriacao
                : dataCriacao // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            dataUpdate: freezed == dataUpdate
                ? _value.dataUpdate
                : dataUpdate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GuideDocumentImplCopyWith<$Res>
    implements $GuideDocumentCopyWith<$Res> {
  factory _$$GuideDocumentImplCopyWith(
    _$GuideDocumentImpl value,
    $Res Function(_$GuideDocumentImpl) then,
  ) = __$$GuideDocumentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(fromJson: intFromJson) int id,
    @JsonKey(fromJson: nullableIntFromJson) int? profissaoId,
    String titulo,
    String? descricao,
    @JsonKey(name: 'pontos_foco', fromJson: focusPointsFromJson)
    List<FocusPoint> pontosFoco,
    @JsonKey(name: 'url_online') String? urlOnline,
    String? arquivo,
    @JsonKey(name: 'foto_capa') String? fotoCapa,
    @JsonKey(fromJson: nullableDateTimeFromJson) DateTime? dataCriacao,
    @JsonKey(fromJson: nullableDateTimeFromJson) DateTime? dataUpdate,
  });
}

/// @nodoc
class __$$GuideDocumentImplCopyWithImpl<$Res>
    extends _$GuideDocumentCopyWithImpl<$Res, _$GuideDocumentImpl>
    implements _$$GuideDocumentImplCopyWith<$Res> {
  __$$GuideDocumentImplCopyWithImpl(
    _$GuideDocumentImpl _value,
    $Res Function(_$GuideDocumentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GuideDocument
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? profissaoId = freezed,
    Object? titulo = null,
    Object? descricao = freezed,
    Object? pontosFoco = null,
    Object? urlOnline = freezed,
    Object? arquivo = freezed,
    Object? fotoCapa = freezed,
    Object? dataCriacao = freezed,
    Object? dataUpdate = freezed,
  }) {
    return _then(
      _$GuideDocumentImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        profissaoId: freezed == profissaoId
            ? _value.profissaoId
            : profissaoId // ignore: cast_nullable_to_non_nullable
                  as int?,
        titulo: null == titulo
            ? _value.titulo
            : titulo // ignore: cast_nullable_to_non_nullable
                  as String,
        descricao: freezed == descricao
            ? _value.descricao
            : descricao // ignore: cast_nullable_to_non_nullable
                  as String?,
        pontosFoco: null == pontosFoco
            ? _value._pontosFoco
            : pontosFoco // ignore: cast_nullable_to_non_nullable
                  as List<FocusPoint>,
        urlOnline: freezed == urlOnline
            ? _value.urlOnline
            : urlOnline // ignore: cast_nullable_to_non_nullable
                  as String?,
        arquivo: freezed == arquivo
            ? _value.arquivo
            : arquivo // ignore: cast_nullable_to_non_nullable
                  as String?,
        fotoCapa: freezed == fotoCapa
            ? _value.fotoCapa
            : fotoCapa // ignore: cast_nullable_to_non_nullable
                  as String?,
        dataCriacao: freezed == dataCriacao
            ? _value.dataCriacao
            : dataCriacao // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        dataUpdate: freezed == dataUpdate
            ? _value.dataUpdate
            : dataUpdate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$GuideDocumentImpl extends _GuideDocument {
  const _$GuideDocumentImpl({
    @JsonKey(fromJson: intFromJson) required this.id,
    @JsonKey(fromJson: nullableIntFromJson) this.profissaoId,
    required this.titulo,
    this.descricao,
    @JsonKey(name: 'pontos_foco', fromJson: focusPointsFromJson)
    final List<FocusPoint> pontosFoco = const <FocusPoint>[],
    @JsonKey(name: 'url_online') this.urlOnline,
    this.arquivo,
    @JsonKey(name: 'foto_capa') this.fotoCapa,
    @JsonKey(fromJson: nullableDateTimeFromJson) this.dataCriacao,
    @JsonKey(fromJson: nullableDateTimeFromJson) this.dataUpdate,
  }) : _pontosFoco = pontosFoco,
       super._();

  factory _$GuideDocumentImpl.fromJson(Map<String, dynamic> json) =>
      _$$GuideDocumentImplFromJson(json);

  @override
  @JsonKey(fromJson: intFromJson)
  final int id;
  @override
  @JsonKey(fromJson: nullableIntFromJson)
  final int? profissaoId;
  @override
  final String titulo;
  @override
  final String? descricao;
  final List<FocusPoint> _pontosFoco;
  @override
  @JsonKey(name: 'pontos_foco', fromJson: focusPointsFromJson)
  List<FocusPoint> get pontosFoco {
    if (_pontosFoco is EqualUnmodifiableListView) return _pontosFoco;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pontosFoco);
  }

  @override
  @JsonKey(name: 'url_online')
  final String? urlOnline;
  @override
  final String? arquivo;
  @override
  @JsonKey(name: 'foto_capa')
  final String? fotoCapa;
  @override
  @JsonKey(fromJson: nullableDateTimeFromJson)
  final DateTime? dataCriacao;
  @override
  @JsonKey(fromJson: nullableDateTimeFromJson)
  final DateTime? dataUpdate;

  @override
  String toString() {
    return 'GuideDocument(id: $id, profissaoId: $profissaoId, titulo: $titulo, descricao: $descricao, pontosFoco: $pontosFoco, urlOnline: $urlOnline, arquivo: $arquivo, fotoCapa: $fotoCapa, dataCriacao: $dataCriacao, dataUpdate: $dataUpdate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GuideDocumentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.profissaoId, profissaoId) ||
                other.profissaoId == profissaoId) &&
            (identical(other.titulo, titulo) || other.titulo == titulo) &&
            (identical(other.descricao, descricao) ||
                other.descricao == descricao) &&
            const DeepCollectionEquality().equals(
              other._pontosFoco,
              _pontosFoco,
            ) &&
            (identical(other.urlOnline, urlOnline) ||
                other.urlOnline == urlOnline) &&
            (identical(other.arquivo, arquivo) || other.arquivo == arquivo) &&
            (identical(other.fotoCapa, fotoCapa) ||
                other.fotoCapa == fotoCapa) &&
            (identical(other.dataCriacao, dataCriacao) ||
                other.dataCriacao == dataCriacao) &&
            (identical(other.dataUpdate, dataUpdate) ||
                other.dataUpdate == dataUpdate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    profissaoId,
    titulo,
    descricao,
    const DeepCollectionEquality().hash(_pontosFoco),
    urlOnline,
    arquivo,
    fotoCapa,
    dataCriacao,
    dataUpdate,
  );

  /// Create a copy of GuideDocument
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GuideDocumentImplCopyWith<_$GuideDocumentImpl> get copyWith =>
      __$$GuideDocumentImplCopyWithImpl<_$GuideDocumentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GuideDocumentImplToJson(this);
  }
}

abstract class _GuideDocument extends GuideDocument {
  const factory _GuideDocument({
    @JsonKey(fromJson: intFromJson) required final int id,
    @JsonKey(fromJson: nullableIntFromJson) final int? profissaoId,
    required final String titulo,
    final String? descricao,
    @JsonKey(name: 'pontos_foco', fromJson: focusPointsFromJson)
    final List<FocusPoint> pontosFoco,
    @JsonKey(name: 'url_online') final String? urlOnline,
    final String? arquivo,
    @JsonKey(name: 'foto_capa') final String? fotoCapa,
    @JsonKey(fromJson: nullableDateTimeFromJson) final DateTime? dataCriacao,
    @JsonKey(fromJson: nullableDateTimeFromJson) final DateTime? dataUpdate,
  }) = _$GuideDocumentImpl;
  const _GuideDocument._() : super._();

  factory _GuideDocument.fromJson(Map<String, dynamic> json) =
      _$GuideDocumentImpl.fromJson;

  @override
  @JsonKey(fromJson: intFromJson)
  int get id;
  @override
  @JsonKey(fromJson: nullableIntFromJson)
  int? get profissaoId;
  @override
  String get titulo;
  @override
  String? get descricao;
  @override
  @JsonKey(name: 'pontos_foco', fromJson: focusPointsFromJson)
  List<FocusPoint> get pontosFoco;
  @override
  @JsonKey(name: 'url_online')
  String? get urlOnline;
  @override
  String? get arquivo;
  @override
  @JsonKey(name: 'foto_capa')
  String? get fotoCapa;
  @override
  @JsonKey(fromJson: nullableDateTimeFromJson)
  DateTime? get dataCriacao;
  @override
  @JsonKey(fromJson: nullableDateTimeFromJson)
  DateTime? get dataUpdate;

  /// Create a copy of GuideDocument
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GuideDocumentImplCopyWith<_$GuideDocumentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$FocusPoint {
  String get titulo => throw _privateConstructorUsedError;
  int? get pagina => throw _privateConstructorUsedError;

  /// Create a copy of FocusPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FocusPointCopyWith<FocusPoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FocusPointCopyWith<$Res> {
  factory $FocusPointCopyWith(
    FocusPoint value,
    $Res Function(FocusPoint) then,
  ) = _$FocusPointCopyWithImpl<$Res, FocusPoint>;
  @useResult
  $Res call({String titulo, int? pagina});
}

/// @nodoc
class _$FocusPointCopyWithImpl<$Res, $Val extends FocusPoint>
    implements $FocusPointCopyWith<$Res> {
  _$FocusPointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FocusPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? titulo = null, Object? pagina = freezed}) {
    return _then(
      _value.copyWith(
            titulo: null == titulo
                ? _value.titulo
                : titulo // ignore: cast_nullable_to_non_nullable
                      as String,
            pagina: freezed == pagina
                ? _value.pagina
                : pagina // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FocusPointImplCopyWith<$Res>
    implements $FocusPointCopyWith<$Res> {
  factory _$$FocusPointImplCopyWith(
    _$FocusPointImpl value,
    $Res Function(_$FocusPointImpl) then,
  ) = __$$FocusPointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String titulo, int? pagina});
}

/// @nodoc
class __$$FocusPointImplCopyWithImpl<$Res>
    extends _$FocusPointCopyWithImpl<$Res, _$FocusPointImpl>
    implements _$$FocusPointImplCopyWith<$Res> {
  __$$FocusPointImplCopyWithImpl(
    _$FocusPointImpl _value,
    $Res Function(_$FocusPointImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FocusPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? titulo = null, Object? pagina = freezed}) {
    return _then(
      _$FocusPointImpl(
        titulo: null == titulo
            ? _value.titulo
            : titulo // ignore: cast_nullable_to_non_nullable
                  as String,
        pagina: freezed == pagina
            ? _value.pagina
            : pagina // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc

class _$FocusPointImpl extends _FocusPoint {
  const _$FocusPointImpl({required this.titulo, this.pagina}) : super._();

  @override
  final String titulo;
  @override
  final int? pagina;

  @override
  String toString() {
    return 'FocusPoint(titulo: $titulo, pagina: $pagina)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FocusPointImpl &&
            (identical(other.titulo, titulo) || other.titulo == titulo) &&
            (identical(other.pagina, pagina) || other.pagina == pagina));
  }

  @override
  int get hashCode => Object.hash(runtimeType, titulo, pagina);

  /// Create a copy of FocusPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FocusPointImplCopyWith<_$FocusPointImpl> get copyWith =>
      __$$FocusPointImplCopyWithImpl<_$FocusPointImpl>(this, _$identity);
}

abstract class _FocusPoint extends FocusPoint {
  const factory _FocusPoint({required final String titulo, final int? pagina}) =
      _$FocusPointImpl;
  const _FocusPoint._() : super._();

  @override
  String get titulo;
  @override
  int? get pagina;

  /// Create a copy of FocusPoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FocusPointImplCopyWith<_$FocusPointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
