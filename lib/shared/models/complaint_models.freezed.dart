// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'complaint_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ComplaintAddress _$ComplaintAddressFromJson(Map<String, dynamic> json) {
  return _ComplaintAddress.fromJson(json);
}

/// @nodoc
mixin _$ComplaintAddress {
  String get cep => throw _privateConstructorUsedError;
  String get rua => throw _privateConstructorUsedError;
  String get numero => throw _privateConstructorUsedError;
  String get estado => throw _privateConstructorUsedError;
  String get cidade => throw _privateConstructorUsedError;
  String get bairro => throw _privateConstructorUsedError;
  @JsonKey(fromJson: nullableIntFromJson)
  int? get conselhoId => throw _privateConstructorUsedError;
  String? get conselhoNome => throw _privateConstructorUsedError;
  String? get conselhoContato => throw _privateConstructorUsedError;
  String? get conselhoRegiao => throw _privateConstructorUsedError;
  String? get validatedCep => throw _privateConstructorUsedError;

  /// Serializes this ComplaintAddress to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ComplaintAddress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ComplaintAddressCopyWith<ComplaintAddress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ComplaintAddressCopyWith<$Res> {
  factory $ComplaintAddressCopyWith(
    ComplaintAddress value,
    $Res Function(ComplaintAddress) then,
  ) = _$ComplaintAddressCopyWithImpl<$Res, ComplaintAddress>;
  @useResult
  $Res call({
    String cep,
    String rua,
    String numero,
    String estado,
    String cidade,
    String bairro,
    @JsonKey(fromJson: nullableIntFromJson) int? conselhoId,
    String? conselhoNome,
    String? conselhoContato,
    String? conselhoRegiao,
    String? validatedCep,
  });
}

