// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profession.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Profession _$ProfessionFromJson(Map<String, dynamic> json) {
  return _Profession.fromJson(json);
}

/// @nodoc
mixin _$Profession {
  @JsonKey(fromJson: intFromJson)
  int get id => throw _privateConstructorUsedError;
  String get nome => throw _privateConstructorUsedError;
  String? get descricao => throw _privateConstructorUsedError;
  String? get cor => throw _privateConstructorUsedError;
  @JsonKey(fromJson: nullableIntFromJson)
  int? get status => throw _privateConstructorUsedError;
  @JsonKey(fromJson: nullableDateTimeFromJson)
  DateTime? get dataCriacao => throw _privateConstructorUsedError;
  @JsonKey(fromJson: nullableDateTimeFromJson)
  DateTime? get dataUpdate => throw _privateConstructorUsedError;
  @JsonKey(fromJson: nullableDateTimeFromJson)
  DateTime? get dataDelete => throw _privateConstructorUsedError;

  /// Serializes this Profession to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Profession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfessionCopyWith<Profession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfessionCopyWith<$Res> {
  factory $ProfessionCopyWith(
    Profession value,
    $Res Function(Profession) then,
  ) = _$ProfessionCopyWithImpl<$Res, Profession>;
  @useResult
  $Res call({
    @JsonKey(fromJson: intFromJson) int id,
    String nome,
    String? descricao,
    String? cor,
    @JsonKey(fromJson: nullableIntFromJson) int? status,
    @JsonKey(fromJson: nullableDateTimeFromJson) DateTime? dataCriacao,
    @JsonKey(fromJson: nullableDateTimeFromJson) DateTime? dataUpdate,
    @JsonKey(fromJson: nullableDateTimeFromJson) DateTime? dataDelete,
  });
}

/// @nodoc
class _$ProfessionCopyWithImpl<$Res, $Val extends Profession>
    implements $ProfessionCopyWith<$Res> {
  _$ProfessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Profession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nome = null,
    Object? descricao = freezed,
    Object? cor = freezed,
    Object? status = freezed,
    Object? dataCriacao = freezed,
    Object? dataUpdate = freezed,
    Object? dataDelete = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            nome: null == nome
                ? _value.nome
                : nome // ignore: cast_nullable_to_non_nullable
                      as String,
            descricao: freezed == descricao
                ? _value.descricao
                : descricao // ignore: cast_nullable_to_non_nullable
                      as String?,
            cor: freezed == cor
                ? _value.cor
                : cor // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as int?,
            dataCriacao: freezed == dataCriacao
                ? _value.dataCriacao
                : dataCriacao // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            dataUpdate: freezed == dataUpdate
                ? _value.dataUpdate
                : dataUpdate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            dataDelete: freezed == dataDelete
                ? _value.dataDelete
                : dataDelete // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProfessionImplCopyWith<$Res>
    implements $ProfessionCopyWith<$Res> {
  factory _$$ProfessionImplCopyWith(
    _$ProfessionImpl value,
    $Res Function(_$ProfessionImpl) then,
  ) = __$$ProfessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(fromJson: intFromJson) int id,
    String nome,
    String? descricao,
    String? cor,
    @JsonKey(fromJson: nullableIntFromJson) int? status,
    @JsonKey(fromJson: nullableDateTimeFromJson) DateTime? dataCriacao,
    @JsonKey(fromJson: nullableDateTimeFromJson) DateTime? dataUpdate,
    @JsonKey(fromJson: nullableDateTimeFromJson) DateTime? dataDelete,
  });
}

