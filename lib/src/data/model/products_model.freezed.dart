// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'products_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ProductsModel _$ProductsModelFromJson(Map<String, dynamic> json) {
  return _ProductsModel.fromJson(json);
}

/// @nodoc
mixin _$ProductsModel {
  String? get message => throw _privateConstructorUsedError;
  Data? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductsModelCopyWith<ProductsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductsModelCopyWith<$Res> {
  factory $ProductsModelCopyWith(
          ProductsModel value, $Res Function(ProductsModel) then) =
      _$ProductsModelCopyWithImpl<$Res, ProductsModel>;
  @useResult
  $Res call({String? message, Data? data});

  $DataCopyWith<$Res>? get data;
}

/// @nodoc
class _$ProductsModelCopyWithImpl<$Res, $Val extends ProductsModel>
    implements $ProductsModelCopyWith<$Res> {
  _$ProductsModelCopyWithImpl(this._value, this._then);

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
              as Data?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DataCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $DataCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ProductsModelCopyWith<$Res>
    implements $ProductsModelCopyWith<$Res> {
  factory _$$_ProductsModelCopyWith(
          _$_ProductsModel value, $Res Function(_$_ProductsModel) then) =
      __$$_ProductsModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message, Data? data});

  @override
  $DataCopyWith<$Res>? get data;
}

