// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cep_validation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AddressData _$AddressDataFromJson(Map<String, dynamic> json) {
  return _AddressData.fromJson(json);
}

/// @nodoc
mixin _$AddressData {
  String get cep => throw _privateConstructorUsedError;
  String get estado => throw _privateConstructorUsedError;
  String get cidade => throw _privateConstructorUsedError;
  String get bairro => throw _privateConstructorUsedError;
  @JsonKey(name: 'logradouro')
  String? get logradouro => throw _privateConstructorUsedError;
  @JsonKey(name: 'rua')
  String? get rua => throw _privateConstructorUsedError;

  /// Serializes this AddressData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AddressData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddressDataCopyWith<AddressData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressDataCopyWith<$Res> {
  factory $AddressDataCopyWith(
    AddressData value,
    $Res Function(AddressData) then,
  ) = _$AddressDataCopyWithImpl<$Res, AddressData>;
  @useResult
  $Res call({
    String cep,
    String estado,
    String cidade,
    String bairro,
    @JsonKey(name: 'logradouro') String? logradouro,
    @JsonKey(name: 'rua') String? rua,
  });
}

/// @nodoc
class _$AddressDataCopyWithImpl<$Res, $Val extends AddressData>
    implements $AddressDataCopyWith<$Res> {
  _$AddressDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddressData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cep = null,
    Object? estado = null,
    Object? cidade = null,
    Object? bairro = null,
    Object? logradouro = freezed,
    Object? rua = freezed,
  }) {
    return _then(
      _value.copyWith(
            cep: null == cep
                ? _value.cep
                : cep // ignore: cast_nullable_to_non_nullable
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
            logradouro: freezed == logradouro
                ? _value.logradouro
                : logradouro // ignore: cast_nullable_to_non_nullable
                      as String?,
            rua: freezed == rua
                ? _value.rua
                : rua // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AddressDataImplCopyWith<$Res>
    implements $AddressDataCopyWith<$Res> {
  factory _$$AddressDataImplCopyWith(
    _$AddressDataImpl value,
    $Res Function(_$AddressDataImpl) then,
  ) = __$$AddressDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String cep,
    String estado,
    String cidade,
    String bairro,
    @JsonKey(name: 'logradouro') String? logradouro,
    @JsonKey(name: 'rua') String? rua,
  });
}

/// @nodoc
class __$$AddressDataImplCopyWithImpl<$Res>
    extends _$AddressDataCopyWithImpl<$Res, _$AddressDataImpl>
    implements _$$AddressDataImplCopyWith<$Res> {
  __$$AddressDataImplCopyWithImpl(
    _$AddressDataImpl _value,
    $Res Function(_$AddressDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AddressData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cep = null,
    Object? estado = null,
    Object? cidade = null,
    Object? bairro = null,
    Object? logradouro = freezed,
    Object? rua = freezed,
  }) {
    return _then(
      _$AddressDataImpl(
        cep: null == cep
            ? _value.cep
            : cep // ignore: cast_nullable_to_non_nullable
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
        logradouro: freezed == logradouro
            ? _value.logradouro
            : logradouro // ignore: cast_nullable_to_non_nullable
                  as String?,
        rua: freezed == rua
            ? _value.rua
            : rua // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AddressDataImpl extends _AddressData {
  const _$AddressDataImpl({
    required this.cep,
    required this.estado,
    required this.cidade,
    required this.bairro,
    @JsonKey(name: 'logradouro') this.logradouro,
    @JsonKey(name: 'rua') this.rua,
  }) : super._();

  factory _$AddressDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddressDataImplFromJson(json);

  @override
  final String cep;
  @override
  final String estado;
  @override
  final String cidade;
  @override
  final String bairro;
  @override
  @JsonKey(name: 'logradouro')
  final String? logradouro;
  @override
  @JsonKey(name: 'rua')
  final String? rua;

  @override
  String toString() {
    return 'AddressData(cep: $cep, estado: $estado, cidade: $cidade, bairro: $bairro, logradouro: $logradouro, rua: $rua)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddressDataImpl &&
            (identical(other.cep, cep) || other.cep == cep) &&
            (identical(other.estado, estado) || other.estado == estado) &&
            (identical(other.cidade, cidade) || other.cidade == cidade) &&
            (identical(other.bairro, bairro) || other.bairro == bairro) &&
            (identical(other.logradouro, logradouro) ||
                other.logradouro == logradouro) &&
            (identical(other.rua, rua) || other.rua == rua));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, cep, estado, cidade, bairro, logradouro, rua);

  /// Create a copy of AddressData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddressDataImplCopyWith<_$AddressDataImpl> get copyWith =>
      __$$AddressDataImplCopyWithImpl<_$AddressDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddressDataImplToJson(this);
  }
}

abstract class _AddressData extends AddressData {
  const factory _AddressData({
    required final String cep,
    required final String estado,
    required final String cidade,
    required final String bairro,
    @JsonKey(name: 'logradouro') final String? logradouro,
    @JsonKey(name: 'rua') final String? rua,
  }) = _$AddressDataImpl;
  const _AddressData._() : super._();

  factory _AddressData.fromJson(Map<String, dynamic> json) =
      _$AddressDataImpl.fromJson;

  @override
  String get cep;
  @override
  String get estado;
  @override
  String get cidade;
  @override
  String get bairro;
  @override
  @JsonKey(name: 'logradouro')
  String? get logradouro;
  @override
  @JsonKey(name: 'rua')
  String? get rua;

  /// Create a copy of AddressData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddressDataImplCopyWith<_$AddressDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CouncilData _$CouncilDataFromJson(Map<String, dynamic> json) {
  return _CouncilData.fromJson(json);
}

/// @nodoc
mixin _$CouncilData {
  @JsonKey(fromJson: intFromJson)
  int get id => throw _privateConstructorUsedError;
  String get nome => throw _privateConstructorUsedError;
  String? get contato => throw _privateConstructorUsedError;
  String? get regiao => throw _privateConstructorUsedError;

  /// Serializes this CouncilData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CouncilData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CouncilDataCopyWith<CouncilData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CouncilDataCopyWith<$Res> {
  factory $CouncilDataCopyWith(
    CouncilData value,
    $Res Function(CouncilData) then,
  ) = _$CouncilDataCopyWithImpl<$Res, CouncilData>;
  @useResult
  $Res call({
    @JsonKey(fromJson: intFromJson) int id,
    String nome,
    String? contato,
    String? regiao,
  });
}

/// @nodoc
class _$CouncilDataCopyWithImpl<$Res, $Val extends CouncilData>
    implements $CouncilDataCopyWith<$Res> {
  _$CouncilDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CouncilData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nome = null,
    Object? contato = freezed,
    Object? regiao = freezed,
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
            contato: freezed == contato
                ? _value.contato
                : contato // ignore: cast_nullable_to_non_nullable
                      as String?,
            regiao: freezed == regiao
                ? _value.regiao
                : regiao // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CouncilDataImplCopyWith<$Res>
    implements $CouncilDataCopyWith<$Res> {
  factory _$$CouncilDataImplCopyWith(
    _$CouncilDataImpl value,
    $Res Function(_$CouncilDataImpl) then,
  ) = __$$CouncilDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(fromJson: intFromJson) int id,
    String nome,
    String? contato,
    String? regiao,
  });
}

/// @nodoc
class __$$CouncilDataImplCopyWithImpl<$Res>
    extends _$CouncilDataCopyWithImpl<$Res, _$CouncilDataImpl>
    implements _$$CouncilDataImplCopyWith<$Res> {
  __$$CouncilDataImplCopyWithImpl(
    _$CouncilDataImpl _value,
    $Res Function(_$CouncilDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CouncilData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nome = null,
    Object? contato = freezed,
    Object? regiao = freezed,
  }) {
    return _then(
      _$CouncilDataImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        nome: null == nome
            ? _value.nome
            : nome // ignore: cast_nullable_to_non_nullable
                  as String,
        contato: freezed == contato
            ? _value.contato
            : contato // ignore: cast_nullable_to_non_nullable
                  as String?,
        regiao: freezed == regiao
            ? _value.regiao
            : regiao // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CouncilDataImpl implements _CouncilData {
  const _$CouncilDataImpl({
    @JsonKey(fromJson: intFromJson) required this.id,
    required this.nome,
    this.contato,
    this.regiao,
  });

  factory _$CouncilDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$CouncilDataImplFromJson(json);

  @override
  @JsonKey(fromJson: intFromJson)
  final int id;
  @override
  final String nome;
  @override
  final String? contato;
  @override
  final String? regiao;

  @override
  String toString() {
    return 'CouncilData(id: $id, nome: $nome, contato: $contato, regiao: $regiao)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CouncilDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nome, nome) || other.nome == nome) &&
            (identical(other.contato, contato) || other.contato == contato) &&
            (identical(other.regiao, regiao) || other.regiao == regiao));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, nome, contato, regiao);

  /// Create a copy of CouncilData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CouncilDataImplCopyWith<_$CouncilDataImpl> get copyWith =>
      __$$CouncilDataImplCopyWithImpl<_$CouncilDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CouncilDataImplToJson(this);
  }
}

abstract class _CouncilData implements CouncilData {
  const factory _CouncilData({
    @JsonKey(fromJson: intFromJson) required final int id,
    required final String nome,
    final String? contato,
    final String? regiao,
  }) = _$CouncilDataImpl;

  factory _CouncilData.fromJson(Map<String, dynamic> json) =
      _$CouncilDataImpl.fromJson;

  @override
  @JsonKey(fromJson: intFromJson)
  int get id;
  @override
  String get nome;
  @override
  String? get contato;
  @override
  String? get regiao;

  /// Create a copy of CouncilData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CouncilDataImplCopyWith<_$CouncilDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CepValidationResult {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AddressData endereco, CouncilData conselho)
    allowed,
    required TResult Function(String codigo, String mensagem) blocked,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AddressData endereco, CouncilData conselho)? allowed,
    TResult? Function(String codigo, String mensagem)? blocked,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AddressData endereco, CouncilData conselho)? allowed,
    TResult Function(String codigo, String mensagem)? blocked,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CepAllowed value) allowed,
    required TResult Function(CepBlocked value) blocked,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CepAllowed value)? allowed,
    TResult? Function(CepBlocked value)? blocked,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CepAllowed value)? allowed,
    TResult Function(CepBlocked value)? blocked,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CepValidationResultCopyWith<$Res> {
  factory $CepValidationResultCopyWith(
    CepValidationResult value,
    $Res Function(CepValidationResult) then,
  ) = _$CepValidationResultCopyWithImpl<$Res, CepValidationResult>;
}

