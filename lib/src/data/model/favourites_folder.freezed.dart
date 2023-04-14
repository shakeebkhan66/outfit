// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favourites_folder.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FavouritesFolder _$FavouritesFolderFromJson(Map<String, dynamic> json) {
  return _FavouritesFolder.fromJson(json);
}

/// @nodoc
mixin _$FavouritesFolder {
  String? get message => throw _privateConstructorUsedError;
  List<Data>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FavouritesFolderCopyWith<FavouritesFolder> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavouritesFolderCopyWith<$Res> {
  factory $FavouritesFolderCopyWith(
          FavouritesFolder value, $Res Function(FavouritesFolder) then) =
      _$FavouritesFolderCopyWithImpl<$Res, FavouritesFolder>;
  @useResult
  $Res call({String? message, List<Data>? data});
}

/// @nodoc
class _$FavouritesFolderCopyWithImpl<$Res, $Val extends FavouritesFolder>
    implements $FavouritesFolderCopyWith<$Res> {
  _$FavouritesFolderCopyWithImpl(this._value, this._then);

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
abstract class _$$_FavouritesFolderCopyWith<$Res>
    implements $FavouritesFolderCopyWith<$Res> {
  factory _$$_FavouritesFolderCopyWith(
          _$_FavouritesFolder value, $Res Function(_$_FavouritesFolder) then) =
      __$$_FavouritesFolderCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message, List<Data>? data});
}

/// @nodoc
class __$$_FavouritesFolderCopyWithImpl<$Res>
    extends _$FavouritesFolderCopyWithImpl<$Res, _$_FavouritesFolder>
    implements _$$_FavouritesFolderCopyWith<$Res> {
  __$$_FavouritesFolderCopyWithImpl(
      _$_FavouritesFolder _value, $Res Function(_$_FavouritesFolder) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_$_FavouritesFolder(
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
class _$_FavouritesFolder implements _FavouritesFolder {
  const _$_FavouritesFolder({this.message, final List<Data>? data})
      : _data = data;

  factory _$_FavouritesFolder.fromJson(Map<String, dynamic> json) =>
      _$$_FavouritesFolderFromJson(json);

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
    return 'FavouritesFolder(message: $message, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FavouritesFolder &&
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
  _$$_FavouritesFolderCopyWith<_$_FavouritesFolder> get copyWith =>
      __$$_FavouritesFolderCopyWithImpl<_$_FavouritesFolder>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FavouritesFolderToJson(
      this,
    );
  }
}

abstract class _FavouritesFolder implements FavouritesFolder {
  const factory _FavouritesFolder(
      {final String? message, final List<Data>? data}) = _$_FavouritesFolder;

  factory _FavouritesFolder.fromJson(Map<String, dynamic> json) =
      _$_FavouritesFolder.fromJson;

  @override
  String? get message;
  @override
  List<Data>? get data;
  @override
  @JsonKey(ignore: true)
  _$$_FavouritesFolderCopyWith<_$_FavouritesFolder> get copyWith =>
      throw _privateConstructorUsedError;
}

Data _$DataFromJson(Map<String, dynamic> json) {
  return _Data.fromJson(json);
}

/// @nodoc
mixin _$Data {
  int? get id => throw _privateConstructorUsedError;
  String? get user => throw _privateConstructorUsedError;
  String? get list_name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  DateTime? get created_at => throw _privateConstructorUsedError;
  FirstImage? get first_image => throw _privateConstructorUsedError;

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
      String? user,
      String? list_name,
      String? description,
      String? type,
      DateTime? created_at,
      FirstImage? first_image});

  $FirstImageCopyWith<$Res>? get first_image;
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
    Object? user = freezed,
    Object? list_name = freezed,
    Object? description = freezed,
    Object? type = freezed,
    Object? created_at = freezed,
    Object? first_image = freezed,
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
      list_name: freezed == list_name
          ? _value.list_name
          : list_name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      first_image: freezed == first_image
          ? _value.first_image
          : first_image // ignore: cast_nullable_to_non_nullable
              as FirstImage?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FirstImageCopyWith<$Res>? get first_image {
    if (_value.first_image == null) {
      return null;
    }

    return $FirstImageCopyWith<$Res>(_value.first_image!, (value) {
      return _then(_value.copyWith(first_image: value) as $Val);
    });
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
      String? user,
      String? list_name,
      String? description,
      String? type,
      DateTime? created_at,
      FirstImage? first_image});

  @override
  $FirstImageCopyWith<$Res>? get first_image;
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
    Object? user = freezed,
    Object? list_name = freezed,
    Object? description = freezed,
    Object? type = freezed,
    Object? created_at = freezed,
    Object? first_image = freezed,
  }) {
    return _then(_$_Data(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as String?,
      list_name: freezed == list_name
          ? _value.list_name
          : list_name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      first_image: freezed == first_image
          ? _value.first_image
          : first_image // ignore: cast_nullable_to_non_nullable
              as FirstImage?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Data implements _Data {
  const _$_Data(
      {this.id,
      this.user,
      this.list_name,
      this.description,
      this.type,
      this.created_at,
      this.first_image});

  factory _$_Data.fromJson(Map<String, dynamic> json) => _$$_DataFromJson(json);

  @override
  final int? id;
  @override
  final String? user;
  @override
  final String? list_name;
  @override
  final String? description;
  @override
  final String? type;
  @override
  final DateTime? created_at;
  @override
  final FirstImage? first_image;

  @override
  String toString() {
    return 'Data(id: $id, user: $user, list_name: $list_name, description: $description, type: $type, created_at: $created_at, first_image: $first_image)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Data &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.list_name, list_name) ||
                other.list_name == list_name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at) &&
            (identical(other.first_image, first_image) ||
                other.first_image == first_image));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, user, list_name, description,
      type, created_at, first_image);

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
      final String? user,
      final String? list_name,
      final String? description,
      final String? type,
      final DateTime? created_at,
      final FirstImage? first_image}) = _$_Data;

  factory _Data.fromJson(Map<String, dynamic> json) = _$_Data.fromJson;

  @override
  int? get id;
  @override
  String? get user;
  @override
  String? get list_name;
  @override
  String? get description;
  @override
  String? get type;
  @override
  DateTime? get created_at;
  @override
  FirstImage? get first_image;
  @override
  @JsonKey(ignore: true)
  _$$_DataCopyWith<_$_Data> get copyWith => throw _privateConstructorUsedError;
}

