// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'colors_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ColorsModel _$ColorsModelFromJson(Map<String, dynamic> json) {
  return _ColorsModel.fromJson(json);
}

/// @nodoc
mixin _$ColorsModel {
  String? get message => throw _privateConstructorUsedError;
  List<Data>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ColorsModelCopyWith<ColorsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ColorsModelCopyWith<$Res> {
  factory $ColorsModelCopyWith(
          ColorsModel value, $Res Function(ColorsModel) then) =
      _$ColorsModelCopyWithImpl<$Res, ColorsModel>;
  @useResult
  $Res call({String? message, List<Data>? data});
}

/// @nodoc
class _$ColorsModelCopyWithImpl<$Res, $Val extends ColorsModel>
    implements $ColorsModelCopyWith<$Res> {
  _$ColorsModelCopyWithImpl(this._value, this._then);

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
abstract class _$$_ColorsModelCopyWith<$Res>
    implements $ColorsModelCopyWith<$Res> {
  factory _$$_ColorsModelCopyWith(
          _$_ColorsModel value, $Res Function(_$_ColorsModel) then) =
      __$$_ColorsModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message, List<Data>? data});
}

/// @nodoc
class __$$_ColorsModelCopyWithImpl<$Res>
    extends _$ColorsModelCopyWithImpl<$Res, _$_ColorsModel>
    implements _$$_ColorsModelCopyWith<$Res> {
  __$$_ColorsModelCopyWithImpl(
      _$_ColorsModel _value, $Res Function(_$_ColorsModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_$_ColorsModel(
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
class _$_ColorsModel implements _ColorsModel {
  const _$_ColorsModel({this.message, final List<Data>? data}) : _data = data;

  factory _$_ColorsModel.fromJson(Map<String, dynamic> json) =>
      _$$_ColorsModelFromJson(json);

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
    return 'ColorsModel(message: $message, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ColorsModel &&
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
  _$$_ColorsModelCopyWith<_$_ColorsModel> get copyWith =>
      __$$_ColorsModelCopyWithImpl<_$_ColorsModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ColorsModelToJson(
      this,
    );
  }
}

abstract class _ColorsModel implements ColorsModel {
  const factory _ColorsModel({final String? message, final List<Data>? data}) =
      _$_ColorsModel;

  factory _ColorsModel.fromJson(Map<String, dynamic> json) =
      _$_ColorsModel.fromJson;

  @override
  String? get message;
  @override
  List<Data>? get data;
  @override
  @JsonKey(ignore: true)
  _$$_ColorsModelCopyWith<_$_ColorsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

Data _$DataFromJson(Map<String, dynamic> json) {
  return _Data.fromJson(json);
}

/// @nodoc
mixin _$Data {
  int? get cid => throw _privateConstructorUsedError;
  int? get sort_order => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get hex => throw _privateConstructorUsedError;
  String? get name_en => throw _privateConstructorUsedError;
  String? get name_fr => throw _privateConstructorUsedError;
  String? get name_ger => throw _privateConstructorUsedError;
  String? get name_es => throw _privateConstructorUsedError;
  String? get pattern => throw _privateConstructorUsedError;
  int? get patterned => throw _privateConstructorUsedError;
  int? get jacket_filter => throw _privateConstructorUsedError;

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
      {int? cid,
      int? sort_order,
      String? name,
      String? hex,
      String? name_en,
      String? name_fr,
      String? name_ger,
      String? name_es,
      String? pattern,
      int? patterned,
      int? jacket_filter});
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
    Object? cid = freezed,
    Object? sort_order = freezed,
    Object? name = freezed,
    Object? hex = freezed,
    Object? name_en = freezed,
    Object? name_fr = freezed,
    Object? name_ger = freezed,
    Object? name_es = freezed,
    Object? pattern = freezed,
    Object? patterned = freezed,
    Object? jacket_filter = freezed,
  }) {
    return _then(_value.copyWith(
      cid: freezed == cid
          ? _value.cid
          : cid // ignore: cast_nullable_to_non_nullable
              as int?,
      sort_order: freezed == sort_order
          ? _value.sort_order
          : sort_order // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      hex: freezed == hex
          ? _value.hex
          : hex // ignore: cast_nullable_to_non_nullable
              as String?,
      name_en: freezed == name_en
          ? _value.name_en
          : name_en // ignore: cast_nullable_to_non_nullable
              as String?,
      name_fr: freezed == name_fr
          ? _value.name_fr
          : name_fr // ignore: cast_nullable_to_non_nullable
              as String?,
      name_ger: freezed == name_ger
          ? _value.name_ger
          : name_ger // ignore: cast_nullable_to_non_nullable
              as String?,
      name_es: freezed == name_es
          ? _value.name_es
          : name_es // ignore: cast_nullable_to_non_nullable
              as String?,
      pattern: freezed == pattern
          ? _value.pattern
          : pattern // ignore: cast_nullable_to_non_nullable
              as String?,
      patterned: freezed == patterned
          ? _value.patterned
          : patterned // ignore: cast_nullable_to_non_nullable
              as int?,
      jacket_filter: freezed == jacket_filter
          ? _value.jacket_filter
          : jacket_filter // ignore: cast_nullable_to_non_nullable
              as int?,
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
      {int? cid,
      int? sort_order,
      String? name,
      String? hex,
      String? name_en,
      String? name_fr,
      String? name_ger,
      String? name_es,
      String? pattern,
      int? patterned,
      int? jacket_filter});
}

/// @nodoc
class __$$_DataCopyWithImpl<$Res> extends _$DataCopyWithImpl<$Res, _$_Data>
    implements _$$_DataCopyWith<$Res> {
  __$$_DataCopyWithImpl(_$_Data _value, $Res Function(_$_Data) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cid = freezed,
    Object? sort_order = freezed,
    Object? name = freezed,
    Object? hex = freezed,
    Object? name_en = freezed,
    Object? name_fr = freezed,
    Object? name_ger = freezed,
    Object? name_es = freezed,
    Object? pattern = freezed,
    Object? patterned = freezed,
    Object? jacket_filter = freezed,
  }) {
    return _then(_$_Data(
      cid: freezed == cid
          ? _value.cid
          : cid // ignore: cast_nullable_to_non_nullable
              as int?,
      sort_order: freezed == sort_order
          ? _value.sort_order
          : sort_order // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      hex: freezed == hex
          ? _value.hex
          : hex // ignore: cast_nullable_to_non_nullable
              as String?,
      name_en: freezed == name_en
          ? _value.name_en
          : name_en // ignore: cast_nullable_to_non_nullable
              as String?,
      name_fr: freezed == name_fr
          ? _value.name_fr
          : name_fr // ignore: cast_nullable_to_non_nullable
              as String?,
      name_ger: freezed == name_ger
          ? _value.name_ger
          : name_ger // ignore: cast_nullable_to_non_nullable
              as String?,
      name_es: freezed == name_es
          ? _value.name_es
          : name_es // ignore: cast_nullable_to_non_nullable
              as String?,
      pattern: freezed == pattern
          ? _value.pattern
          : pattern // ignore: cast_nullable_to_non_nullable
              as String?,
      patterned: freezed == patterned
          ? _value.patterned
          : patterned // ignore: cast_nullable_to_non_nullable
              as int?,
      jacket_filter: freezed == jacket_filter
          ? _value.jacket_filter
          : jacket_filter // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Data implements _Data {
  const _$_Data(
      {this.cid,
      this.sort_order,
      this.name,
      this.hex,
      this.name_en,
      this.name_fr,
      this.name_ger,
      this.name_es,
      this.pattern,
      this.patterned,
      this.jacket_filter});

  factory _$_Data.fromJson(Map<String, dynamic> json) => _$$_DataFromJson(json);

  @override
  final int? cid;
  @override
  final int? sort_order;
  @override
  final String? name;
  @override
  final String? hex;
  @override
  final String? name_en;
  @override
  final String? name_fr;
  @override
  final String? name_ger;
  @override
  final String? name_es;
  @override
  final String? pattern;
  @override
  final int? patterned;
  @override
  final int? jacket_filter;

  @override
  String toString() {
    return 'Data(cid: $cid, sort_order: $sort_order, name: $name, hex: $hex, name_en: $name_en, name_fr: $name_fr, name_ger: $name_ger, name_es: $name_es, pattern: $pattern, patterned: $patterned, jacket_filter: $jacket_filter)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Data &&
            (identical(other.cid, cid) || other.cid == cid) &&
            (identical(other.sort_order, sort_order) ||
                other.sort_order == sort_order) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.hex, hex) || other.hex == hex) &&
            (identical(other.name_en, name_en) || other.name_en == name_en) &&
            (identical(other.name_fr, name_fr) || other.name_fr == name_fr) &&
            (identical(other.name_ger, name_ger) ||
                other.name_ger == name_ger) &&
            (identical(other.name_es, name_es) || other.name_es == name_es) &&
            (identical(other.pattern, pattern) || other.pattern == pattern) &&
            (identical(other.patterned, patterned) ||
                other.patterned == patterned) &&
            (identical(other.jacket_filter, jacket_filter) ||
                other.jacket_filter == jacket_filter));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, cid, sort_order, name, hex,
      name_en, name_fr, name_ger, name_es, pattern, patterned, jacket_filter);

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
      {final int? cid,
      final int? sort_order,
      final String? name,
      final String? hex,
      final String? name_en,
      final String? name_fr,
      final String? name_ger,
      final String? name_es,
      final String? pattern,
      final int? patterned,
      final int? jacket_filter}) = _$_Data;

  factory _Data.fromJson(Map<String, dynamic> json) = _$_Data.fromJson;

  @override
  int? get cid;
  @override
  int? get sort_order;
  @override
  String? get name;
  @override
  String? get hex;
  @override
  String? get name_en;
  @override
  String? get name_fr;
  @override
  String? get name_ger;
  @override
  String? get name_es;
  @override
  String? get pattern;
  @override
  int? get patterned;
  @override
  int? get jacket_filter;
  @override
  @JsonKey(ignore: true)
  _$$_DataCopyWith<_$_Data> get copyWith => throw _privateConstructorUsedError;
}