/// @nodoc
class _$CepValidationResultCopyWithImpl<$Res, $Val extends CepValidationResult>
    implements $CepValidationResultCopyWith<$Res> {
  _$CepValidationResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CepValidationResult
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$CepAllowedImplCopyWith<$Res> {
  factory _$$CepAllowedImplCopyWith(
    _$CepAllowedImpl value,
    $Res Function(_$CepAllowedImpl) then,
  ) = __$$CepAllowedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AddressData endereco, CouncilData conselho});

  $AddressDataCopyWith<$Res> get endereco;
  $CouncilDataCopyWith<$Res> get conselho;
}

/// @nodoc
class __$$CepAllowedImplCopyWithImpl<$Res>
    extends _$CepValidationResultCopyWithImpl<$Res, _$CepAllowedImpl>
    implements _$$CepAllowedImplCopyWith<$Res> {
  __$$CepAllowedImplCopyWithImpl(
    _$CepAllowedImpl _value,
    $Res Function(_$CepAllowedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CepValidationResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? endereco = null, Object? conselho = null}) {
    return _then(
      _$CepAllowedImpl(
        endereco: null == endereco
            ? _value.endereco
            : endereco // ignore: cast_nullable_to_non_nullable
                  as AddressData,
        conselho: null == conselho
            ? _value.conselho
            : conselho // ignore: cast_nullable_to_non_nullable
                  as CouncilData,
      ),
    );
  }

  /// Create a copy of CepValidationResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressDataCopyWith<$Res> get endereco {
    return $AddressDataCopyWith<$Res>(_value.endereco, (value) {
      return _then(_value.copyWith(endereco: value));
    });
  }

  /// Create a copy of CepValidationResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CouncilDataCopyWith<$Res> get conselho {
    return $CouncilDataCopyWith<$Res>(_value.conselho, (value) {
      return _then(_value.copyWith(conselho: value));
    });
  }
}

