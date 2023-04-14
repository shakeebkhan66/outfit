// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wardrobe_list_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WardrobeListModel _$WardrobeListModelFromJson(Map<String, dynamic> json) {
  return _WardrobeListModel.fromJson(json);
}

/// @nodoc
mixin _$WardrobeListModel {
  String? get message => throw _privateConstructorUsedError;
  List<Data>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WardrobeListModelCopyWith<WardrobeListModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WardrobeListModelCopyWith<$Res> {
  factory $WardrobeListModelCopyWith(
          WardrobeListModel value, $Res Function(WardrobeListModel) then) =
      _$WardrobeListModelCopyWithImpl<$Res, WardrobeListModel>;
  @useResult
  $Res call({String? message, List<Data>? data});
}

/// @nodoc
class _$WardrobeListModelCopyWithImpl<$Res, $Val extends WardrobeListModel>
    implements $WardrobeListModelCopyWith<$Res> {
  _$WardrobeListModelCopyWithImpl(this._value, this._then);

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
              as List<Data>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WardrobeListModelCopyWith<$Res>
    implements $WardrobeListModelCopyWith<$Res> {
  factory _$$_WardrobeListModelCopyWith(_$_WardrobeListModel value,
          $Res Function(_$_WardrobeListModel) then) =
      __$$_WardrobeListModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message, List<Data>? data});
}

/// @nodoc
class __$$_WardrobeListModelCopyWithImpl<$Res>
    extends _$WardrobeListModelCopyWithImpl<$Res, _$_WardrobeListModel>
    implements _$$_WardrobeListModelCopyWith<$Res> {
  __$$_WardrobeListModelCopyWithImpl(
      _$_WardrobeListModel _value, $Res Function(_$_WardrobeListModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_$_WardrobeListModel(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<Data>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WardrobeListModel implements _WardrobeListModel {
  const _$_WardrobeListModel({this.message, final List<Data>? data})
      : _data = data;

  factory _$_WardrobeListModel.fromJson(Map<String, dynamic> json) =>
      _$$_WardrobeListModelFromJson(json);

  @override
  final String? message;
  final List<Data>? _data;
  @override
  List<Data>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'WardrobeListModel(message: $message, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WardrobeListModel &&
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
  _$$_WardrobeListModelCopyWith<_$_WardrobeListModel> get copyWith =>
      __$$_WardrobeListModelCopyWithImpl<_$_WardrobeListModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WardrobeListModelToJson(
      this,
    );
  }
}

abstract class _WardrobeListModel implements WardrobeListModel {
  const factory _WardrobeListModel(
      {final String? message, final List<Data>? data}) = _$_WardrobeListModel;

  factory _WardrobeListModel.fromJson(Map<String, dynamic> json) =
      _$_WardrobeListModel.fromJson;

  @override
  String? get message;
  @override
  List<Data>? get data;
  @override
  @JsonKey(ignore: true)
  _$$_WardrobeListModelCopyWith<_$_WardrobeListModel> get copyWith =>
      throw _privateConstructorUsedError;
}

Data _$DataFromJson(Map<String, dynamic> json) {
  return _Data.fromJson(json);
}

/// @nodoc
mixin _$Data {
  int? get id => throw _privateConstructorUsedError;
  String? get user_id => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  List<String>? get colors => throw _privateConstructorUsedError;
  DateTime? get last_updated => throw _privateConstructorUsedError;
  DateTime? get created_at => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DataCopyWith<Data> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataCopyWith<$Res> {
  factory $DataCopyWith(Data value, $Res Function(Data) then) =
      _$DataCopyWithImpl<$Res, Data>;
  @useResult
  $Res call(
      {int? id,
      String? user_id,
      String? type,
      List<String>? colors,
      DateTime? last_updated,
      DateTime? created_at});
}

/// @nodoc
class _$DataCopyWithImpl<$Res, $Val extends Data>
    implements $DataCopyWith<$Res> {
  _$DataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? user_id = freezed,
    Object? type = freezed,
    Object? colors = freezed,
    Object? last_updated = freezed,
    Object? created_at = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      user_id: freezed == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      colors: freezed == colors
          ? _value.colors
          : colors // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      last_updated: freezed == last_updated
          ? _value.last_updated
          : last_updated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DataCopyWith<$Res> implements $DataCopyWith<$Res> {
  factory _$$_DataCopyWith(_$_Data value, $Res Function(_$_Data) then) =
      __$$_DataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? user_id,
      String? type,
      List<String>? colors,
      DateTime? last_updated,
      DateTime? created_at});
}

/// @nodoc
class __$$_DataCopyWithImpl<$Res> extends _$DataCopyWithImpl<$Res, _$_Data>
    implements _$$_DataCopyWith<$Res> {
  __$$_DataCopyWithImpl(_$_Data _value, $Res Function(_$_Data) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? user_id = freezed,
    Object? type = freezed,
    Object? colors = freezed,
    Object? last_updated = freezed,
    Object? created_at = freezed,
  }) {
    return _then(_$_Data(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      user_id: freezed == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      colors: freezed == colors
          ? _value._colors
          : colors // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      last_updated: freezed == last_updated
          ? _value.last_updated
          : last_updated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Data implements _Data {
  const _$_Data(
      {this.id,
      this.user_id,
      this.type,
      final List<String>? colors,
      this.last_updated,
      this.created_at})
      : _colors = colors;

  factory _$_Data.fromJson(Map<String, dynamic> json) => _$$_DataFromJson(json);

  @override
  final int? id;
  @override
  final String? user_id;
  @override
  final String? type;
  final List<String>? _colors;
  @override
  List<String>? get colors {
    final value = _colors;
    if (value == null) return null;
    if (_colors is EqualUnmodifiableListView) return _colors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final DateTime? last_updated;
  @override
  final DateTime? created_at;

  @override
  String toString() {
    return 'Data(id: $id, user_id: $user_id, type: $type, colors: $colors, last_updated: $last_updated, created_at: $created_at)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Data &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.user_id, user_id) || other.user_id == user_id) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._colors, _colors) &&
            (identical(other.last_updated, last_updated) ||
                other.last_updated == last_updated) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, user_id, type,
      const DeepCollectionEquality().hash(_colors), last_updated, created_at);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DataCopyWith<_$_Data> get copyWith =>
      __$$_DataCopyWithImpl<_$_Data>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DataToJson(
      this,
    );
  }
}

abstract class _Data implements Data {
  const factory _Data(
      {final int? id,
      final String? user_id,
      final String? type,
      final List<String>? colors,
      final DateTime? last_updated,
      final DateTime? created_at}) = _$_Data;

  factory _Data.fromJson(Map<String, dynamic> json) = _$_Data.fromJson;

  @override
  int? get id;
  @override
  String? get user_id;
  @override
  String? get type;
  @override
  List<String>? get colors;
  @override
  DateTime? get last_updated;
  @override
  DateTime? get created_at;
  @override
  @JsonKey(ignore: true)
  _$$_DataCopyWith<_$_Data> get copyWith => throw _privateConstructorUsedError;
}
