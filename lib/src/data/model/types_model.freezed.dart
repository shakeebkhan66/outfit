// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'types_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TypesModel _$TypesModelFromJson(Map<String, dynamic> json) {
  return _TypesModel.fromJson(json);
}

/// @nodoc
mixin _$TypesModel {
  String? get message => throw _privateConstructorUsedError;
  List<Data>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TypesModelCopyWith<TypesModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TypesModelCopyWith<$Res> {
  factory $TypesModelCopyWith(
          TypesModel value, $Res Function(TypesModel) then) =
      _$TypesModelCopyWithImpl<$Res, TypesModel>;
  @useResult
  $Res call({String? message, List<Data>? data});
}

/// @nodoc
class _$TypesModelCopyWithImpl<$Res, $Val extends TypesModel>
    implements $TypesModelCopyWith<$Res> {
  _$TypesModelCopyWithImpl(this._value, this._then);

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
abstract class _$$_TypesModelCopyWith<$Res>
    implements $TypesModelCopyWith<$Res> {
  factory _$$_TypesModelCopyWith(
          _$_TypesModel value, $Res Function(_$_TypesModel) then) =
      __$$_TypesModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message, List<Data>? data});
}

/// @nodoc
class __$$_TypesModelCopyWithImpl<$Res>
    extends _$TypesModelCopyWithImpl<$Res, _$_TypesModel>
    implements _$$_TypesModelCopyWith<$Res> {
  __$$_TypesModelCopyWithImpl(
      _$_TypesModel _value, $Res Function(_$_TypesModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_$_TypesModel(
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
class _$_TypesModel implements _TypesModel {
  const _$_TypesModel({this.message, final List<Data>? data}) : _data = data;

  factory _$_TypesModel.fromJson(Map<String, dynamic> json) =>
      _$$_TypesModelFromJson(json);

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
    return 'TypesModel(message: $message, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TypesModel &&
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
  _$$_TypesModelCopyWith<_$_TypesModel> get copyWith =>
      __$$_TypesModelCopyWithImpl<_$_TypesModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TypesModelToJson(
      this,
    );
  }
}

abstract class _TypesModel implements TypesModel {
  const factory _TypesModel({final String? message, final List<Data>? data}) =
      _$_TypesModel;

  factory _TypesModel.fromJson(Map<String, dynamic> json) =
      _$_TypesModel.fromJson;

  @override
  String? get message;
  @override
  List<Data>? get data;
  @override
  @JsonKey(ignore: true)
  _$$_TypesModelCopyWith<_$_TypesModel> get copyWith =>
      throw _privateConstructorUsedError;
}

Data _$DataFromJson(Map<String, dynamic> json) {
  return _Data.fromJson(json);
}

/// @nodoc
mixin _$Data {
  int? get tid => throw _privateConstructorUsedError;
  int? get sort_order => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get en_name => throw _privateConstructorUsedError;
  String? get fr_name => throw _privateConstructorUsedError;
  String? get ger_name => throw _privateConstructorUsedError;
  String? get es_name => throw _privateConstructorUsedError;

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
      {int? tid,
      int? sort_order,
      String? name,
      String? en_name,
      String? fr_name,
      String? ger_name,
      String? es_name});
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
    Object? tid = freezed,
    Object? sort_order = freezed,
    Object? name = freezed,
    Object? en_name = freezed,
    Object? fr_name = freezed,
    Object? ger_name = freezed,
    Object? es_name = freezed,
  }) {
    return _then(_value.copyWith(
      tid: freezed == tid
          ? _value.tid
          : tid // ignore: cast_nullable_to_non_nullable
              as int?,
      sort_order: freezed == sort_order
          ? _value.sort_order
          : sort_order // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      en_name: freezed == en_name
          ? _value.en_name
          : en_name // ignore: cast_nullable_to_non_nullable
              as String?,
      fr_name: freezed == fr_name
          ? _value.fr_name
          : fr_name // ignore: cast_nullable_to_non_nullable
              as String?,
      ger_name: freezed == ger_name
          ? _value.ger_name
          : ger_name // ignore: cast_nullable_to_non_nullable
              as String?,
      es_name: freezed == es_name
          ? _value.es_name
          : es_name // ignore: cast_nullable_to_non_nullable
              as String?,
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
      {int? tid,
      int? sort_order,
      String? name,
      String? en_name,
      String? fr_name,
      String? ger_name,
      String? es_name});
}

/// @nodoc
class __$$_DataCopyWithImpl<$Res> extends _$DataCopyWithImpl<$Res, _$_Data>
    implements _$$_DataCopyWith<$Res> {
  __$$_DataCopyWithImpl(_$_Data _value, $Res Function(_$_Data) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tid = freezed,
    Object? sort_order = freezed,
    Object? name = freezed,
    Object? en_name = freezed,
    Object? fr_name = freezed,
    Object? ger_name = freezed,
    Object? es_name = freezed,
  }) {
    return _then(_$_Data(
      tid: freezed == tid
          ? _value.tid
          : tid // ignore: cast_nullable_to_non_nullable
              as int?,
      sort_order: freezed == sort_order
          ? _value.sort_order
          : sort_order // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      en_name: freezed == en_name
          ? _value.en_name
          : en_name // ignore: cast_nullable_to_non_nullable
              as String?,
      fr_name: freezed == fr_name
          ? _value.fr_name
          : fr_name // ignore: cast_nullable_to_non_nullable
              as String?,
      ger_name: freezed == ger_name
          ? _value.ger_name
          : ger_name // ignore: cast_nullable_to_non_nullable
              as String?,
      es_name: freezed == es_name
          ? _value.es_name
          : es_name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Data implements _Data {
  const _$_Data(
      {this.tid,
      this.sort_order,
      this.name,
      this.en_name,
      this.fr_name,
      this.ger_name,
      this.es_name});

  factory _$_Data.fromJson(Map<String, dynamic> json) => _$$_DataFromJson(json);

  @override
  final int? tid;
  @override
  final int? sort_order;
  @override
  final String? name;
  @override
  final String? en_name;
  @override
  final String? fr_name;
  @override
  final String? ger_name;
  @override
  final String? es_name;

  @override
  String toString() {
    return 'Data(tid: $tid, sort_order: $sort_order, name: $name, en_name: $en_name, fr_name: $fr_name, ger_name: $ger_name, es_name: $es_name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Data &&
            (identical(other.tid, tid) || other.tid == tid) &&
            (identical(other.sort_order, sort_order) ||
                other.sort_order == sort_order) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.en_name, en_name) || other.en_name == en_name) &&
            (identical(other.fr_name, fr_name) || other.fr_name == fr_name) &&
            (identical(other.ger_name, ger_name) ||
                other.ger_name == ger_name) &&
            (identical(other.es_name, es_name) || other.es_name == es_name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, tid, sort_order, name, en_name, fr_name, ger_name, es_name);

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
      {final int? tid,
      final int? sort_order,
      final String? name,
      final String? en_name,
      final String? fr_name,
      final String? ger_name,
      final String? es_name}) = _$_Data;

  factory _Data.fromJson(Map<String, dynamic> json) = _$_Data.fromJson;

  @override
  int? get tid;
  @override
  int? get sort_order;
  @override
  String? get name;
  @override
  String? get en_name;
  @override
  String? get fr_name;
  @override
  String? get ger_name;
  @override
  String? get es_name;
  @override
  @JsonKey(ignore: true)
  _$$_DataCopyWith<_$_Data> get copyWith => throw _privateConstructorUsedError;
}