/// @nodoc

class _$CepAllowedImpl implements CepAllowed {
  const _$CepAllowedImpl({required this.endereco, required this.conselho});

  @override
  final AddressData endereco;
  @override
  final CouncilData conselho;

  @override
  String toString() {
    return 'CepValidationResult.allowed(endereco: $endereco, conselho: $conselho)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CepAllowedImpl &&
            (identical(other.endereco, endereco) ||
                other.endereco == endereco) &&
            (identical(other.conselho, conselho) ||
                other.conselho == conselho));
  }

  @override
  int get hashCode => Object.hash(runtimeType, endereco, conselho);

  /// Create a copy of CepValidationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CepAllowedImplCopyWith<_$CepAllowedImpl> get copyWith =>
      __$$CepAllowedImplCopyWithImpl<_$CepAllowedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AddressData endereco, CouncilData conselho)
    allowed,
    required TResult Function(String codigo, String mensagem) blocked,
  }) {
    return allowed(endereco, conselho);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AddressData endereco, CouncilData conselho)? allowed,
    TResult? Function(String codigo, String mensagem)? blocked,
  }) {
    return allowed?.call(endereco, conselho);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AddressData endereco, CouncilData conselho)? allowed,
    TResult Function(String codigo, String mensagem)? blocked,
    required TResult orElse(),
  }) {
    if (allowed != null) {
      return allowed(endereco, conselho);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CepAllowed value) allowed,
    required TResult Function(CepBlocked value) blocked,
  }) {
    return allowed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CepAllowed value)? allowed,
    TResult? Function(CepBlocked value)? blocked,
  }) {
    return allowed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CepAllowed value)? allowed,
    TResult Function(CepBlocked value)? blocked,
    required TResult orElse(),
  }) {
    if (allowed != null) {
      return allowed(this);
    }
    return orElse();
  }
}