FirstImage _$FirstImageFromJson(Map<String, dynamic> json) {
  return _FirstImage.fromJson(json);
}

/// @nodoc
mixin _$FirstImage {
  Photo? get photo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FirstImageCopyWith<FirstImage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FirstImageCopyWith<$Res> {
  factory $FirstImageCopyWith(
          FirstImage value, $Res Function(FirstImage) then) =
      _$FirstImageCopyWithImpl<$Res, FirstImage>;
  @useResult
  $Res call({Photo? photo});

  $PhotoCopyWith<$Res>? get photo;
}

/// @nodoc
class _$FirstImageCopyWithImpl<$Res, $Val extends FirstImage>
    implements $FirstImageCopyWith<$Res> {
  _$FirstImageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? photo = freezed,
  }) {
    return _then(_value.copyWith(
      photo: freezed == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as Photo?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PhotoCopyWith<$Res>? get photo {
    if (_value.photo == null) {
      return null;
    }

    return $PhotoCopyWith<$Res>(_value.photo!, (value) {
      return _then(_value.copyWith(photo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_FirstImageCopyWith<$Res>
    implements $FirstImageCopyWith<$Res> {
  factory _$$_FirstImageCopyWith(
          _$_FirstImage value, $Res Function(_$_FirstImage) then) =
      __$$_FirstImageCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Photo? photo});

  @override
  $PhotoCopyWith<$Res>? get photo;
}

/// @nodoc
class __$$_FirstImageCopyWithImpl<$Res>
    extends _$FirstImageCopyWithImpl<$Res, _$_FirstImage>
    implements _$$_FirstImageCopyWith<$Res> {
  __$$_FirstImageCopyWithImpl(
      _$_FirstImage _value, $Res Function(_$_FirstImage) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? photo = freezed,
  }) {
    return _then(_$_FirstImage(
      photo: freezed == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as Photo?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FirstImage implements _FirstImage {
  const _$_FirstImage({this.photo});

  factory _$_FirstImage.fromJson(Map<String, dynamic> json) =>
      _$$_FirstImageFromJson(json);

  @override
  final Photo? photo;

  @override
  String toString() {
    return 'FirstImage(photo: $photo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FirstImage &&
            (identical(other.photo, photo) || other.photo == photo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, photo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FirstImageCopyWith<_$_FirstImage> get copyWith =>
      __$$_FirstImageCopyWithImpl<_$_FirstImage>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FirstImageToJson(
      this,
    );
  }
}

abstract class _FirstImage implements FirstImage {
  const factory _FirstImage({final Photo? photo}) = _$_FirstImage;

  factory _FirstImage.fromJson(Map<String, dynamic> json) =
      _$_FirstImage.fromJson;

  @override
  Photo? get photo;
  @override
  @JsonKey(ignore: true)
  _$$_FirstImageCopyWith<_$_FirstImage> get copyWith =>
      throw _privateConstructorUsedError;
}

Photo _$PhotoFromJson(Map<String, dynamic> json) {
  return _Photo.fromJson(json);
}

/// @nodoc
mixin _$Photo {
  String? get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PhotoCopyWith<Photo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhotoCopyWith<$Res> {
  factory $PhotoCopyWith(Photo value, $Res Function(Photo) then) =
      _$PhotoCopyWithImpl<$Res, Photo>;
  @useResult
  $Res call({String? url});
}

/// @nodoc
class _$PhotoCopyWithImpl<$Res, $Val extends Photo>
    implements $PhotoCopyWith<$Res> {
  _$PhotoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
  }) {
    return _then(_value.copyWith(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PhotoCopyWith<$Res> implements $PhotoCopyWith<$Res> {
  factory _$$_PhotoCopyWith(_$_Photo value, $Res Function(_$_Photo) then) =
      __$$_PhotoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? url});
}

/// @nodoc
class __$$_PhotoCopyWithImpl<$Res> extends _$PhotoCopyWithImpl<$Res, _$_Photo>
    implements _$$_PhotoCopyWith<$Res> {
  __$$_PhotoCopyWithImpl(_$_Photo _value, $Res Function(_$_Photo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
  }) {
    return _then(_$_Photo(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Photo implements _Photo {
  const _$_Photo({this.url});

  factory _$_Photo.fromJson(Map<String, dynamic> json) =>
      _$$_PhotoFromJson(json);

  @override
  final String? url;

  @override
  String toString() {
    return 'Photo(url: $url)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Photo &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PhotoCopyWith<_$_Photo> get copyWith =>
      __$$_PhotoCopyWithImpl<_$_Photo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PhotoToJson(
      this,
    );
  }
}

abstract class _Photo implements Photo {
  const factory _Photo({final String? url}) = _$_Photo;

  factory _Photo.fromJson(Map<String, dynamic> json) = _$_Photo.fromJson;

  @override
  String? get url;
  @override
  @JsonKey(ignore: true)
  _$$_PhotoCopyWith<_$_Photo> get copyWith =>
      throw _privateConstructorUsedError;
}

UpdateFolderData _$UpdateFolderDataFromJson(Map<String, dynamic> json) {
  return _UpdateFolderData.fromJson(json);
}

/// @nodoc
mixin _$UpdateFolderData {
  String? get user => throw _privateConstructorUsedError;
  String? get list_name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UpdateFolderDataCopyWith<UpdateFolderData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateFolderDataCopyWith<$Res> {
  factory $UpdateFolderDataCopyWith(
          UpdateFolderData value, $Res Function(UpdateFolderData) then) =
      _$UpdateFolderDataCopyWithImpl<$Res, UpdateFolderData>;
  @useResult
  $Res call(
      {String? user, String? list_name, String? description, String? type});
}

/// @nodoc
class _$UpdateFolderDataCopyWithImpl<$Res, $Val extends UpdateFolderData>
    implements $UpdateFolderDataCopyWith<$Res> {
  _$UpdateFolderDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
    Object? list_name = freezed,
    Object? description = freezed,
    Object? type = freezed,
  }) {
    return _then(_value.copyWith(
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as String?,
      list_name: freezed == list_name
          ? _value.list_name
          : list_name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UpdateFolderDataCopyWith<$Res>
    implements $UpdateFolderDataCopyWith<$Res> {
  factory _$$_UpdateFolderDataCopyWith(
          _$_UpdateFolderData value, $Res Function(_$_UpdateFolderData) then) =
      __$$_UpdateFolderDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? user, String? list_name, String? description, String? type});
}

/// @nodoc
class __$$_UpdateFolderDataCopyWithImpl<$Res>
    extends _$UpdateFolderDataCopyWithImpl<$Res, _$_UpdateFolderData>
    implements _$$_UpdateFolderDataCopyWith<$Res> {
  __$$_UpdateFolderDataCopyWithImpl(
      _$_UpdateFolderData _value, $Res Function(_$_UpdateFolderData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
    Object? list_name = freezed,
    Object? description = freezed,
    Object? type = freezed,
  }) {
    return _then(_$_UpdateFolderData(
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as String?,
      list_name: freezed == list_name
          ? _value.list_name
          : list_name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UpdateFolderData implements _UpdateFolderData {
  const _$_UpdateFolderData(
      {this.user, this.list_name, this.description, this.type});

  factory _$_UpdateFolderData.fromJson(Map<String, dynamic> json) =>
      _$$_UpdateFolderDataFromJson(json);

  @override
  final String? user;
  @override
  final String? list_name;
  @override
  final String? description;
  @override
  final String? type;

  @override
  String toString() {
    return 'UpdateFolderData(user: $user, list_name: $list_name, description: $description, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UpdateFolderData &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.list_name, list_name) ||
                other.list_name == list_name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, user, list_name, description, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UpdateFolderDataCopyWith<_$_UpdateFolderData> get copyWith =>
      __$$_UpdateFolderDataCopyWithImpl<_$_UpdateFolderData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UpdateFolderDataToJson(
      this,
    );
  }
}

abstract class _UpdateFolderData implements UpdateFolderData {
  const factory _UpdateFolderData(
      {final String? user,
      final String? list_name,
      final String? description,
      final String? type}) = _$_UpdateFolderData;

  factory _UpdateFolderData.fromJson(Map<String, dynamic> json) =
      _$_UpdateFolderData.fromJson;

  @override
  String? get user;
  @override
  String? get list_name;
  @override
  String? get description;
  @override
  String? get type;
  @override
  @JsonKey(ignore: true)
  _$$_UpdateFolderDataCopyWith<_$_UpdateFolderData> get copyWith =>
      throw _privateConstructorUsedError;
}
