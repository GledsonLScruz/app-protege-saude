// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'public_form.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PublicForm _$PublicFormFromJson(Map<String, dynamic> json) {
  return _PublicForm.fromJson(json);
}

/// @nodoc
mixin _$PublicForm {
  Profession get profissao => throw _privateConstructorUsedError;
  List<PublicFormStep> get passos => throw _privateConstructorUsedError;

  /// Serializes this PublicForm to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PublicForm
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PublicFormCopyWith<PublicForm> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PublicFormCopyWith<$Res> {
  factory $PublicFormCopyWith(
    PublicForm value,
    $Res Function(PublicForm) then,
  ) = _$PublicFormCopyWithImpl<$Res, PublicForm>;
  @useResult
  $Res call({Profession profissao, List<PublicFormStep> passos});

  $ProfessionCopyWith<$Res> get profissao;
}

/// @nodoc
class _$PublicFormCopyWithImpl<$Res, $Val extends PublicForm>
    implements $PublicFormCopyWith<$Res> {
  _$PublicFormCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PublicForm
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? profissao = null, Object? passos = null}) {
    return _then(
      _value.copyWith(
            profissao: null == profissao
                ? _value.profissao
                : profissao // ignore: cast_nullable_to_non_nullable
                      as Profession,
            passos: null == passos
                ? _value.passos
                : passos // ignore: cast_nullable_to_non_nullable
                      as List<PublicFormStep>,
          )
          as $Val,
    );
  }

  /// Create a copy of PublicForm
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProfessionCopyWith<$Res> get profissao {
    return $ProfessionCopyWith<$Res>(_value.profissao, (value) {
      return _then(_value.copyWith(profissao: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PublicFormImplCopyWith<$Res>
    implements $PublicFormCopyWith<$Res> {
  factory _$$PublicFormImplCopyWith(
    _$PublicFormImpl value,
    $Res Function(_$PublicFormImpl) then,
  ) = __$$PublicFormImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Profession profissao, List<PublicFormStep> passos});

  @override
  $ProfessionCopyWith<$Res> get profissao;
}

/// @nodoc
class __$$PublicFormImplCopyWithImpl<$Res>
    extends _$PublicFormCopyWithImpl<$Res, _$PublicFormImpl>
    implements _$$PublicFormImplCopyWith<$Res> {
  __$$PublicFormImplCopyWithImpl(
    _$PublicFormImpl _value,
    $Res Function(_$PublicFormImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PublicForm
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? profissao = null, Object? passos = null}) {
    return _then(
      _$PublicFormImpl(
        profissao: null == profissao
            ? _value.profissao
            : profissao // ignore: cast_nullable_to_non_nullable
                  as Profession,
        passos: null == passos
            ? _value._passos
            : passos // ignore: cast_nullable_to_non_nullable
                  as List<PublicFormStep>,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$PublicFormImpl extends _PublicForm {
  const _$PublicFormImpl({
    required this.profissao,
    final List<PublicFormStep> passos = const <PublicFormStep>[],
  }) : _passos = passos,
       super._();

  factory _$PublicFormImpl.fromJson(Map<String, dynamic> json) =>
      _$$PublicFormImplFromJson(json);

  @override
  final Profession profissao;
  final List<PublicFormStep> _passos;
  @override
  @JsonKey()
  List<PublicFormStep> get passos {
    if (_passos is EqualUnmodifiableListView) return _passos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_passos);
  }

  @override
  String toString() {
    return 'PublicForm(profissao: $profissao, passos: $passos)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PublicFormImpl &&
            (identical(other.profissao, profissao) ||
                other.profissao == profissao) &&
            const DeepCollectionEquality().equals(other._passos, _passos));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    profissao,
    const DeepCollectionEquality().hash(_passos),
  );

  /// Create a copy of PublicForm
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PublicFormImplCopyWith<_$PublicFormImpl> get copyWith =>
      __$$PublicFormImplCopyWithImpl<_$PublicFormImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PublicFormImplToJson(this);
  }
}

abstract class _PublicForm extends PublicForm {
  const factory _PublicForm({
    required final Profession profissao,
    final List<PublicFormStep> passos,
  }) = _$PublicFormImpl;
  const _PublicForm._() : super._();

  factory _PublicForm.fromJson(Map<String, dynamic> json) =
      _$PublicFormImpl.fromJson;

  @override
  Profession get profissao;
  @override
  List<PublicFormStep> get passos;

  /// Create a copy of PublicForm
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PublicFormImplCopyWith<_$PublicFormImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PublicFormStep _$PublicFormStepFromJson(Map<String, dynamic> json) {
  return _PublicFormStep.fromJson(json);
}

/// @nodoc
mixin _$PublicFormStep {
  @JsonKey(fromJson: intFromJson)
  int get id => throw _privateConstructorUsedError;
  @JsonKey(fromJson: nullableIntFromJson)
  int? get profissaoId => throw _privateConstructorUsedError;
  @JsonKey(fromJson: intFromJson)
  int get ordemIndex => throw _privateConstructorUsedError;
  String get titulo => throw _privateConstructorUsedError;
  String? get descricao => throw _privateConstructorUsedError;
  List<PublicFormField> get campos => throw _privateConstructorUsedError;

  /// Serializes this PublicFormStep to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PublicFormStep
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PublicFormStepCopyWith<PublicFormStep> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PublicFormStepCopyWith<$Res> {
  factory $PublicFormStepCopyWith(
    PublicFormStep value,
    $Res Function(PublicFormStep) then,
  ) = _$PublicFormStepCopyWithImpl<$Res, PublicFormStep>;
  @useResult
  $Res call({
    @JsonKey(fromJson: intFromJson) int id,
    @JsonKey(fromJson: nullableIntFromJson) int? profissaoId,
    @JsonKey(fromJson: intFromJson) int ordemIndex,
    String titulo,
    String? descricao,
    List<PublicFormField> campos,
  });
}

/// @nodoc
class _$PublicFormStepCopyWithImpl<$Res, $Val extends PublicFormStep>
    implements $PublicFormStepCopyWith<$Res> {
  _$PublicFormStepCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PublicFormStep
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? profissaoId = freezed,
    Object? ordemIndex = null,
    Object? titulo = null,
    Object? descricao = freezed,
    Object? campos = null,
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
            ordemIndex: null == ordemIndex
                ? _value.ordemIndex
                : ordemIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            titulo: null == titulo
                ? _value.titulo
                : titulo // ignore: cast_nullable_to_non_nullable
                      as String,
            descricao: freezed == descricao
                ? _value.descricao
                : descricao // ignore: cast_nullable_to_non_nullable
                      as String?,
            campos: null == campos
                ? _value.campos
                : campos // ignore: cast_nullable_to_non_nullable
                      as List<PublicFormField>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PublicFormStepImplCopyWith<$Res>
    implements $PublicFormStepCopyWith<$Res> {
  factory _$$PublicFormStepImplCopyWith(
    _$PublicFormStepImpl value,
    $Res Function(_$PublicFormStepImpl) then,
  ) = __$$PublicFormStepImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(fromJson: intFromJson) int id,
    @JsonKey(fromJson: nullableIntFromJson) int? profissaoId,
    @JsonKey(fromJson: intFromJson) int ordemIndex,
    String titulo,
    String? descricao,
    List<PublicFormField> campos,
  });
}

/// @nodoc
class __$$PublicFormStepImplCopyWithImpl<$Res>
    extends _$PublicFormStepCopyWithImpl<$Res, _$PublicFormStepImpl>
    implements _$$PublicFormStepImplCopyWith<$Res> {
  __$$PublicFormStepImplCopyWithImpl(
    _$PublicFormStepImpl _value,
    $Res Function(_$PublicFormStepImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PublicFormStep
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? profissaoId = freezed,
    Object? ordemIndex = null,
    Object? titulo = null,
    Object? descricao = freezed,
    Object? campos = null,
  }) {
    return _then(
      _$PublicFormStepImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        profissaoId: freezed == profissaoId
            ? _value.profissaoId
            : profissaoId // ignore: cast_nullable_to_non_nullable
                  as int?,
        ordemIndex: null == ordemIndex
            ? _value.ordemIndex
            : ordemIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        titulo: null == titulo
            ? _value.titulo
            : titulo // ignore: cast_nullable_to_non_nullable
                  as String,
        descricao: freezed == descricao
            ? _value.descricao
            : descricao // ignore: cast_nullable_to_non_nullable
                  as String?,
        campos: null == campos
            ? _value._campos
            : campos // ignore: cast_nullable_to_non_nullable
                  as List<PublicFormField>,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$PublicFormStepImpl extends _PublicFormStep {
  const _$PublicFormStepImpl({
    @JsonKey(fromJson: intFromJson) required this.id,
    @JsonKey(fromJson: nullableIntFromJson) this.profissaoId,
    @JsonKey(fromJson: intFromJson) this.ordemIndex = 0,
    required this.titulo,
    this.descricao,
    final List<PublicFormField> campos = const <PublicFormField>[],
  }) : _campos = campos,
       super._();

  factory _$PublicFormStepImpl.fromJson(Map<String, dynamic> json) =>
      _$$PublicFormStepImplFromJson(json);

  @override
  @JsonKey(fromJson: intFromJson)
  final int id;
  @override
  @JsonKey(fromJson: nullableIntFromJson)
  final int? profissaoId;
  @override
  @JsonKey(fromJson: intFromJson)
  final int ordemIndex;
  @override
  final String titulo;
  @override
  final String? descricao;
  final List<PublicFormField> _campos;
  @override
  @JsonKey()
  List<PublicFormField> get campos {
    if (_campos is EqualUnmodifiableListView) return _campos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_campos);
  }

  @override
  String toString() {
    return 'PublicFormStep(id: $id, profissaoId: $profissaoId, ordemIndex: $ordemIndex, titulo: $titulo, descricao: $descricao, campos: $campos)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PublicFormStepImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.profissaoId, profissaoId) ||
                other.profissaoId == profissaoId) &&
            (identical(other.ordemIndex, ordemIndex) ||
                other.ordemIndex == ordemIndex) &&
            (identical(other.titulo, titulo) || other.titulo == titulo) &&
            (identical(other.descricao, descricao) ||
                other.descricao == descricao) &&
            const DeepCollectionEquality().equals(other._campos, _campos));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    profissaoId,
    ordemIndex,
    titulo,
    descricao,
    const DeepCollectionEquality().hash(_campos),
  );

  /// Create a copy of PublicFormStep
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PublicFormStepImplCopyWith<_$PublicFormStepImpl> get copyWith =>
      __$$PublicFormStepImplCopyWithImpl<_$PublicFormStepImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PublicFormStepImplToJson(this);
  }
}

abstract class _PublicFormStep extends PublicFormStep {
  const factory _PublicFormStep({
    @JsonKey(fromJson: intFromJson) required final int id,
    @JsonKey(fromJson: nullableIntFromJson) final int? profissaoId,
    @JsonKey(fromJson: intFromJson) final int ordemIndex,
    required final String titulo,
    final String? descricao,
    final List<PublicFormField> campos,
  }) = _$PublicFormStepImpl;
  const _PublicFormStep._() : super._();

  factory _PublicFormStep.fromJson(Map<String, dynamic> json) =
      _$PublicFormStepImpl.fromJson;

  @override
  @JsonKey(fromJson: intFromJson)
  int get id;
  @override
  @JsonKey(fromJson: nullableIntFromJson)
  int? get profissaoId;
  @override
  @JsonKey(fromJson: intFromJson)
  int get ordemIndex;
  @override
  String get titulo;
  @override
  String? get descricao;
  @override
  List<PublicFormField> get campos;

  /// Create a copy of PublicFormStep
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PublicFormStepImplCopyWith<_$PublicFormStepImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PublicFormField _$PublicFormFieldFromJson(Map<String, dynamic> json) {
  return _PublicFormField.fromJson(json);
}

/// @nodoc
mixin _$PublicFormField {
  @JsonKey(fromJson: intFromJson)
  int get id => throw _privateConstructorUsedError;
  @JsonKey(fromJson: nullableIntFromJson)
  int? get formularioPassoId => throw _privateConstructorUsedError;
  @JsonKey(fromJson: intFromJson)
  int get ordemIndex => throw _privateConstructorUsedError;
  String get nome => throw _privateConstructorUsedError;
  @JsonKey(name: 'tipo_campo')
  String get tipoCampo => throw _privateConstructorUsedError;
  List<FormOption> get opcoes => throw _privateConstructorUsedError;
  @JsonKey(fromJson: nullableIntFromJson)
  int? get maxFotos => throw _privateConstructorUsedError;
  @JsonKey(fromJson: boolFromJson)
  bool get obrigatorio => throw _privateConstructorUsedError;
  String? get dica => throw _privateConstructorUsedError;
  FieldValidation? get validacoes => throw _privateConstructorUsedError;

  /// Serializes this PublicFormField to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PublicFormField
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PublicFormFieldCopyWith<PublicFormField> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PublicFormFieldCopyWith<$Res> {
  factory $PublicFormFieldCopyWith(
    PublicFormField value,
    $Res Function(PublicFormField) then,
  ) = _$PublicFormFieldCopyWithImpl<$Res, PublicFormField>;
  @useResult
  $Res call({
    @JsonKey(fromJson: intFromJson) int id,
    @JsonKey(fromJson: nullableIntFromJson) int? formularioPassoId,
    @JsonKey(fromJson: intFromJson) int ordemIndex,
    String nome,
    @JsonKey(name: 'tipo_campo') String tipoCampo,
    List<FormOption> opcoes,
    @JsonKey(fromJson: nullableIntFromJson) int? maxFotos,
    @JsonKey(fromJson: boolFromJson) bool obrigatorio,
    String? dica,
    FieldValidation? validacoes,
  });

  $FieldValidationCopyWith<$Res>? get validacoes;
}

/// @nodoc
class _$PublicFormFieldCopyWithImpl<$Res, $Val extends PublicFormField>
    implements $PublicFormFieldCopyWith<$Res> {
  _$PublicFormFieldCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PublicFormField
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? formularioPassoId = freezed,
    Object? ordemIndex = null,
    Object? nome = null,
    Object? tipoCampo = null,
    Object? opcoes = null,
    Object? maxFotos = freezed,
    Object? obrigatorio = null,
    Object? dica = freezed,
    Object? validacoes = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            formularioPassoId: freezed == formularioPassoId
                ? _value.formularioPassoId
                : formularioPassoId // ignore: cast_nullable_to_non_nullable
                      as int?,
            ordemIndex: null == ordemIndex
                ? _value.ordemIndex
                : ordemIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            nome: null == nome
                ? _value.nome
                : nome // ignore: cast_nullable_to_non_nullable
                      as String,
            tipoCampo: null == tipoCampo
                ? _value.tipoCampo
                : tipoCampo // ignore: cast_nullable_to_non_nullable
                      as String,
            opcoes: null == opcoes
                ? _value.opcoes
                : opcoes // ignore: cast_nullable_to_non_nullable
                      as List<FormOption>,
            maxFotos: freezed == maxFotos
                ? _value.maxFotos
                : maxFotos // ignore: cast_nullable_to_non_nullable
                      as int?,
            obrigatorio: null == obrigatorio
                ? _value.obrigatorio
                : obrigatorio // ignore: cast_nullable_to_non_nullable
                      as bool,
            dica: freezed == dica
                ? _value.dica
                : dica // ignore: cast_nullable_to_non_nullable
                      as String?,
            validacoes: freezed == validacoes
                ? _value.validacoes
                : validacoes // ignore: cast_nullable_to_non_nullable
                      as FieldValidation?,
          )
          as $Val,
    );
  }

  /// Create a copy of PublicFormField
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FieldValidationCopyWith<$Res>? get validacoes {
    if (_value.validacoes == null) {
      return null;
    }

    return $FieldValidationCopyWith<$Res>(_value.validacoes!, (value) {
      return _then(_value.copyWith(validacoes: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PublicFormFieldImplCopyWith<$Res>
    implements $PublicFormFieldCopyWith<$Res> {
  factory _$$PublicFormFieldImplCopyWith(
    _$PublicFormFieldImpl value,
    $Res Function(_$PublicFormFieldImpl) then,
  ) = __$$PublicFormFieldImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(fromJson: intFromJson) int id,
    @JsonKey(fromJson: nullableIntFromJson) int? formularioPassoId,
    @JsonKey(fromJson: intFromJson) int ordemIndex,
    String nome,
    @JsonKey(name: 'tipo_campo') String tipoCampo,
    List<FormOption> opcoes,
    @JsonKey(fromJson: nullableIntFromJson) int? maxFotos,
    @JsonKey(fromJson: boolFromJson) bool obrigatorio,
    String? dica,
    FieldValidation? validacoes,
  });

  @override
  $FieldValidationCopyWith<$Res>? get validacoes;
}

/// @nodoc
class __$$PublicFormFieldImplCopyWithImpl<$Res>
    extends _$PublicFormFieldCopyWithImpl<$Res, _$PublicFormFieldImpl>
    implements _$$PublicFormFieldImplCopyWith<$Res> {
  __$$PublicFormFieldImplCopyWithImpl(
    _$PublicFormFieldImpl _value,
    $Res Function(_$PublicFormFieldImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PublicFormField
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? formularioPassoId = freezed,
    Object? ordemIndex = null,
    Object? nome = null,
    Object? tipoCampo = null,
    Object? opcoes = null,
    Object? maxFotos = freezed,
    Object? obrigatorio = null,
    Object? dica = freezed,
    Object? validacoes = freezed,
  }) {
    return _then(
      _$PublicFormFieldImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        formularioPassoId: freezed == formularioPassoId
            ? _value.formularioPassoId
            : formularioPassoId // ignore: cast_nullable_to_non_nullable
                  as int?,
        ordemIndex: null == ordemIndex
            ? _value.ordemIndex
            : ordemIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        nome: null == nome
            ? _value.nome
            : nome // ignore: cast_nullable_to_non_nullable
                  as String,
        tipoCampo: null == tipoCampo
            ? _value.tipoCampo
            : tipoCampo // ignore: cast_nullable_to_non_nullable
                  as String,
        opcoes: null == opcoes
            ? _value._opcoes
            : opcoes // ignore: cast_nullable_to_non_nullable
                  as List<FormOption>,
        maxFotos: freezed == maxFotos
            ? _value.maxFotos
            : maxFotos // ignore: cast_nullable_to_non_nullable
                  as int?,
        obrigatorio: null == obrigatorio
            ? _value.obrigatorio
            : obrigatorio // ignore: cast_nullable_to_non_nullable
                  as bool,
        dica: freezed == dica
            ? _value.dica
            : dica // ignore: cast_nullable_to_non_nullable
                  as String?,
        validacoes: freezed == validacoes
            ? _value.validacoes
            : validacoes // ignore: cast_nullable_to_non_nullable
                  as FieldValidation?,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$PublicFormFieldImpl extends _PublicFormField {
  const _$PublicFormFieldImpl({
    @JsonKey(fromJson: intFromJson) required this.id,
    @JsonKey(fromJson: nullableIntFromJson) this.formularioPassoId,
    @JsonKey(fromJson: intFromJson) this.ordemIndex = 0,
    required this.nome,
    @JsonKey(name: 'tipo_campo') required this.tipoCampo,
    final List<FormOption> opcoes = const <FormOption>[],
    @JsonKey(fromJson: nullableIntFromJson) this.maxFotos,
    @JsonKey(fromJson: boolFromJson) this.obrigatorio = false,
    this.dica,
    this.validacoes,
  }) : _opcoes = opcoes,
       super._();

  factory _$PublicFormFieldImpl.fromJson(Map<String, dynamic> json) =>
      _$$PublicFormFieldImplFromJson(json);

  @override
  @JsonKey(fromJson: intFromJson)
  final int id;
  @override
  @JsonKey(fromJson: nullableIntFromJson)
  final int? formularioPassoId;
  @override
  @JsonKey(fromJson: intFromJson)
  final int ordemIndex;
  @override
  final String nome;
  @override
  @JsonKey(name: 'tipo_campo')
  final String tipoCampo;
  final List<FormOption> _opcoes;
  @override
  @JsonKey()
  List<FormOption> get opcoes {
    if (_opcoes is EqualUnmodifiableListView) return _opcoes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_opcoes);
  }

  @override
  @JsonKey(fromJson: nullableIntFromJson)
  final int? maxFotos;
  @override
  @JsonKey(fromJson: boolFromJson)
  final bool obrigatorio;
  @override
  final String? dica;
  @override
  final FieldValidation? validacoes;

  @override
  String toString() {
    return 'PublicFormField(id: $id, formularioPassoId: $formularioPassoId, ordemIndex: $ordemIndex, nome: $nome, tipoCampo: $tipoCampo, opcoes: $opcoes, maxFotos: $maxFotos, obrigatorio: $obrigatorio, dica: $dica, validacoes: $validacoes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PublicFormFieldImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.formularioPassoId, formularioPassoId) ||
                other.formularioPassoId == formularioPassoId) &&
            (identical(other.ordemIndex, ordemIndex) ||
                other.ordemIndex == ordemIndex) &&
            (identical(other.nome, nome) || other.nome == nome) &&
            (identical(other.tipoCampo, tipoCampo) ||
                other.tipoCampo == tipoCampo) &&
            const DeepCollectionEquality().equals(other._opcoes, _opcoes) &&
            (identical(other.maxFotos, maxFotos) ||
                other.maxFotos == maxFotos) &&
            (identical(other.obrigatorio, obrigatorio) ||
                other.obrigatorio == obrigatorio) &&
            (identical(other.dica, dica) || other.dica == dica) &&
            (identical(other.validacoes, validacoes) ||
                other.validacoes == validacoes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    formularioPassoId,
    ordemIndex,
    nome,
    tipoCampo,
    const DeepCollectionEquality().hash(_opcoes),
    maxFotos,
    obrigatorio,
    dica,
    validacoes,
  );

  /// Create a copy of PublicFormField
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PublicFormFieldImplCopyWith<_$PublicFormFieldImpl> get copyWith =>
      __$$PublicFormFieldImplCopyWithImpl<_$PublicFormFieldImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PublicFormFieldImplToJson(this);
  }
}

abstract class _PublicFormField extends PublicFormField {
  const factory _PublicFormField({
    @JsonKey(fromJson: intFromJson) required final int id,
    @JsonKey(fromJson: nullableIntFromJson) final int? formularioPassoId,
    @JsonKey(fromJson: intFromJson) final int ordemIndex,
    required final String nome,
    @JsonKey(name: 'tipo_campo') required final String tipoCampo,
    final List<FormOption> opcoes,
    @JsonKey(fromJson: nullableIntFromJson) final int? maxFotos,
    @JsonKey(fromJson: boolFromJson) final bool obrigatorio,
    final String? dica,
    final FieldValidation? validacoes,
  }) = _$PublicFormFieldImpl;
  const _PublicFormField._() : super._();

  factory _PublicFormField.fromJson(Map<String, dynamic> json) =
      _$PublicFormFieldImpl.fromJson;

  @override
  @JsonKey(fromJson: intFromJson)
  int get id;
  @override
  @JsonKey(fromJson: nullableIntFromJson)
  int? get formularioPassoId;
  @override
  @JsonKey(fromJson: intFromJson)
  int get ordemIndex;
  @override
  String get nome;
  @override
  @JsonKey(name: 'tipo_campo')
  String get tipoCampo;
  @override
  List<FormOption> get opcoes;
  @override
  @JsonKey(fromJson: nullableIntFromJson)
  int? get maxFotos;
  @override
  @JsonKey(fromJson: boolFromJson)
  bool get obrigatorio;
  @override
  String? get dica;
  @override
  FieldValidation? get validacoes;

  /// Create a copy of PublicFormField
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PublicFormFieldImplCopyWith<_$PublicFormFieldImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$FormOption {
  String get valor => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;

  /// Create a copy of FormOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FormOptionCopyWith<FormOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FormOptionCopyWith<$Res> {
  factory $FormOptionCopyWith(
    FormOption value,
    $Res Function(FormOption) then,
  ) = _$FormOptionCopyWithImpl<$Res, FormOption>;
  @useResult
  $Res call({String valor, String label});
}

/// @nodoc
class _$FormOptionCopyWithImpl<$Res, $Val extends FormOption>
    implements $FormOptionCopyWith<$Res> {
  _$FormOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FormOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? valor = null, Object? label = null}) {
    return _then(
      _value.copyWith(
            valor: null == valor
                ? _value.valor
                : valor // ignore: cast_nullable_to_non_nullable
                      as String,
            label: null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FormOptionImplCopyWith<$Res>
    implements $FormOptionCopyWith<$Res> {
  factory _$$FormOptionImplCopyWith(
    _$FormOptionImpl value,
    $Res Function(_$FormOptionImpl) then,
  ) = __$$FormOptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String valor, String label});
}

/// @nodoc
class __$$FormOptionImplCopyWithImpl<$Res>
    extends _$FormOptionCopyWithImpl<$Res, _$FormOptionImpl>
    implements _$$FormOptionImplCopyWith<$Res> {
  __$$FormOptionImplCopyWithImpl(
    _$FormOptionImpl _value,
    $Res Function(_$FormOptionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FormOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? valor = null, Object? label = null}) {
    return _then(
      _$FormOptionImpl(
        valor: null == valor
            ? _value.valor
            : valor // ignore: cast_nullable_to_non_nullable
                  as String,
        label: null == label
            ? _value.label
            : label // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$FormOptionImpl extends _FormOption {
  const _$FormOptionImpl({required this.valor, required this.label})
    : super._();

  @override
  final String valor;
  @override
  final String label;

  @override
  String toString() {
    return 'FormOption(valor: $valor, label: $label)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FormOptionImpl &&
            (identical(other.valor, valor) || other.valor == valor) &&
            (identical(other.label, label) || other.label == label));
  }

  @override
  int get hashCode => Object.hash(runtimeType, valor, label);

  /// Create a copy of FormOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FormOptionImplCopyWith<_$FormOptionImpl> get copyWith =>
      __$$FormOptionImplCopyWithImpl<_$FormOptionImpl>(this, _$identity);
}

abstract class _FormOption extends FormOption {
  const factory _FormOption({
    required final String valor,
    required final String label,
  }) = _$FormOptionImpl;
  const _FormOption._() : super._();

  @override
  String get valor;
  @override
  String get label;

  /// Create a copy of FormOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FormOptionImplCopyWith<_$FormOptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FieldValidation _$FieldValidationFromJson(Map<String, dynamic> json) {
  return _FieldValidation.fromJson(json);
}

/// @nodoc
mixin _$FieldValidation {
  @JsonKey(fromJson: nullableBoolFromJson)
  bool? get obrigatorio => throw _privateConstructorUsedError;
  @JsonKey(fromJson: nullableBoolFromJson)
  bool? get aceitaMultiplos => throw _privateConstructorUsedError;
  List<String> get opcoesPermitidas => throw _privateConstructorUsedError;
  String? get opcoesCondicionaisQuando => throw _privateConstructorUsedError;
  List<String> get opcoesCondicionaisPermitidas =>
      throw _privateConstructorUsedError;
  @JsonKey(fromJson: nullableBoolFromJson)
  bool? get opcoesCondicionaisAceitaMultiplos =>
      throw _privateConstructorUsedError;
  @JsonKey(fromJson: nullableIntFromJson)
  int? get maxFotos => throw _privateConstructorUsedError;

  /// Serializes this FieldValidation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FieldValidation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FieldValidationCopyWith<FieldValidation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FieldValidationCopyWith<$Res> {
  factory $FieldValidationCopyWith(
    FieldValidation value,
    $Res Function(FieldValidation) then,
  ) = _$FieldValidationCopyWithImpl<$Res, FieldValidation>;
  @useResult
  $Res call({
    @JsonKey(fromJson: nullableBoolFromJson) bool? obrigatorio,
    @JsonKey(fromJson: nullableBoolFromJson) bool? aceitaMultiplos,
    List<String> opcoesPermitidas,
    String? opcoesCondicionaisQuando,
    List<String> opcoesCondicionaisPermitidas,
    @JsonKey(fromJson: nullableBoolFromJson)
    bool? opcoesCondicionaisAceitaMultiplos,
    @JsonKey(fromJson: nullableIntFromJson) int? maxFotos,
  });
}

/// @nodoc
class _$FieldValidationCopyWithImpl<$Res, $Val extends FieldValidation>
    implements $FieldValidationCopyWith<$Res> {
  _$FieldValidationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FieldValidation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? obrigatorio = freezed,
    Object? aceitaMultiplos = freezed,
    Object? opcoesPermitidas = null,
    Object? opcoesCondicionaisQuando = freezed,
    Object? opcoesCondicionaisPermitidas = null,
    Object? opcoesCondicionaisAceitaMultiplos = freezed,
    Object? maxFotos = freezed,
  }) {
    return _then(
      _value.copyWith(
            obrigatorio: freezed == obrigatorio
                ? _value.obrigatorio
                : obrigatorio // ignore: cast_nullable_to_non_nullable
                      as bool?,
            aceitaMultiplos: freezed == aceitaMultiplos
                ? _value.aceitaMultiplos
                : aceitaMultiplos // ignore: cast_nullable_to_non_nullable
                      as bool?,
            opcoesPermitidas: null == opcoesPermitidas
                ? _value.opcoesPermitidas
                : opcoesPermitidas // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            opcoesCondicionaisQuando: freezed == opcoesCondicionaisQuando
                ? _value.opcoesCondicionaisQuando
                : opcoesCondicionaisQuando // ignore: cast_nullable_to_non_nullable
                      as String?,
            opcoesCondicionaisPermitidas: null == opcoesCondicionaisPermitidas
                ? _value.opcoesCondicionaisPermitidas
                : opcoesCondicionaisPermitidas // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            opcoesCondicionaisAceitaMultiplos:
                freezed == opcoesCondicionaisAceitaMultiplos
                ? _value.opcoesCondicionaisAceitaMultiplos
                : opcoesCondicionaisAceitaMultiplos // ignore: cast_nullable_to_non_nullable
                      as bool?,
            maxFotos: freezed == maxFotos
                ? _value.maxFotos
                : maxFotos // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FieldValidationImplCopyWith<$Res>
    implements $FieldValidationCopyWith<$Res> {
  factory _$$FieldValidationImplCopyWith(
    _$FieldValidationImpl value,
    $Res Function(_$FieldValidationImpl) then,
  ) = __$$FieldValidationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(fromJson: nullableBoolFromJson) bool? obrigatorio,
    @JsonKey(fromJson: nullableBoolFromJson) bool? aceitaMultiplos,
    List<String> opcoesPermitidas,
    String? opcoesCondicionaisQuando,
    List<String> opcoesCondicionaisPermitidas,
    @JsonKey(fromJson: nullableBoolFromJson)
    bool? opcoesCondicionaisAceitaMultiplos,
    @JsonKey(fromJson: nullableIntFromJson) int? maxFotos,
  });
}

/// @nodoc
class __$$FieldValidationImplCopyWithImpl<$Res>
    extends _$FieldValidationCopyWithImpl<$Res, _$FieldValidationImpl>
    implements _$$FieldValidationImplCopyWith<$Res> {
  __$$FieldValidationImplCopyWithImpl(
    _$FieldValidationImpl _value,
    $Res Function(_$FieldValidationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FieldValidation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? obrigatorio = freezed,
    Object? aceitaMultiplos = freezed,
    Object? opcoesPermitidas = null,
    Object? opcoesCondicionaisQuando = freezed,
    Object? opcoesCondicionaisPermitidas = null,
    Object? opcoesCondicionaisAceitaMultiplos = freezed,
    Object? maxFotos = freezed,
  }) {
    return _then(
      _$FieldValidationImpl(
        obrigatorio: freezed == obrigatorio
            ? _value.obrigatorio
            : obrigatorio // ignore: cast_nullable_to_non_nullable
                  as bool?,
        aceitaMultiplos: freezed == aceitaMultiplos
            ? _value.aceitaMultiplos
            : aceitaMultiplos // ignore: cast_nullable_to_non_nullable
                  as bool?,
        opcoesPermitidas: null == opcoesPermitidas
            ? _value._opcoesPermitidas
            : opcoesPermitidas // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        opcoesCondicionaisQuando: freezed == opcoesCondicionaisQuando
            ? _value.opcoesCondicionaisQuando
            : opcoesCondicionaisQuando // ignore: cast_nullable_to_non_nullable
                  as String?,
        opcoesCondicionaisPermitidas: null == opcoesCondicionaisPermitidas
            ? _value._opcoesCondicionaisPermitidas
            : opcoesCondicionaisPermitidas // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        opcoesCondicionaisAceitaMultiplos:
            freezed == opcoesCondicionaisAceitaMultiplos
            ? _value.opcoesCondicionaisAceitaMultiplos
            : opcoesCondicionaisAceitaMultiplos // ignore: cast_nullable_to_non_nullable
                  as bool?,
        maxFotos: freezed == maxFotos
            ? _value.maxFotos
            : maxFotos // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$FieldValidationImpl extends _FieldValidation {
  const _$FieldValidationImpl({
    @JsonKey(fromJson: nullableBoolFromJson) this.obrigatorio,
    @JsonKey(fromJson: nullableBoolFromJson) this.aceitaMultiplos,
    final List<String> opcoesPermitidas = const <String>[],
    this.opcoesCondicionaisQuando,
    final List<String> opcoesCondicionaisPermitidas = const <String>[],
    @JsonKey(fromJson: nullableBoolFromJson)
    this.opcoesCondicionaisAceitaMultiplos,
    @JsonKey(fromJson: nullableIntFromJson) this.maxFotos,
  }) : _opcoesPermitidas = opcoesPermitidas,
       _opcoesCondicionaisPermitidas = opcoesCondicionaisPermitidas,
       super._();

  factory _$FieldValidationImpl.fromJson(Map<String, dynamic> json) =>
      _$$FieldValidationImplFromJson(json);

  @override
  @JsonKey(fromJson: nullableBoolFromJson)
  final bool? obrigatorio;
  @override
  @JsonKey(fromJson: nullableBoolFromJson)
  final bool? aceitaMultiplos;
  final List<String> _opcoesPermitidas;
  @override
  @JsonKey()
  List<String> get opcoesPermitidas {
    if (_opcoesPermitidas is EqualUnmodifiableListView)
      return _opcoesPermitidas;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_opcoesPermitidas);
  }

  @override
  final String? opcoesCondicionaisQuando;
  final List<String> _opcoesCondicionaisPermitidas;
  @override
  @JsonKey()
  List<String> get opcoesCondicionaisPermitidas {
    if (_opcoesCondicionaisPermitidas is EqualUnmodifiableListView)
      return _opcoesCondicionaisPermitidas;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_opcoesCondicionaisPermitidas);
  }

  @override
  @JsonKey(fromJson: nullableBoolFromJson)
  final bool? opcoesCondicionaisAceitaMultiplos;
  @override
  @JsonKey(fromJson: nullableIntFromJson)
  final int? maxFotos;

  @override
  String toString() {
    return 'FieldValidation(obrigatorio: $obrigatorio, aceitaMultiplos: $aceitaMultiplos, opcoesPermitidas: $opcoesPermitidas, opcoesCondicionaisQuando: $opcoesCondicionaisQuando, opcoesCondicionaisPermitidas: $opcoesCondicionaisPermitidas, opcoesCondicionaisAceitaMultiplos: $opcoesCondicionaisAceitaMultiplos, maxFotos: $maxFotos)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FieldValidationImpl &&
            (identical(other.obrigatorio, obrigatorio) ||
                other.obrigatorio == obrigatorio) &&
            (identical(other.aceitaMultiplos, aceitaMultiplos) ||
                other.aceitaMultiplos == aceitaMultiplos) &&
            const DeepCollectionEquality().equals(
              other._opcoesPermitidas,
              _opcoesPermitidas,
            ) &&
            (identical(
                  other.opcoesCondicionaisQuando,
                  opcoesCondicionaisQuando,
                ) ||
                other.opcoesCondicionaisQuando == opcoesCondicionaisQuando) &&
            const DeepCollectionEquality().equals(
              other._opcoesCondicionaisPermitidas,
              _opcoesCondicionaisPermitidas,
            ) &&
            (identical(
                  other.opcoesCondicionaisAceitaMultiplos,
                  opcoesCondicionaisAceitaMultiplos,
                ) ||
                other.opcoesCondicionaisAceitaMultiplos ==
                    opcoesCondicionaisAceitaMultiplos) &&
            (identical(other.maxFotos, maxFotos) ||
                other.maxFotos == maxFotos));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    obrigatorio,
    aceitaMultiplos,
    const DeepCollectionEquality().hash(_opcoesPermitidas),
    opcoesCondicionaisQuando,
    const DeepCollectionEquality().hash(_opcoesCondicionaisPermitidas),
    opcoesCondicionaisAceitaMultiplos,
    maxFotos,
  );

  /// Create a copy of FieldValidation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FieldValidationImplCopyWith<_$FieldValidationImpl> get copyWith =>
      __$$FieldValidationImplCopyWithImpl<_$FieldValidationImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$FieldValidationImplToJson(this);
  }
}

abstract class _FieldValidation extends FieldValidation {
  const factory _FieldValidation({
    @JsonKey(fromJson: nullableBoolFromJson) final bool? obrigatorio,
    @JsonKey(fromJson: nullableBoolFromJson) final bool? aceitaMultiplos,
    final List<String> opcoesPermitidas,
    final String? opcoesCondicionaisQuando,
    final List<String> opcoesCondicionaisPermitidas,
    @JsonKey(fromJson: nullableBoolFromJson)
    final bool? opcoesCondicionaisAceitaMultiplos,
    @JsonKey(fromJson: nullableIntFromJson) final int? maxFotos,
  }) = _$FieldValidationImpl;
  const _FieldValidation._() : super._();

  factory _FieldValidation.fromJson(Map<String, dynamic> json) =
      _$FieldValidationImpl.fromJson;

  @override
  @JsonKey(fromJson: nullableBoolFromJson)
  bool? get obrigatorio;
  @override
  @JsonKey(fromJson: nullableBoolFromJson)
  bool? get aceitaMultiplos;
  @override
  List<String> get opcoesPermitidas;
  @override
  String? get opcoesCondicionaisQuando;
  @override
  List<String> get opcoesCondicionaisPermitidas;
  @override
  @JsonKey(fromJson: nullableBoolFromJson)
  bool? get opcoesCondicionaisAceitaMultiplos;
  @override
  @JsonKey(fromJson: nullableIntFromJson)
  int? get maxFotos;

  /// Create a copy of FieldValidation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FieldValidationImplCopyWith<_$FieldValidationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