/// @nodoc
class __$$ProfessionImplCopyWithImpl<$Res>
    extends _$ProfessionCopyWithImpl<$Res, _$ProfessionImpl>
    implements _$$ProfessionImplCopyWith<$Res> {
  __$$ProfessionImplCopyWithImpl(
    _$ProfessionImpl _value,
    $Res Function(_$ProfessionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Profession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nome = null,
    Object? descricao = freezed,
    Object? cor = freezed,
    Object? status = freezed,
    Object? dataCriacao = freezed,
    Object? dataUpdate = freezed,
    Object? dataDelete = freezed,
  }) {
    return _then(
      _$ProfessionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        nome: null == nome
            ? _value.nome
            : nome // ignore: cast_nullable_to_non_nullable
                  as String,
        descricao: freezed == descricao
            ? _value.descricao
            : descricao // ignore: cast_nullable_to_non_nullable
                  as String?,
        cor: freezed == cor
            ? _value.cor
            : cor // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as int?,
        dataCriacao: freezed == dataCriacao
            ? _value.dataCriacao
            : dataCriacao // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        dataUpdate: freezed == dataUpdate
            ? _value.dataUpdate
            : dataUpdate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        dataDelete: freezed == dataDelete
            ? _value.dataDelete
            : dataDelete // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$ProfessionImpl extends _Profession {
  const _$ProfessionImpl({
    @JsonKey(fromJson: intFromJson) required this.id,
    required this.nome,
    this.descricao,
    this.cor,
    @JsonKey(fromJson: nullableIntFromJson) this.status,
    @JsonKey(fromJson: nullableDateTimeFromJson) this.dataCriacao,
    @JsonKey(fromJson: nullableDateTimeFromJson) this.dataUpdate,
    @JsonKey(fromJson: nullableDateTimeFromJson) this.dataDelete,
  }) : super._();

  factory _$ProfessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfessionImplFromJson(json);

  @override
  @JsonKey(fromJson: intFromJson)
  final int id;
  @override
  final String nome;
  @override
  final String? descricao;
  @override
  final String? cor;
  @override
  @JsonKey(fromJson: nullableIntFromJson)
  final int? status;
  @override
  @JsonKey(fromJson: nullableDateTimeFromJson)
  final DateTime? dataCriacao;
  @override
  @JsonKey(fromJson: nullableDateTimeFromJson)
  final DateTime? dataUpdate;
  @override
  @JsonKey(fromJson: nullableDateTimeFromJson)
  final DateTime? dataDelete;

  @override
  String toString() {
    return 'Profession(id: $id, nome: $nome, descricao: $descricao, cor: $cor, status: $status, dataCriacao: $dataCriacao, dataUpdate: $dataUpdate, dataDelete: $dataDelete)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfessionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nome, nome) || other.nome == nome) &&
            (identical(other.descricao, descricao) ||
                other.descricao == descricao) &&
            (identical(other.cor, cor) || other.cor == cor) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.dataCriacao, dataCriacao) ||
                other.dataCriacao == dataCriacao) &&
            (identical(other.dataUpdate, dataUpdate) ||
                other.dataUpdate == dataUpdate) &&
            (identical(other.dataDelete, dataDelete) ||
                other.dataDelete == dataDelete));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    nome,
    descricao,
    cor,
    status,
    dataCriacao,
    dataUpdate,
    dataDelete,
  );

  /// Create a copy of Profession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfessionImplCopyWith<_$ProfessionImpl> get copyWith =>
      __$$ProfessionImplCopyWithImpl<_$ProfessionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfessionImplToJson(this);
  }
}

abstract class _Profession extends Profession {
  const factory _Profession({
    @JsonKey(fromJson: intFromJson) required final int id,
    required final String nome,
    final String? descricao,
    final String? cor,
    @JsonKey(fromJson: nullableIntFromJson) final int? status,
    @JsonKey(fromJson: nullableDateTimeFromJson) final DateTime? dataCriacao,
    @JsonKey(fromJson: nullableDateTimeFromJson) final DateTime? dataUpdate,
    @JsonKey(fromJson: nullableDateTimeFromJson) final DateTime? dataDelete,
  }) = _$ProfessionImpl;
  const _Profession._() : super._();

  factory _Profession.fromJson(Map<String, dynamic> json) =
      _$ProfessionImpl.fromJson;

  @override
  @JsonKey(fromJson: intFromJson)
  int get id;
  @override
  String get nome;
  @override
  String? get descricao;
  @override
  String? get cor;
  @override
  @JsonKey(fromJson: nullableIntFromJson)
  int? get status;
  @override
  @JsonKey(fromJson: nullableDateTimeFromJson)
  DateTime? get dataCriacao;
  @override
  @JsonKey(fromJson: nullableDateTimeFromJson)
  DateTime? get dataUpdate;
  @override
  @JsonKey(fromJson: nullableDateTimeFromJson)
  DateTime? get dataDelete;

  /// Create a copy of Profession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfessionImplCopyWith<_$ProfessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