/// @nodoc
class __$$_ProductsModelCopyWithImpl<$Res>
    extends _$ProductsModelCopyWithImpl<$Res, _$_ProductsModel>
    implements _$$_ProductsModelCopyWith<$Res> {
  __$$_ProductsModelCopyWithImpl(
      _$_ProductsModel _value, $Res Function(_$_ProductsModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_$_ProductsModel(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Data?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ProductsModel implements _ProductsModel {
  const _$_ProductsModel({this.message, this.data});

  factory _$_ProductsModel.fromJson(Map<String, dynamic> json) =>
      _$$_ProductsModelFromJson(json);

  @override
  final String? message;
  @override
  final Data? data;

  @override
  String toString() {
    return 'ProductsModel(message: $message, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProductsModel &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, message, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProductsModelCopyWith<_$_ProductsModel> get copyWith =>
      __$$_ProductsModelCopyWithImpl<_$_ProductsModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProductsModelToJson(
      this,
    );
  }
}

abstract class _ProductsModel implements ProductsModel {
  const factory _ProductsModel({final String? message, final Data? data}) =
      _$_ProductsModel;

  factory _ProductsModel.fromJson(Map<String, dynamic> json) =
      _$_ProductsModel.fromJson;

  @override
  String? get message;
  @override
  Data? get data;
  @override
  @JsonKey(ignore: true)
  _$$_ProductsModelCopyWith<_$_ProductsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

Data _$DataFromJson(Map<String, dynamic> json) {
  return _Data.fromJson(json);
}

/// @nodoc
mixin _$Data {
  int? get current_page => throw _privateConstructorUsedError;
  List<ProductsData>? get data => throw _privateConstructorUsedError;
  String? get first_page_url => throw _privateConstructorUsedError;
  int? get from => throw _privateConstructorUsedError;
  int? get last_page => throw _privateConstructorUsedError;
  String? get last_page_url => throw _privateConstructorUsedError;
  List<Links>? get links => throw _privateConstructorUsedError;
  String? get next_page_url => throw _privateConstructorUsedError;
  String? get path => throw _privateConstructorUsedError;
  int? get per_page => throw _privateConstructorUsedError;
  String? get prev_page_url => throw _privateConstructorUsedError;
  int? get to => throw _privateConstructorUsedError;
  int? get total => throw _privateConstructorUsedError;

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
      {int? current_page,
      List<ProductsData>? data,
      String? first_page_url,
      int? from,
      int? last_page,
      String? last_page_url,
      List<Links>? links,
      String? next_page_url,
      String? path,
      int? per_page,
      String? prev_page_url,
      int? to,
      int? total});
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
    Object? current_page = freezed,
    Object? data = freezed,
    Object? first_page_url = freezed,
    Object? from = freezed,
    Object? last_page = freezed,
    Object? last_page_url = freezed,
    Object? links = freezed,
    Object? next_page_url = freezed,
    Object? path = freezed,
    Object? per_page = freezed,
    Object? prev_page_url = freezed,
    Object? to = freezed,
    Object? total = freezed,
  }) {
    return _then(_value.copyWith(
      current_page: freezed == current_page
          ? _value.current_page
          : current_page // ignore: cast_nullable_to_non_nullable
              as int?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<ProductsData>?,
      first_page_url: freezed == first_page_url
          ? _value.first_page_url
          : first_page_url // ignore: cast_nullable_to_non_nullable
              as String?,
      from: freezed == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as int?,
      last_page: freezed == last_page
          ? _value.last_page
          : last_page // ignore: cast_nullable_to_non_nullable
              as int?,
      last_page_url: freezed == last_page_url
          ? _value.last_page_url
          : last_page_url // ignore: cast_nullable_to_non_nullable
              as String?,
      links: freezed == links
          ? _value.links
          : links // ignore: cast_nullable_to_non_nullable
              as List<Links>?,
      next_page_url: freezed == next_page_url
          ? _value.next_page_url
          : next_page_url // ignore: cast_nullable_to_non_nullable
              as String?,
      path: freezed == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
      per_page: freezed == per_page
          ? _value.per_page
          : per_page // ignore: cast_nullable_to_non_nullable
              as int?,
      prev_page_url: freezed == prev_page_url
          ? _value.prev_page_url
          : prev_page_url // ignore: cast_nullable_to_non_nullable
              as String?,
      to: freezed == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as int?,
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
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
      {int? current_page,
      List<ProductsData>? data,
      String? first_page_url,
      int? from,
      int? last_page,
      String? last_page_url,
      List<Links>? links,
      String? next_page_url,
      String? path,
      int? per_page,
      String? prev_page_url,
      int? to,
      int? total});
}

/// @nodoc
class __$$_DataCopyWithImpl<$Res> extends _$DataCopyWithImpl<$Res, _$_Data>
    implements _$$_DataCopyWith<$Res> {
  __$$_DataCopyWithImpl(_$_Data _value, $Res Function(_$_Data) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? current_page = freezed,
    Object? data = freezed,
    Object? first_page_url = freezed,
    Object? from = freezed,
    Object? last_page = freezed,
    Object? last_page_url = freezed,
    Object? links = freezed,
    Object? next_page_url = freezed,
    Object? path = freezed,
    Object? per_page = freezed,
    Object? prev_page_url = freezed,
    Object? to = freezed,
    Object? total = freezed,
  }) {
    return _then(_$_Data(
      current_page: freezed == current_page
          ? _value.current_page
          : current_page // ignore: cast_nullable_to_non_nullable
              as int?,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<ProductsData>?,
      first_page_url: freezed == first_page_url
          ? _value.first_page_url
          : first_page_url // ignore: cast_nullable_to_non_nullable
              as String?,
      from: freezed == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as int?,
      last_page: freezed == last_page
          ? _value.last_page
          : last_page // ignore: cast_nullable_to_non_nullable
              as int?,
      last_page_url: freezed == last_page_url
          ? _value.last_page_url
          : last_page_url // ignore: cast_nullable_to_non_nullable
              as String?,
      links: freezed == links
          ? _value._links
          : links // ignore: cast_nullable_to_non_nullable
              as List<Links>?,
      next_page_url: freezed == next_page_url
          ? _value.next_page_url
          : next_page_url // ignore: cast_nullable_to_non_nullable
              as String?,
      path: freezed == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
      per_page: freezed == per_page
          ? _value.per_page
          : per_page // ignore: cast_nullable_to_non_nullable
              as int?,
      prev_page_url: freezed == prev_page_url
          ? _value.prev_page_url
          : prev_page_url // ignore: cast_nullable_to_non_nullable
              as String?,
      to: freezed == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as int?,
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Data implements _Data {
  const _$_Data(
      {this.current_page,
      final List<ProductsData>? data,
      this.first_page_url,
      this.from,
      this.last_page,
      this.last_page_url,
      final List<Links>? links,
      this.next_page_url,
      this.path,
      this.per_page,
      this.prev_page_url,
      this.to,
      this.total})
      : _data = data,
        _links = links;

  factory _$_Data.fromJson(Map<String, dynamic> json) => _$$_DataFromJson(json);

  @override
  final int? current_page;
  final List<ProductsData>? _data;
  @override
  List<ProductsData>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? first_page_url;
  @override
  final int? from;
  @override
  final int? last_page;
  @override
  final String? last_page_url;
  final List<Links>? _links;
  @override
  List<Links>? get links {
    final value = _links;
    if (value == null) return null;
    if (_links is EqualUnmodifiableListView) return _links;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? next_page_url;
  @override
  final String? path;
  @override
  final int? per_page;
  @override
  final String? prev_page_url;
  @override
  final int? to;
  @override
  final int? total;

  @override
  String toString() {
    return 'Data(current_page: $current_page, data: $data, first_page_url: $first_page_url, from: $from, last_page: $last_page, last_page_url: $last_page_url, links: $links, next_page_url: $next_page_url, path: $path, per_page: $per_page, prev_page_url: $prev_page_url, to: $to, total: $total)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Data &&
            (identical(other.current_page, current_page) ||
                other.current_page == current_page) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.first_page_url, first_page_url) ||
                other.first_page_url == first_page_url) &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.last_page, last_page) ||
                other.last_page == last_page) &&
            (identical(other.last_page_url, last_page_url) ||
                other.last_page_url == last_page_url) &&
            const DeepCollectionEquality().equals(other._links, _links) &&
            (identical(other.next_page_url, next_page_url) ||
                other.next_page_url == next_page_url) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.per_page, per_page) ||
                other.per_page == per_page) &&
            (identical(other.prev_page_url, prev_page_url) ||
                other.prev_page_url == prev_page_url) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      current_page,
      const DeepCollectionEquality().hash(_data),
      first_page_url,
      from,
      last_page,
      last_page_url,
      const DeepCollectionEquality().hash(_links),
      next_page_url,
      path,
      per_page,
      prev_page_url,
      to,
      total);

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
      {final int? current_page,
      final List<ProductsData>? data,
      final String? first_page_url,
      final int? from,
      final int? last_page,
      final String? last_page_url,
      final List<Links>? links,
      final String? next_page_url,
      final String? path,
      final int? per_page,
      final String? prev_page_url,
      final int? to,
      final int? total}) = _$_Data;

  factory _Data.fromJson(Map<String, dynamic> json) = _$_Data.fromJson;

  @override
  int? get current_page;
  @override
  List<ProductsData>? get data;
  @override
  String? get first_page_url;
  @override
  int? get from;
  @override
  int? get last_page;
  @override
  String? get last_page_url;
  @override
  List<Links>? get links;
  @override
  String? get next_page_url;
  @override
  String? get path;
  @override
  int? get per_page;
  @override
  String? get prev_page_url;
  @override
  int? get to;
  @override
  int? get total;
  @override
  @JsonKey(ignore: true)
  _$$_DataCopyWith<_$_Data> get copyWith => throw _privateConstructorUsedError;
}

ProductsData _$ProductsDataFromJson(Map<String, dynamic> json) {
  return _ProductsData.fromJson(json);
}

/// @nodoc
mixin _$ProductsData {
  int? get uid => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  int? get type => throw _privateConstructorUsedError;
  int? get color => throw _privateConstructorUsedError;
  int? get type2 => throw _privateConstructorUsedError;
  int? get color2 => throw _privateConstructorUsedError;
  int? get type3 => throw _privateConstructorUsedError;
  int? get color3 => throw _privateConstructorUsedError;
  int? get type4 => throw _privateConstructorUsedError;
  int? get color4 => throw _privateConstructorUsedError;
  int? get hijab => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime? get time => throw _privateConstructorUsedError;
  int? get likes => throw _privateConstructorUsedError;
  int? get comments => throw _privateConstructorUsedError;
  int? get favourit => throw _privateConstructorUsedError;
  int? get approved => throw _privateConstructorUsedError;
  String? get source => throw _privateConstructorUsedError;
  int? get ptn => throw _privateConstructorUsedError;
  int? get ptn2 => throw _privateConstructorUsedError;
  int? get ptn3 => throw _privateConstructorUsedError;
  int? get ptn4 => throw _privateConstructorUsedError;
  int? get above_95 => throw _privateConstructorUsedError;
  String? get season => throw _privateConstructorUsedError;
  int? get moved => throw _privateConstructorUsedError;
  String? get jacket => throw _privateConstructorUsedError;
  String? get approved_by => throw _privateConstructorUsedError;
  DateTime? get created_at => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductsDataCopyWith<ProductsData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductsDataCopyWith<$Res> {
  factory $ProductsDataCopyWith(
          ProductsData value, $Res Function(ProductsData) then) =
      _$ProductsDataCopyWithImpl<$Res, ProductsData>;
  @useResult
  $Res call(
      {int? uid,
      String? url,
      String? name,
      String? email,
      int? type,
      int? color,
      int? type2,
      int? color2,
      int? type3,
      int? color3,
      int? type4,
      int? color4,
      int? hijab,
      String? description,
      DateTime? time,
      int? likes,
      int? comments,
      int? favourit,
      int? approved,
      String? source,
      int? ptn,
      int? ptn2,
      int? ptn3,
      int? ptn4,
      int? above_95,
      String? season,
      int? moved,
      String? jacket,
      String? approved_by,
      DateTime? created_at});
}

/// @nodoc
class _$ProductsDataCopyWithImpl<$Res, $Val extends ProductsData>
    implements $ProductsDataCopyWith<$Res> {
  _$ProductsDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = freezed,
    Object? url = freezed,
    Object? name = freezed,
    Object? email = freezed,
    Object? type = freezed,
    Object? color = freezed,
    Object? type2 = freezed,
    Object? color2 = freezed,
    Object? type3 = freezed,
    Object? color3 = freezed,
    Object? type4 = freezed,
    Object? color4 = freezed,
    Object? hijab = freezed,
    Object? description = freezed,
    Object? time = freezed,
    Object? likes = freezed,
    Object? comments = freezed,
    Object? favourit = freezed,
    Object? approved = freezed,
    Object? source = freezed,
    Object? ptn = freezed,
    Object? ptn2 = freezed,
    Object? ptn3 = freezed,
    Object? ptn4 = freezed,
    Object? above_95 = freezed,
    Object? season = freezed,
    Object? moved = freezed,
    Object? jacket = freezed,
    Object? approved_by = freezed,
    Object? created_at = freezed,
  }) {
    return _then(_value.copyWith(
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as int?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as int?,
      type2: freezed == type2
          ? _value.type2
          : type2 // ignore: cast_nullable_to_non_nullable
              as int?,
      color2: freezed == color2
          ? _value.color2
          : color2 // ignore: cast_nullable_to_non_nullable
              as int?,
      type3: freezed == type3
          ? _value.type3
          : type3 // ignore: cast_nullable_to_non_nullable
              as int?,
      color3: freezed == color3
          ? _value.color3
          : color3 // ignore: cast_nullable_to_non_nullable
              as int?,
      type4: freezed == type4
          ? _value.type4
          : type4 // ignore: cast_nullable_to_non_nullable
              as int?,
      color4: freezed == color4
          ? _value.color4
          : color4 // ignore: cast_nullable_to_non_nullable
              as int?,
      hijab: freezed == hijab
          ? _value.hijab
          : hijab // ignore: cast_nullable_to_non_nullable
              as int?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      likes: freezed == likes
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as int?,
      comments: freezed == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as int?,
      favourit: freezed == favourit
          ? _value.favourit
          : favourit // ignore: cast_nullable_to_non_nullable
              as int?,
      approved: freezed == approved
          ? _value.approved
          : approved // ignore: cast_nullable_to_non_nullable
              as int?,
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
      ptn: freezed == ptn
          ? _value.ptn
          : ptn // ignore: cast_nullable_to_non_nullable
              as int?,
      ptn2: freezed == ptn2
          ? _value.ptn2
          : ptn2 // ignore: cast_nullable_to_non_nullable
              as int?,
      ptn3: freezed == ptn3
          ? _value.ptn3
          : ptn3 // ignore: cast_nullable_to_non_nullable
              as int?,
      ptn4: freezed == ptn4
          ? _value.ptn4
          : ptn4 // ignore: cast_nullable_to_non_nullable
              as int?,
      above_95: freezed == above_95
          ? _value.above_95
          : above_95 // ignore: cast_nullable_to_non_nullable
              as int?,
      season: freezed == season
          ? _value.season
          : season // ignore: cast_nullable_to_non_nullable
              as String?,
      moved: freezed == moved
          ? _value.moved
          : moved // ignore: cast_nullable_to_non_nullable
              as int?,
      jacket: freezed == jacket
          ? _value.jacket
          : jacket // ignore: cast_nullable_to_non_nullable
              as String?,
      approved_by: freezed == approved_by
          ? _value.approved_by
          : approved_by // ignore: cast_nullable_to_non_nullable
              as String?,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ProductsDataCopyWith<$Res>
    implements $ProductsDataCopyWith<$Res> {
  factory _$$_ProductsDataCopyWith(
          _$_ProductsData value, $Res Function(_$_ProductsData) then) =
      __$$_ProductsDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? uid,
      String? url,
      String? name,
      String? email,
      int? type,
      int? color,
      int? type2,
      int? color2,
      int? type3,
      int? color3,
      int? type4,
      int? color4,
      int? hijab,
      String? description,
      DateTime? time,
      int? likes,
      int? comments,
      int? favourit,
      int? approved,
      String? source,
      int? ptn,
      int? ptn2,
      int? ptn3,
      int? ptn4,
      int? above_95,
      String? season,
      int? moved,
      String? jacket,
      String? approved_by,
      DateTime? created_at});
}

/// @nodoc
class __$$_ProductsDataCopyWithImpl<$Res>
    extends _$ProductsDataCopyWithImpl<$Res, _$_ProductsData>
    implements _$$_ProductsDataCopyWith<$Res> {
  __$$_ProductsDataCopyWithImpl(
      _$_ProductsData _value, $Res Function(_$_ProductsData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = freezed,
    Object? url = freezed,
    Object? name = freezed,
    Object? email = freezed,
    Object? type = freezed,
    Object? color = freezed,
    Object? type2 = freezed,
    Object? color2 = freezed,
    Object? type3 = freezed,
    Object? color3 = freezed,
    Object? type4 = freezed,
    Object? color4 = freezed,
    Object? hijab = freezed,
    Object? description = freezed,
    Object? time = freezed,
    Object? likes = freezed,
    Object? comments = freezed,
    Object? favourit = freezed,
    Object? approved = freezed,
    Object? source = freezed,
    Object? ptn = freezed,
    Object? ptn2 = freezed,
    Object? ptn3 = freezed,
    Object? ptn4 = freezed,
    Object? above_95 = freezed,
    Object? season = freezed,
    Object? moved = freezed,
    Object? jacket = freezed,
    Object? approved_by = freezed,
    Object? created_at = freezed,
  }) {
    return _then(_$_ProductsData(
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as int?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as int?,
      type2: freezed == type2
          ? _value.type2
          : type2 // ignore: cast_nullable_to_non_nullable
              as int?,
      color2: freezed == color2
          ? _value.color2
          : color2 // ignore: cast_nullable_to_non_nullable
              as int?,
      type3: freezed == type3
          ? _value.type3
          : type3 // ignore: cast_nullable_to_non_nullable
              as int?,
      color3: freezed == color3
          ? _value.color3
          : color3 // ignore: cast_nullable_to_non_nullable
              as int?,
      type4: freezed == type4
          ? _value.type4
          : type4 // ignore: cast_nullable_to_non_nullable
              as int?,
      color4: freezed == color4
          ? _value.color4
          : color4 // ignore: cast_nullable_to_non_nullable
              as int?,
      hijab: freezed == hijab
          ? _value.hijab
          : hijab // ignore: cast_nullable_to_non_nullable
              as int?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      likes: freezed == likes
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as int?,
      comments: freezed == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as int?,
      favourit: freezed == favourit
          ? _value.favourit
          : favourit // ignore: cast_nullable_to_non_nullable
              as int?,
      approved: freezed == approved
          ? _value.approved
          : approved // ignore: cast_nullable_to_non_nullable
              as int?,
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
      ptn: freezed == ptn
          ? _value.ptn
          : ptn // ignore: cast_nullable_to_non_nullable
              as int?,
      ptn2: freezed == ptn2
          ? _value.ptn2
          : ptn2 // ignore: cast_nullable_to_non_nullable
              as int?,
      ptn3: freezed == ptn3
          ? _value.ptn3
          : ptn3 // ignore: cast_nullable_to_non_nullable
              as int?,
      ptn4: freezed == ptn4
          ? _value.ptn4
          : ptn4 // ignore: cast_nullable_to_non_nullable
              as int?,
      above_95: freezed == above_95
          ? _value.above_95
          : above_95 // ignore: cast_nullable_to_non_nullable
              as int?,
      season: freezed == season
          ? _value.season
          : season // ignore: cast_nullable_to_non_nullable
              as String?,
      moved: freezed == moved
          ? _value.moved
          : moved // ignore: cast_nullable_to_non_nullable
              as int?,
      jacket: freezed == jacket
          ? _value.jacket
          : jacket // ignore: cast_nullable_to_non_nullable
              as String?,
      approved_by: freezed == approved_by
          ? _value.approved_by
          : approved_by // ignore: cast_nullable_to_non_nullable
              as String?,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ProductsData implements _ProductsData {
  const _$_ProductsData(
      {this.uid,
      this.url,
      this.name,
      this.email,
      this.type,
      this.color,
      this.type2,
      this.color2,
      this.type3,
      this.color3,
      this.type4,
      this.color4,
      this.hijab,
      this.description,
      this.time,
      this.likes,
      this.comments,
      this.favourit,
      this.approved,
      this.source,
      this.ptn,
      this.ptn2,
      this.ptn3,
      this.ptn4,
      this.above_95,
      this.season,
      this.moved,
      this.jacket,
      this.approved_by,
      this.created_at});

  factory _$_ProductsData.fromJson(Map<String, dynamic> json) =>
      _$$_ProductsDataFromJson(json);

  @override
  final int? uid;
  @override
  final String? url;
  @override
  final String? name;
  @override
  final String? email;
  @override
  final int? type;
  @override
  final int? color;
  @override
  final int? type2;
  @override
  final int? color2;
  @override
  final int? type3;
  @override
  final int? color3;
  @override
  final int? type4;
  @override
  final int? color4;
  @override
  final int? hijab;
  @override
  final String? description;
  @override
  final DateTime? time;
  @override
  final int? likes;
  @override
  final int? comments;
  @override
  final int? favourit;
  @override
  final int? approved;
  @override
  final String? source;
  @override
  final int? ptn;
  @override
  final int? ptn2;
  @override
  final int? ptn3;
  @override
  final int? ptn4;
  @override
  final int? above_95;
  @override
  final String? season;
  @override
  final int? moved;
  @override
  final String? jacket;
  @override
  final String? approved_by;
  @override
  final DateTime? created_at;

  @override
  String toString() {
    return 'ProductsData(uid: $uid, url: $url, name: $name, email: $email, type: $type, color: $color, type2: $type2, color2: $color2, type3: $type3, color3: $color3, type4: $type4, color4: $color4, hijab: $hijab, description: $description, time: $time, likes: $likes, comments: $comments, favourit: $favourit, approved: $approved, source: $source, ptn: $ptn, ptn2: $ptn2, ptn3: $ptn3, ptn4: $ptn4, above_95: $above_95, season: $season, moved: $moved, jacket: $jacket, approved_by: $approved_by, created_at: $created_at)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProductsData &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.type2, type2) || other.type2 == type2) &&
            (identical(other.color2, color2) || other.color2 == color2) &&
            (identical(other.type3, type3) || other.type3 == type3) &&
            (identical(other.color3, color3) || other.color3 == color3) &&
            (identical(other.type4, type4) || other.type4 == type4) &&
            (identical(other.color4, color4) || other.color4 == color4) &&
            (identical(other.hijab, hijab) || other.hijab == hijab) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.likes, likes) || other.likes == likes) &&
            (identical(other.comments, comments) ||
                other.comments == comments) &&
            (identical(other.favourit, favourit) ||
                other.favourit == favourit) &&
            (identical(other.approved, approved) ||
                other.approved == approved) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.ptn, ptn) || other.ptn == ptn) &&
            (identical(other.ptn2, ptn2) || other.ptn2 == ptn2) &&
            (identical(other.ptn3, ptn3) || other.ptn3 == ptn3) &&
            (identical(other.ptn4, ptn4) || other.ptn4 == ptn4) &&
            (identical(other.above_95, above_95) ||
                other.above_95 == above_95) &&
            (identical(other.season, season) || other.season == season) &&
            (identical(other.moved, moved) || other.moved == moved) &&
            (identical(other.jacket, jacket) || other.jacket == jacket) &&
            (identical(other.approved_by, approved_by) ||
                other.approved_by == approved_by) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        uid,
        url,
        name,
        email,
        type,
        color,
        type2,
        color2,
        type3,
        color3,
        type4,
        color4,
        hijab,
        description,
        time,
        likes,
        comments,
        favourit,
        approved,
        source,
        ptn,
        ptn2,
        ptn3,
        ptn4,
        above_95,
        season,
        moved,
        jacket,
        approved_by,
        created_at
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProductsDataCopyWith<_$_ProductsData> get copyWith =>
      __$$_ProductsDataCopyWithImpl<_$_ProductsData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProductsDataToJson(
      this,
    );
  }
}

abstract class _ProductsData implements ProductsData {
  const factory _ProductsData(
      {final int? uid,
      final String? url,
      final String? name,
      final String? email,
      final int? type,
      final int? color,
      final int? type2,
      final int? color2,
      final int? type3,
      final int? color3,
      final int? type4,
      final int? color4,
      final int? hijab,
      final String? description,
      final DateTime? time,
      final int? likes,
      final int? comments,
      final int? favourit,
      final int? approved,
      final String? source,
      final int? ptn,
      final int? ptn2,
      final int? ptn3,
      final int? ptn4,
      final int? above_95,
      final String? season,
      final int? moved,
      final String? jacket,
      final String? approved_by,
      final DateTime? created_at}) = _$_ProductsData;

  factory _ProductsData.fromJson(Map<String, dynamic> json) =
      _$_ProductsData.fromJson;

  @override
  int? get uid;
  @override
  String? get url;
  @override
  String? get name;
  @override
  String? get email;
  @override
  int? get type;
  @override
  int? get color;
  @override
  int? get type2;
  @override
  int? get color2;
  @override
  int? get type3;
  @override
  int? get color3;
  @override
  int? get type4;
  @override
  int? get color4;
  @override
  int? get hijab;
  @override
  String? get description;
  @override
  DateTime? get time;
  @override
  int? get likes;
  @override
  int? get comments;
  @override
  int? get favourit;
  @override
  int? get approved;
  @override
  String? get source;
  @override
  int? get ptn;
  @override
  int? get ptn2;
  @override
  int? get ptn3;
  @override
  int? get ptn4;
  @override
  int? get above_95;
  @override
  String? get season;
  @override
  int? get moved;
  @override
  String? get jacket;
  @override
  String? get approved_by;
  @override
  DateTime? get created_at;
  @override
  @JsonKey(ignore: true)
  _$$_ProductsDataCopyWith<_$_ProductsData> get copyWith =>
      throw _privateConstructorUsedError;
}

Links _$LinksFromJson(Map<String, dynamic> json) {
  return _Links.fromJson(json);
}

/// @nodoc
mixin _$Links {
  String? get url => throw _privateConstructorUsedError;
  String? get label => throw _privateConstructorUsedError;
  bool? get active => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LinksCopyWith<Links> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LinksCopyWith<$Res> {
  factory $LinksCopyWith(Links value, $Res Function(Links) then) =
      _$LinksCopyWithImpl<$Res, Links>;
  @useResult
  $Res call({String? url, String? label, bool? active});
}

/// @nodoc
class _$LinksCopyWithImpl<$Res, $Val extends Links>
    implements $LinksCopyWith<$Res> {
  _$LinksCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
    Object? label = freezed,
    Object? active = freezed,
  }) {
    return _then(_value.copyWith(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      active: freezed == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LinksCopyWith<$Res> implements $LinksCopyWith<$Res> {
  factory _$$_LinksCopyWith(_$_Links value, $Res Function(_$_Links) then) =
      __$$_LinksCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? url, String? label, bool? active});
}

/// @nodoc
class __$$_LinksCopyWithImpl<$Res> extends _$LinksCopyWithImpl<$Res, _$_Links>
    implements _$$_LinksCopyWith<$Res> {
  __$$_LinksCopyWithImpl(_$_Links _value, $Res Function(_$_Links) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
    Object? label = freezed,
    Object? active = freezed,
  }) {
    return _then(_$_Links(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      active: freezed == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Links implements _Links {
  const _$_Links({this.url, this.label, this.active});

  factory _$_Links.fromJson(Map<String, dynamic> json) =>
      _$$_LinksFromJson(json);

  @override
  final String? url;
  @override
  final String? label;
  @override
  final bool? active;

  @override
  String toString() {
    return 'Links(url: $url, label: $label, active: $active)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Links &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.active, active) || other.active == active));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, url, label, active);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LinksCopyWith<_$_Links> get copyWith =>
      __$$_LinksCopyWithImpl<_$_Links>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LinksToJson(
      this,
    );
  }
}

abstract class _Links implements Links {
  const factory _Links(
      {final String? url, final String? label, final bool? active}) = _$_Links;

  factory _Links.fromJson(Map<String, dynamic> json) = _$_Links.fromJson;

  @override
  String? get url;
  @override
  String? get label;
  @override
  bool? get active;
  @override
  @JsonKey(ignore: true)
  _$$_LinksCopyWith<_$_Links> get copyWith =>
      throw _privateConstructorUsedError;
}
