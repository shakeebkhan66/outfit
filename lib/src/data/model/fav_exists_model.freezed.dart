// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fav_exists_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FavExistsModel _$FavExistsModelFromJson(Map<String, dynamic> json) {
  return _FavExistsModel.fromJson(json);
}

/// @nodoc
mixin _$FavExistsModel {
  String? get message => throw _privateConstructorUsedError;
  List<FavExistsData>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FavExistsModelCopyWith<FavExistsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavExistsModelCopyWith<$Res> {
  factory $FavExistsModelCopyWith(
          FavExistsModel value, $Res Function(FavExistsModel) then) =
      _$FavExistsModelCopyWithImpl<$Res, FavExistsModel>;
  @useResult
  $Res call({String? message, List<FavExistsData>? data});
}

/// @nodoc
class _$FavExistsModelCopyWithImpl<$Res, $Val extends FavExistsModel>
    implements $FavExistsModelCopyWith<$Res> {
  _$FavExistsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<FavExistsData>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FavExistsModelCopyWith<$Res>
    implements $FavExistsModelCopyWith<$Res> {
  factory _$$_FavExistsModelCopyWith(
          _$_FavExistsModel value, $Res Function(_$_FavExistsModel) then) =
      __$$_FavExistsModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message, List<FavExistsData>? data});
}

/// @nodoc
class __$$_FavExistsModelCopyWithImpl<$Res>
    extends _$FavExistsModelCopyWithImpl<$Res, _$_FavExistsModel>
    implements _$$_FavExistsModelCopyWith<$Res> {
  __$$_FavExistsModelCopyWithImpl(
      _$_FavExistsModel _value, $Res Function(_$_FavExistsModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_$_FavExistsModel(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<FavExistsData>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FavExistsModel implements _FavExistsModel {
  const _$_FavExistsModel({this.message, final List<FavExistsData>? data})
      : _data = data;

  factory _$_FavExistsModel.fromJson(Map<String, dynamic> json) =>
      _$$_FavExistsModelFromJson(json);

  @override
  final String? message;
  final List<FavExistsData>? _data;
  @override
  List<FavExistsData>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'FavExistsModel(message: $message, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FavExistsModel &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, message, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FavExistsModelCopyWith<_$_FavExistsModel> get copyWith =>
      __$$_FavExistsModelCopyWithImpl<_$_FavExistsModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FavExistsModelToJson(
      this,
    );
  }
}

abstract class _FavExistsModel implements FavExistsModel {
  const factory _FavExistsModel(
      {final String? message,
      final List<FavExistsData>? data}) = _$_FavExistsModel;

  factory _FavExistsModel.fromJson(Map<String, dynamic> json) =
      _$_FavExistsModel.fromJson;

  @override
  String? get message;
  @override
  List<FavExistsData>? get data;
  @override
  @JsonKey(ignore: true)
  _$$_FavExistsModelCopyWith<_$_FavExistsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

FavExistsData _$FavExistsDataFromJson(Map<String, dynamic> json) {
  return _FavExistsData.fromJson(json);
}

/// @nodoc
mixin _$FavExistsData {
  int? get id => throw _privateConstructorUsedError;
  String? get user => throw _privateConstructorUsedError;
  int? get list => throw _privateConstructorUsedError;
  int? get img => throw _privateConstructorUsedError;
  String? get created_at => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FavExistsDataCopyWith<FavExistsData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavExistsDataCopyWith<$Res> {
  factory $FavExistsDataCopyWith(
          FavExistsData value, $Res Function(FavExistsData) then) =
      _$FavExistsDataCopyWithImpl<$Res, FavExistsData>;
  @useResult
  $Res call({int? id, String? user, int? list, int? img, String? created_at});
}

/// @nodoc
class _$FavExistsDataCopyWithImpl<$Res, $Val extends FavExistsData>
    implements $FavExistsDataCopyWith<$Res> {
  _$FavExistsDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? user = freezed,
    Object? list = freezed,
    Object? img = freezed,
    Object? created_at = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as String?,
      list: freezed == list
          ? _value.list
          : list // ignore: cast_nullable_to_non_nullable
              as int?,
      img: freezed == img
          ? _value.img
          : img // ignore: cast_nullable_to_non_nullable
              as int?,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FavExistsDataCopyWith<$Res>
    implements $FavExistsDataCopyWith<$Res> {
  factory _$$_FavExistsDataCopyWith(
          _$_FavExistsData value, $Res Function(_$_FavExistsData) then) =
      __$$_FavExistsDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? user, int? list, int? img, String? created_at});
}

/// @nodoc
class __$$_FavExistsDataCopyWithImpl<$Res>
    extends _$FavExistsDataCopyWithImpl<$Res, _$_FavExistsData>
    implements _$$_FavExistsDataCopyWith<$Res> {
  __$$_FavExistsDataCopyWithImpl(
      _$_FavExistsData _value, $Res Function(_$_FavExistsData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? user = freezed,
    Object? list = freezed,
    Object? img = freezed,
    Object? created_at = freezed,
  }) {
    return _then(_$_FavExistsData(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as String?,
      list: freezed == list
          ? _value.list
          : list // ignore: cast_nullable_to_non_nullable
              as int?,
      img: freezed == img
          ? _value.img
          : img // ignore: cast_nullable_to_non_nullable
              as int?,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FavExistsData implements _FavExistsData {
  const _$_FavExistsData(
      {this.id, this.user, this.list, this.img, this.created_at});

  factory _$_FavExistsData.fromJson(Map<String, dynamic> json) =>
      _$$_FavExistsDataFromJson(json);

  @override
  final int? id;
  @override
  final String? user;
  @override
  final int? list;
  @override
  final int? img;
  @override
  final String? created_at;

  @override
  String toString() {
    return 'FavExistsData(id: $id, user: $user, list: $list, img: $img, created_at: $created_at)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FavExistsData &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.list, list) || other.list == list) &&
            (identical(other.img, img) || other.img == img) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, user, list, img, created_at);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FavExistsDataCopyWith<_$_FavExistsData> get copyWith =>
      __$$_FavExistsDataCopyWithImpl<_$_FavExistsData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FavExistsDataToJson(
      this,
    );
  }
}

abstract class _FavExistsData implements FavExistsData {
  const factory _FavExistsData(
      {final int? id,
      final String? user,
      final int? list,
      final int? img,
      final String? created_at}) = _$_FavExistsData;

  factory _FavExistsData.fromJson(Map<String, dynamic> json) =
      _$_FavExistsData.fromJson;

  @override
  int? get id;
  @override
  String? get user;
  @override
  int? get list;
  @override
  int? get img;
  @override
  String? get created_at;
  @override
  @JsonKey(ignore: true)
  _$$_FavExistsDataCopyWith<_$_FavExistsData> get copyWith =>
      throw _privateConstructorUsedError;
}