abstract class CepAllowed implements CepValidationResult {
  const factory CepAllowed({
    required final AddressData endereco,
    required final CouncilData conselho,
  }) = _$CepAllowedImpl;

  AddressData get endereco;
  CouncilData get conselho;

  /// Create a copy of CepValidationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CepAllowedImplCopyWith<_$CepAllowedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CepBlockedImplCopyWith<$Res> {
  factory _$$CepBlockedImplCopyWith(
    _$CepBlockedImpl value,
    $Res Function(_$CepBlockedImpl) then,
  ) = __$$CepBlockedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String codigo, String mensagem});
}

/// @nodoc
class __$$CepBlockedImplCopyWithImpl<$Res>
    extends _$CepValidationResultCopyWithImpl<$Res, _$CepBlockedImpl>
    implements _$$CepBlockedImplCopyWith<$Res> {
  __$$CepBlockedImplCopyWithImpl(
    _$CepBlockedImpl _value,
    $Res Function(_$CepBlockedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CepValidationResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? codigo = null, Object? mensagem = null}) {
    return _then(
      _$CepBlockedImpl(
        codigo: null == codigo
            ? _value.codigo
            : codigo // ignore: cast_nullable_to_non_nullable
                  as String,
        mensagem: null == mensagem
            ? _value.mensagem
            : mensagem // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$CepBlockedImpl implements CepBlocked {
  const _$CepBlockedImpl({required this.codigo, required this.mensagem});

  @override
  final String codigo;
  @override
  final String mensagem;

  @override
  String toString() {
    return 'CepValidationResult.blocked(codigo: $codigo, mensagem: $mensagem)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CepBlockedImpl &&
            (identical(other.codigo, codigo) || other.codigo == codigo) &&
            (identical(other.mensagem, mensagem) ||
                other.mensagem == mensagem));
  }

  @override
  int get hashCode => Object.hash(runtimeType, codigo, mensagem);

  /// Create a copy of CepValidationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CepBlockedImplCopyWith<_$CepBlockedImpl> get copyWith =>
      __$$CepBlockedImplCopyWithImpl<_$CepBlockedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AddressData endereco, CouncilData conselho)
    allowed,
    required TResult Function(String codigo, String mensagem) blocked,
  }) {
    return blocked(codigo, mensagem);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AddressData endereco, CouncilData conselho)? allowed,
    TResult? Function(String codigo, String mensagem)? blocked,
  }) {
    return blocked?.call(codigo, mensagem);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AddressData endereco, CouncilData conselho)? allowed,
    TResult Function(String codigo, String mensagem)? blocked,
    required TResult orElse(),
  }) {
    if (blocked != null) {
      return blocked(codigo, mensagem);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CepAllowed value) allowed,
    required TResult Function(CepBlocked value) blocked,
  }) {
    return blocked(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CepAllowed value)? allowed,
    TResult? Function(CepBlocked value)? blocked,
  }) {
    return blocked?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CepAllowed value)? allowed,
    TResult Function(CepBlocked value)? blocked,
    required TResult orElse(),
  }) {
    if (blocked != null) {
      return blocked(this);
    }
    return orElse();
  }
}

abstract class CepBlocked implements CepValidationResult {
  const factory CepBlocked({
    required final String codigo,
    required final String mensagem,
  }) = _$CepBlockedImpl;

  String get codigo;
  String get mensagem;

  /// Create a copy of CepValidationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CepBlockedImplCopyWith<_$CepBlockedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
