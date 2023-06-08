// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'password_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PasswordModel _$PasswordModelFromJson(Map<String, dynamic> json) {
  return _PasswordModel.fromJson(json);
}

/// @nodoc
mixin _$PasswordModel {
  String? get email => throw _privateConstructorUsedError;
  String? get current_password => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  String? get password_confirmation => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PasswordModelCopyWith<PasswordModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PasswordModelCopyWith<$Res> {
  factory $PasswordModelCopyWith(
          PasswordModel value, $Res Function(PasswordModel) then) =
      _$PasswordModelCopyWithImpl<$Res, PasswordModel>;
  @useResult
  $Res call(
      {String? email,
      String? current_password,
      String? password,
      String? password_confirmation});
}

/// @nodoc
class _$PasswordModelCopyWithImpl<$Res, $Val extends PasswordModel>
    implements $PasswordModelCopyWith<$Res> {
  _$PasswordModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = freezed,
    Object? current_password = freezed,
    Object? password = freezed,
    Object? password_confirmation = freezed,
  }) {
    return _then(_value.copyWith(
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      current_password: freezed == current_password
          ? _value.current_password
          : current_password // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      password_confirmation: freezed == password_confirmation
          ? _value.password_confirmation
          : password_confirmation // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PasswordModelCopyWith<$Res>
    implements $PasswordModelCopyWith<$Res> {
  factory _$$_PasswordModelCopyWith(
          _$_PasswordModel value, $Res Function(_$_PasswordModel) then) =
      __$$_PasswordModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? email,
      String? current_password,
      String? password,
      String? password_confirmation});
}

/// @nodoc
class __$$_PasswordModelCopyWithImpl<$Res>
    extends _$PasswordModelCopyWithImpl<$Res, _$_PasswordModel>
    implements _$$_PasswordModelCopyWith<$Res> {
  __$$_PasswordModelCopyWithImpl(
      _$_PasswordModel _value, $Res Function(_$_PasswordModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = freezed,
    Object? current_password = freezed,
    Object? password = freezed,
    Object? password_confirmation = freezed,
  }) {
    return _then(_$_PasswordModel(
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      current_password: freezed == current_password
          ? _value.current_password
          : current_password // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      password_confirmation: freezed == password_confirmation
          ? _value.password_confirmation
          : password_confirmation // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PasswordModel implements _PasswordModel {
  const _$_PasswordModel(
      {this.email,
      this.current_password,
      this.password,
      this.password_confirmation});

  factory _$_PasswordModel.fromJson(Map<String, dynamic> json) =>
      _$$_PasswordModelFromJson(json);

  @override
  final String? email;
  @override
  final String? current_password;
  @override
  final String? password;
  @override
  final String? password_confirmation;

  @override
  String toString() {
    return 'PasswordModel(email: $email, current_password: $current_password, password: $password, password_confirmation: $password_confirmation)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PasswordModel &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.current_password, current_password) ||
                other.current_password == current_password) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.password_confirmation, password_confirmation) ||
                other.password_confirmation == password_confirmation));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, email, current_password, password, password_confirmation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PasswordModelCopyWith<_$_PasswordModel> get copyWith =>
      __$$_PasswordModelCopyWithImpl<_$_PasswordModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PasswordModelToJson(
      this,
    );
  }
}

abstract class _PasswordModel implements PasswordModel {
  const factory _PasswordModel(
      {final String? email,
      final String? current_password,
      final String? password,
      final String? password_confirmation}) = _$_PasswordModel;

  factory _PasswordModel.fromJson(Map<String, dynamic> json) =
      _$_PasswordModel.fromJson;

  @override
  String? get email;
  @override
  String? get current_password;
  @override
  String? get password;
  @override
  String? get password_confirmation;
  @override
  @JsonKey(ignore: true)
  _$$_PasswordModelCopyWith<_$_PasswordModel> get copyWith =>
      throw _privateConstructorUsedError;
}