/// @nodoc
class _$ComplaintAddressCopyWithImpl<$Res, $Val extends ComplaintAddress>
    implements $ComplaintAddressCopyWith<$Res> {
  _$ComplaintAddressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ComplaintAddress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cep = null,
    Object? rua = null,
    Object? numero = null,
    Object? estado = null,
    Object? cidade = null,
    Object? bairro = null,
    Object? conselhoId = freezed,
    Object? conselhoNome = freezed,
    Object? conselhoContato = freezed,
    Object? conselhoRegiao = freezed,
    Object? validatedCep = freezed,
  }) {
    return _then(
      _value.copyWith(
            cep: null == cep
                ? _value.cep
                : cep // ignore: cast_nullable_to_non_nullable
                      as String,
            rua: null == rua
                ? _value.rua
                : rua // ignore: cast_nullable_to_non_nullable
                      as String,
            numero: null == numero
                ? _value.numero
                : numero // ignore: cast_nullable_to_non_nullable
                      as String,
            estado: null == estado
                ? _value.estado
                : estado // ignore: cast_nullable_to_non_nullable
                      as String,
            cidade: null == cidade
                ? _value.cidade
                : cidade // ignore: cast_nullable_to_non_nullable
                      as String,
            bairro: null == bairro
                ? _value.bairro
                : bairro // ignore: cast_nullable_to_non_nullable
                      as String,
            conselhoId: freezed == conselhoId
                ? _value.conselhoId
                : conselhoId // ignore: cast_nullable_to_non_nullable
                      as int?,
            conselhoNome: freezed == conselhoNome
                ? _value.conselhoNome
                : conselhoNome // ignore: cast_nullable_to_non_nullable
                      as String?,
            conselhoContato: freezed == conselhoContato
                ? _value.conselhoContato
                : conselhoContato // ignore: cast_nullable_to_non_nullable
                      as String?,
            conselhoRegiao: freezed == conselhoRegiao
                ? _value.conselhoRegiao
                : conselhoRegiao // ignore: cast_nullable_to_non_nullable
                      as String?,
            validatedCep: freezed == validatedCep
                ? _value.validatedCep
                : validatedCep // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ComplaintAddressImplCopyWith<$Res>
    implements $ComplaintAddressCopyWith<$Res> {
  factory _$$ComplaintAddressImplCopyWith(
    _$ComplaintAddressImpl value,
    $Res Function(_$ComplaintAddressImpl) then,
  ) = __$$ComplaintAddressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String cep,
    String rua,
    String numero,
    String estado,
    String cidade,
    String bairro,
    @JsonKey(fromJson: nullableIntFromJson) int? conselhoId,
    String? conselhoNome,
    String? conselhoContato,
    String? conselhoRegiao,
    String? validatedCep,
  });
}

/// @nodoc
class __$$ComplaintAddressImplCopyWithImpl<$Res>
    extends _$ComplaintAddressCopyWithImpl<$Res, _$ComplaintAddressImpl>
    implements _$$ComplaintAddressImplCopyWith<$Res> {
  __$$ComplaintAddressImplCopyWithImpl(
    _$ComplaintAddressImpl _value,
    $Res Function(_$ComplaintAddressImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ComplaintAddress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cep = null,
    Object? rua = null,
    Object? numero = null,
    Object? estado = null,
    Object? cidade = null,
    Object? bairro = null,
    Object? conselhoId = freezed,
    Object? conselhoNome = freezed,
    Object? conselhoContato = freezed,
    Object? conselhoRegiao = freezed,
    Object? validatedCep = freezed,
  }) {
    return _then(
      _$ComplaintAddressImpl(
        cep: null == cep
            ? _value.cep
            : cep // ignore: cast_nullable_to_non_nullable
                  as String,
        rua: null == rua
            ? _value.rua
            : rua // ignore: cast_nullable_to_non_nullable
                  as String,
        numero: null == numero
            ? _value.numero
            : numero // ignore: cast_nullable_to_non_nullable
                  as String,
        estado: null == estado
            ? _value.estado
            : estado // ignore: cast_nullable_to_non_nullable
                  as String,
        cidade: null == cidade
            ? _value.cidade
            : cidade // ignore: cast_nullable_to_non_nullable
                  as String,
        bairro: null == bairro
            ? _value.bairro
            : bairro // ignore: cast_nullable_to_non_nullable
                  as String,
        conselhoId: freezed == conselhoId
            ? _value.conselhoId
            : conselhoId // ignore: cast_nullable_to_non_nullable
                  as int?,
        conselhoNome: freezed == conselhoNome
            ? _value.conselhoNome
            : conselhoNome // ignore: cast_nullable_to_non_nullable
                  as String?,
        conselhoContato: freezed == conselhoContato
            ? _value.conselhoContato
            : conselhoContato // ignore: cast_nullable_to_non_nullable
                  as String?,
        conselhoRegiao: freezed == conselhoRegiao
            ? _value.conselhoRegiao
            : conselhoRegiao // ignore: cast_nullable_to_non_nullable
                  as String?,
        validatedCep: freezed == validatedCep
            ? _value.validatedCep
            : validatedCep // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ComplaintAddressImpl extends _ComplaintAddress {
  const _$ComplaintAddressImpl({
    this.cep = '',
    this.rua = '',
    this.numero = '',
    this.estado = '',
    this.cidade = '',
    this.bairro = '',
    @JsonKey(fromJson: nullableIntFromJson) this.conselhoId,
    this.conselhoNome,
    this.conselhoContato,
    this.conselhoRegiao,
    this.validatedCep,
  }) : super._();

  factory _$ComplaintAddressImpl.fromJson(Map<String, dynamic> json) =>
      _$$ComplaintAddressImplFromJson(json);

  @override
  @JsonKey()
  final String cep;
  @override
  @JsonKey()
  final String rua;
  @override
  @JsonKey()
  final String numero;
  @override
  @JsonKey()
  final String estado;
  @override
  @JsonKey()
  final String cidade;
  @override
  @JsonKey()
  final String bairro;
  @override
  @JsonKey(fromJson: nullableIntFromJson)
  final int? conselhoId;
  @override
  final String? conselhoNome;
  @override
  final String? conselhoContato;
  @override
  final String? conselhoRegiao;
  @override
  final String? validatedCep;

  @override
  String toString() {
    return 'ComplaintAddress(cep: $cep, rua: $rua, numero: $numero, estado: $estado, cidade: $cidade, bairro: $bairro, conselhoId: $conselhoId, conselhoNome: $conselhoNome, conselhoContato: $conselhoContato, conselhoRegiao: $conselhoRegiao, validatedCep: $validatedCep)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ComplaintAddressImpl &&
            (identical(other.cep, cep) || other.cep == cep) &&
            (identical(other.rua, rua) || other.rua == rua) &&
            (identical(other.numero, numero) || other.numero == numero) &&
            (identical(other.estado, estado) || other.estado == estado) &&
            (identical(other.cidade, cidade) || other.cidade == cidade) &&
            (identical(other.bairro, bairro) || other.bairro == bairro) &&
            (identical(other.conselhoId, conselhoId) ||
                other.conselhoId == conselhoId) &&
            (identical(other.conselhoNome, conselhoNome) ||
                other.conselhoNome == conselhoNome) &&
            (identical(other.conselhoContato, conselhoContato) ||
                other.conselhoContato == conselhoContato) &&
            (identical(other.conselhoRegiao, conselhoRegiao) ||
                other.conselhoRegiao == conselhoRegiao) &&
            (identical(other.validatedCep, validatedCep) ||
                other.validatedCep == validatedCep));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    cep,
    rua,
    numero,
    estado,
    cidade,
    bairro,
    conselhoId,
    conselhoNome,
    conselhoContato,
    conselhoRegiao,
    validatedCep,
  );

  /// Create a copy of ComplaintAddress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ComplaintAddressImplCopyWith<_$ComplaintAddressImpl> get copyWith =>
      __$$ComplaintAddressImplCopyWithImpl<_$ComplaintAddressImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ComplaintAddressImplToJson(this);
  }
}

abstract class _ComplaintAddress extends ComplaintAddress {
  const factory _ComplaintAddress({
    final String cep,
    final String rua,
    final String numero,
    final String estado,
    final String cidade,
    final String bairro,
    @JsonKey(fromJson: nullableIntFromJson) final int? conselhoId,
    final String? conselhoNome,
    final String? conselhoContato,
    final String? conselhoRegiao,
    final String? validatedCep,
  }) = _$ComplaintAddressImpl;
  const _ComplaintAddress._() : super._();

  factory _ComplaintAddress.fromJson(Map<String, dynamic> json) =
      _$ComplaintAddressImpl.fromJson;

  @override
  String get cep;
  @override
  String get rua;
  @override
  String get numero;
  @override
  String get estado;
  @override
  String get cidade;
  @override
  String get bairro;
  @override
  @JsonKey(fromJson: nullableIntFromJson)
  int? get conselhoId;
  @override
  String? get conselhoNome;
  @override
  String? get conselhoContato;
  @override
  String? get conselhoRegiao;
  @override
  String? get validatedCep;

  /// Create a copy of ComplaintAddress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ComplaintAddressImplCopyWith<_$ComplaintAddressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PhotoRef _$PhotoRefFromJson(Map<String, dynamic> json) {
  return _PhotoRef.fromJson(json);
}

/// @nodoc
mixin _$PhotoRef {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get mimeType => throw _privateConstructorUsedError;
  int get sizeBytes => throw _privateConstructorUsedError;
  String get localPath => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this PhotoRef to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PhotoRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PhotoRefCopyWith<PhotoRef> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhotoRefCopyWith<$Res> {
  factory $PhotoRefCopyWith(PhotoRef value, $Res Function(PhotoRef) then) =
      _$PhotoRefCopyWithImpl<$Res, PhotoRef>;
  @useResult
  $Res call({
    String id,
    String name,
    String mimeType,
    int sizeBytes,
    String localPath,
    DateTime createdAt,
  });
}

/// @nodoc
class _$PhotoRefCopyWithImpl<$Res, $Val extends PhotoRef>
    implements $PhotoRefCopyWith<$Res> {
  _$PhotoRefCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PhotoRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? mimeType = null,
    Object? sizeBytes = null,
    Object? localPath = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            mimeType: null == mimeType
                ? _value.mimeType
                : mimeType // ignore: cast_nullable_to_non_nullable
                      as String,
            sizeBytes: null == sizeBytes
                ? _value.sizeBytes
                : sizeBytes // ignore: cast_nullable_to_non_nullable
                      as int,
            localPath: null == localPath
                ? _value.localPath
                : localPath // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PhotoRefImplCopyWith<$Res>
    implements $PhotoRefCopyWith<$Res> {
  factory _$$PhotoRefImplCopyWith(
    _$PhotoRefImpl value,
    $Res Function(_$PhotoRefImpl) then,
  ) = __$$PhotoRefImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String mimeType,
    int sizeBytes,
    String localPath,
    DateTime createdAt,
  });
}

/// @nodoc
class __$$PhotoRefImplCopyWithImpl<$Res>
    extends _$PhotoRefCopyWithImpl<$Res, _$PhotoRefImpl>
    implements _$$PhotoRefImplCopyWith<$Res> {
  __$$PhotoRefImplCopyWithImpl(
    _$PhotoRefImpl _value,
    $Res Function(_$PhotoRefImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PhotoRef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? mimeType = null,
    Object? sizeBytes = null,
    Object? localPath = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$PhotoRefImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        mimeType: null == mimeType
            ? _value.mimeType
            : mimeType // ignore: cast_nullable_to_non_nullable
                  as String,
        sizeBytes: null == sizeBytes
            ? _value.sizeBytes
            : sizeBytes // ignore: cast_nullable_to_non_nullable
                  as int,
        localPath: null == localPath
            ? _value.localPath
            : localPath // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PhotoRefImpl implements _PhotoRef {
  const _$PhotoRefImpl({
    required this.id,
    required this.name,
    required this.mimeType,
    required this.sizeBytes,
    required this.localPath,
    required this.createdAt,
  });

  factory _$PhotoRefImpl.fromJson(Map<String, dynamic> json) =>
      _$$PhotoRefImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String mimeType;
  @override
  final int sizeBytes;
  @override
  final String localPath;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'PhotoRef(id: $id, name: $name, mimeType: $mimeType, sizeBytes: $sizeBytes, localPath: $localPath, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhotoRefImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.mimeType, mimeType) ||
                other.mimeType == mimeType) &&
            (identical(other.sizeBytes, sizeBytes) ||
                other.sizeBytes == sizeBytes) &&
            (identical(other.localPath, localPath) ||
                other.localPath == localPath) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    mimeType,
    sizeBytes,
    localPath,
    createdAt,
  );

  /// Create a copy of PhotoRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PhotoRefImplCopyWith<_$PhotoRefImpl> get copyWith =>
      __$$PhotoRefImplCopyWithImpl<_$PhotoRefImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PhotoRefImplToJson(this);
  }
}

abstract class _PhotoRef implements PhotoRef {
  const factory _PhotoRef({
    required final String id,
    required final String name,
    required final String mimeType,
    required final int sizeBytes,
    required final String localPath,
    required final DateTime createdAt,
  }) = _$PhotoRefImpl;

  factory _PhotoRef.fromJson(Map<String, dynamic> json) =
      _$PhotoRefImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get mimeType;
  @override
  int get sizeBytes;
  @override
  String get localPath;
  @override
  DateTime get createdAt;

  /// Create a copy of PhotoRef
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PhotoRefImplCopyWith<_$PhotoRefImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ComplaintDraft _$ComplaintDraftFromJson(Map<String, dynamic> json) {
  return _ComplaintDraft.fromJson(json);
}

/// @nodoc
mixin _$ComplaintDraft {
  int get professionId => throw _privateConstructorUsedError;
  ComplaintAddress? get address => throw _privateConstructorUsedError;
  Map<String, Map<String, dynamic>> get dynamicAnswers =>
      throw _privateConstructorUsedError;
  Map<String, List<PhotoRef>> get photoRefs =>
      throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this ComplaintDraft to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ComplaintDraft
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ComplaintDraftCopyWith<ComplaintDraft> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ComplaintDraftCopyWith<$Res> {
  factory $ComplaintDraftCopyWith(
    ComplaintDraft value,
    $Res Function(ComplaintDraft) then,
  ) = _$ComplaintDraftCopyWithImpl<$Res, ComplaintDraft>;
  @useResult
  $Res call({
    int professionId,
    ComplaintAddress? address,
    Map<String, Map<String, dynamic>> dynamicAnswers,
    Map<String, List<PhotoRef>> photoRefs,
    DateTime updatedAt,
  });

  $ComplaintAddressCopyWith<$Res>? get address;
}

/// @nodoc
class _$ComplaintDraftCopyWithImpl<$Res, $Val extends ComplaintDraft>
    implements $ComplaintDraftCopyWith<$Res> {
  _$ComplaintDraftCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ComplaintDraft
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? professionId = null,
    Object? address = freezed,
    Object? dynamicAnswers = null,
    Object? photoRefs = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            professionId: null == professionId
                ? _value.professionId
                : professionId // ignore: cast_nullable_to_non_nullable
                      as int,
            address: freezed == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as ComplaintAddress?,
            dynamicAnswers: null == dynamicAnswers
                ? _value.dynamicAnswers
                : dynamicAnswers // ignore: cast_nullable_to_non_nullable
                      as Map<String, Map<String, dynamic>>,
            photoRefs: null == photoRefs
                ? _value.photoRefs
                : photoRefs // ignore: cast_nullable_to_non_nullable
                      as Map<String, List<PhotoRef>>,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }

  /// Create a copy of ComplaintDraft
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ComplaintAddressCopyWith<$Res>? get address {
    if (_value.address == null) {
      return null;
    }

    return $ComplaintAddressCopyWith<$Res>(_value.address!, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ComplaintDraftImplCopyWith<$Res>
    implements $ComplaintDraftCopyWith<$Res> {
  factory _$$ComplaintDraftImplCopyWith(
    _$ComplaintDraftImpl value,
    $Res Function(_$ComplaintDraftImpl) then,
  ) = __$$ComplaintDraftImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int professionId,
    ComplaintAddress? address,
    Map<String, Map<String, dynamic>> dynamicAnswers,
    Map<String, List<PhotoRef>> photoRefs,
    DateTime updatedAt,
  });

  @override
  $ComplaintAddressCopyWith<$Res>? get address;
}

/// @nodoc
class __$$ComplaintDraftImplCopyWithImpl<$Res>
    extends _$ComplaintDraftCopyWithImpl<$Res, _$ComplaintDraftImpl>
    implements _$$ComplaintDraftImplCopyWith<$Res> {
  __$$ComplaintDraftImplCopyWithImpl(
    _$ComplaintDraftImpl _value,
    $Res Function(_$ComplaintDraftImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ComplaintDraft
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? professionId = null,
    Object? address = freezed,
    Object? dynamicAnswers = null,
    Object? photoRefs = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$ComplaintDraftImpl(
        professionId: null == professionId
            ? _value.professionId
            : professionId // ignore: cast_nullable_to_non_nullable
                  as int,
        address: freezed == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as ComplaintAddress?,
        dynamicAnswers: null == dynamicAnswers
            ? _value._dynamicAnswers
            : dynamicAnswers // ignore: cast_nullable_to_non_nullable
                  as Map<String, Map<String, dynamic>>,
        photoRefs: null == photoRefs
            ? _value._photoRefs
            : photoRefs // ignore: cast_nullable_to_non_nullable
                  as Map<String, List<PhotoRef>>,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ComplaintDraftImpl implements _ComplaintDraft {
  const _$ComplaintDraftImpl({
    required this.professionId,
    this.address,
    final Map<String, Map<String, dynamic>> dynamicAnswers =
        const <String, Map<String, dynamic>>{},
    final Map<String, List<PhotoRef>> photoRefs =
        const <String, List<PhotoRef>>{},
    required this.updatedAt,
  }) : _dynamicAnswers = dynamicAnswers,
       _photoRefs = photoRefs;

  factory _$ComplaintDraftImpl.fromJson(Map<String, dynamic> json) =>
      _$$ComplaintDraftImplFromJson(json);

  @override
  final int professionId;
  @override
  final ComplaintAddress? address;
  final Map<String, Map<String, dynamic>> _dynamicAnswers;
  @override
  @JsonKey()
  Map<String, Map<String, dynamic>> get dynamicAnswers {
    if (_dynamicAnswers is EqualUnmodifiableMapView) return _dynamicAnswers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_dynamicAnswers);
  }

  final Map<String, List<PhotoRef>> _photoRefs;
  @override
  @JsonKey()
  Map<String, List<PhotoRef>> get photoRefs {
    if (_photoRefs is EqualUnmodifiableMapView) return _photoRefs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_photoRefs);
  }

  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'ComplaintDraft(professionId: $professionId, address: $address, dynamicAnswers: $dynamicAnswers, photoRefs: $photoRefs, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ComplaintDraftImpl &&
            (identical(other.professionId, professionId) ||
                other.professionId == professionId) &&
            (identical(other.address, address) || other.address == address) &&
            const DeepCollectionEquality().equals(
              other._dynamicAnswers,
              _dynamicAnswers,
            ) &&
            const DeepCollectionEquality().equals(
              other._photoRefs,
              _photoRefs,
            ) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    professionId,
    address,
    const DeepCollectionEquality().hash(_dynamicAnswers),
    const DeepCollectionEquality().hash(_photoRefs),
    updatedAt,
  );

  /// Create a copy of ComplaintDraft
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ComplaintDraftImplCopyWith<_$ComplaintDraftImpl> get copyWith =>
      __$$ComplaintDraftImplCopyWithImpl<_$ComplaintDraftImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ComplaintDraftImplToJson(this);
  }
}

abstract class _ComplaintDraft implements ComplaintDraft {
  const factory _ComplaintDraft({
    required final int professionId,
    final ComplaintAddress? address,
    final Map<String, Map<String, dynamic>> dynamicAnswers,
    final Map<String, List<PhotoRef>> photoRefs,
    required final DateTime updatedAt,
  }) = _$ComplaintDraftImpl;

  factory _ComplaintDraft.fromJson(Map<String, dynamic> json) =
      _$ComplaintDraftImpl.fromJson;

  @override
  int get professionId;
  @override
  ComplaintAddress? get address;
  @override
  Map<String, Map<String, dynamic>> get dynamicAnswers;
  @override
  Map<String, List<PhotoRef>> get photoRefs;
  @override
  DateTime get updatedAt;

  /// Create a copy of ComplaintDraft
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ComplaintDraftImplCopyWith<_$ComplaintDraftImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ConfirmationRecord _$ConfirmationRecordFromJson(Map<String, dynamic> json) {
  return _ConfirmationRecord.fromJson(json);
}

/// @nodoc
mixin _$ConfirmationRecord {
  String get protocol => throw _privateConstructorUsedError;
  String get pdfPath => throw _privateConstructorUsedError;
  DateTime get sentAt => throw _privateConstructorUsedError;
  int get professionId => throw _privateConstructorUsedError;
  String get professionName => throw _privateConstructorUsedError;
  String? get councilName => throw _privateConstructorUsedError;

  /// Serializes this ConfirmationRecord to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConfirmationRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConfirmationRecordCopyWith<ConfirmationRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfirmationRecordCopyWith<$Res> {
  factory $ConfirmationRecordCopyWith(
    ConfirmationRecord value,
    $Res Function(ConfirmationRecord) then,
  ) = _$ConfirmationRecordCopyWithImpl<$Res, ConfirmationRecord>;
  @useResult
  $Res call({
    String protocol,
    String pdfPath,
    DateTime sentAt,
    int professionId,
    String professionName,
    String? councilName,
  });
}

/// @nodoc
class _$ConfirmationRecordCopyWithImpl<$Res, $Val extends ConfirmationRecord>
    implements $ConfirmationRecordCopyWith<$Res> {
  _$ConfirmationRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConfirmationRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? protocol = null,
    Object? pdfPath = null,
    Object? sentAt = null,
    Object? professionId = null,
    Object? professionName = null,
    Object? councilName = freezed,
  }) {
    return _then(
      _value.copyWith(
            protocol: null == protocol
                ? _value.protocol
                : protocol // ignore: cast_nullable_to_non_nullable
                      as String,
            pdfPath: null == pdfPath
                ? _value.pdfPath
                : pdfPath // ignore: cast_nullable_to_non_nullable
                      as String,
            sentAt: null == sentAt
                ? _value.sentAt
                : sentAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            professionId: null == professionId
                ? _value.professionId
                : professionId // ignore: cast_nullable_to_non_nullable
                      as int,
            professionName: null == professionName
                ? _value.professionName
                : professionName // ignore: cast_nullable_to_non_nullable
                      as String,
            councilName: freezed == councilName
                ? _value.councilName
                : councilName // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ConfirmationRecordImplCopyWith<$Res>
    implements $ConfirmationRecordCopyWith<$Res> {
  factory _$$ConfirmationRecordImplCopyWith(
    _$ConfirmationRecordImpl value,
    $Res Function(_$ConfirmationRecordImpl) then,
  ) = __$$ConfirmationRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String protocol,
    String pdfPath,
    DateTime sentAt,
    int professionId,
    String professionName,
    String? councilName,
  });
}

/// @nodoc
class __$$ConfirmationRecordImplCopyWithImpl<$Res>
    extends _$ConfirmationRecordCopyWithImpl<$Res, _$ConfirmationRecordImpl>
    implements _$$ConfirmationRecordImplCopyWith<$Res> {
  __$$ConfirmationRecordImplCopyWithImpl(
    _$ConfirmationRecordImpl _value,
    $Res Function(_$ConfirmationRecordImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConfirmationRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? protocol = null,
    Object? pdfPath = null,
    Object? sentAt = null,
    Object? professionId = null,
    Object? professionName = null,
    Object? councilName = freezed,
  }) {
    return _then(
      _$ConfirmationRecordImpl(
        protocol: null == protocol
            ? _value.protocol
            : protocol // ignore: cast_nullable_to_non_nullable
                  as String,
        pdfPath: null == pdfPath
            ? _value.pdfPath
            : pdfPath // ignore: cast_nullable_to_non_nullable
                  as String,
        sentAt: null == sentAt
            ? _value.sentAt
            : sentAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        professionId: null == professionId
            ? _value.professionId
            : professionId // ignore: cast_nullable_to_non_nullable
                  as int,
        professionName: null == professionName
            ? _value.professionName
            : professionName // ignore: cast_nullable_to_non_nullable
                  as String,
        councilName: freezed == councilName
            ? _value.councilName
            : councilName // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ConfirmationRecordImpl implements _ConfirmationRecord {
  const _$ConfirmationRecordImpl({
    required this.protocol,
    required this.pdfPath,
    required this.sentAt,
    required this.professionId,
    required this.professionName,
    this.councilName,
  });

  factory _$ConfirmationRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConfirmationRecordImplFromJson(json);

  @override
  final String protocol;
  @override
  final String pdfPath;
  @override
  final DateTime sentAt;
  @override
  final int professionId;
  @override
  final String professionName;
  @override
  final String? councilName;

  @override
  String toString() {
    return 'ConfirmationRecord(protocol: $protocol, pdfPath: $pdfPath, sentAt: $sentAt, professionId: $professionId, professionName: $professionName, councilName: $councilName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfirmationRecordImpl &&
            (identical(other.protocol, protocol) ||
                other.protocol == protocol) &&
            (identical(other.pdfPath, pdfPath) || other.pdfPath == pdfPath) &&
            (identical(other.sentAt, sentAt) || other.sentAt == sentAt) &&
            (identical(other.professionId, professionId) ||
                other.professionId == professionId) &&
            (identical(other.professionName, professionName) ||
                other.professionName == professionName) &&
            (identical(other.councilName, councilName) ||
                other.councilName == councilName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    protocol,
    pdfPath,
    sentAt,
    professionId,
    professionName,
    councilName,
  );

  /// Create a copy of ConfirmationRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfirmationRecordImplCopyWith<_$ConfirmationRecordImpl> get copyWith =>
      __$$ConfirmationRecordImplCopyWithImpl<_$ConfirmationRecordImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ConfirmationRecordImplToJson(this);
  }
}

abstract class _ConfirmationRecord implements ConfirmationRecord {
  const factory _ConfirmationRecord({
    required final String protocol,
    required final String pdfPath,
    required final DateTime sentAt,
    required final int professionId,
    required final String professionName,
    final String? councilName,
  }) = _$ConfirmationRecordImpl;

  factory _ConfirmationRecord.fromJson(Map<String, dynamic> json) =
      _$ConfirmationRecordImpl.fromJson;

  @override
  String get protocol;
  @override
  String get pdfPath;
  @override
  DateTime get sentAt;
  @override
  int get professionId;
  @override
  String get professionName;
  @override
  String? get councilName;

  /// Create a copy of ConfirmationRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConfirmationRecordImplCopyWith<_$ConfirmationRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
