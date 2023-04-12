// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'filter_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FilterModel _$FilterModelFromJson(Map<String, dynamic> json) {
  return _FilterModel.fromJson(json);
}

/// @nodoc
mixin _$FilterModel {
  @JsonKey(includeIfNull: false)
  dynamic get style => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  dynamic get hijab => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  dynamic get season => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  dynamic get page => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FilterModelCopyWith<FilterModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilterModelCopyWith<$Res> {
  factory $FilterModelCopyWith(
          FilterModel value, $Res Function(FilterModel) then) =
      _$FilterModelCopyWithImpl<$Res, FilterModel>;
  @useResult
  $Res call(
      {@JsonKey(includeIfNull: false) dynamic style,
      @JsonKey(includeIfNull: false) dynamic hijab,
      @JsonKey(includeIfNull: false) dynamic season,
      @JsonKey(includeIfNull: false) dynamic page});
}

/// @nodoc
class _$FilterModelCopyWithImpl<$Res, $Val extends FilterModel>
    implements $FilterModelCopyWith<$Res> {
  _$FilterModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? style = freezed,
    Object? hijab = freezed,
    Object? season = freezed,
    Object? page = freezed,
  }) {
    return _then(_value.copyWith(
      style: freezed == style
          ? _value.style
          : style // ignore: cast_nullable_to_non_nullable
              as dynamic,
      hijab: freezed == hijab
          ? _value.hijab
          : hijab // ignore: cast_nullable_to_non_nullable
              as dynamic,
      season: freezed == season
          ? _value.season
          : season // ignore: cast_nullable_to_non_nullable
              as dynamic,
      page: freezed == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FilterModelCopyWith<$Res>
    implements $FilterModelCopyWith<$Res> {
  factory _$$_FilterModelCopyWith(
          _$_FilterModel value, $Res Function(_$_FilterModel) then) =
      __$$_FilterModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeIfNull: false) dynamic style,
      @JsonKey(includeIfNull: false) dynamic hijab,
      @JsonKey(includeIfNull: false) dynamic season,
      @JsonKey(includeIfNull: false) dynamic page});
}

/// @nodoc
class __$$_FilterModelCopyWithImpl<$Res>
    extends _$FilterModelCopyWithImpl<$Res, _$_FilterModel>
    implements _$$_FilterModelCopyWith<$Res> {
  __$$_FilterModelCopyWithImpl(
      _$_FilterModel _value, $Res Function(_$_FilterModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? style = freezed,
    Object? hijab = freezed,
    Object? season = freezed,
    Object? page = freezed,
  }) {
    return _then(_$_FilterModel(
      style: freezed == style
          ? _value.style
          : style // ignore: cast_nullable_to_non_nullable
              as dynamic,
      hijab: freezed == hijab
          ? _value.hijab
          : hijab // ignore: cast_nullable_to_non_nullable
              as dynamic,
      season: freezed == season
          ? _value.season
          : season // ignore: cast_nullable_to_non_nullable
              as dynamic,
      page: freezed == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FilterModel implements _FilterModel {
  const _$_FilterModel(
      {@JsonKey(includeIfNull: false) this.style,
      @JsonKey(includeIfNull: false) this.hijab,
      @JsonKey(includeIfNull: false) this.season,
      @JsonKey(includeIfNull: false) this.page});

  factory _$_FilterModel.fromJson(Map<String, dynamic> json) =>
      _$$_FilterModelFromJson(json);

  @override
  @JsonKey(includeIfNull: false)
  final dynamic style;
  @override
  @JsonKey(includeIfNull: false)
  final dynamic hijab;
  @override
  @JsonKey(includeIfNull: false)
  final dynamic season;
  @override
  @JsonKey(includeIfNull: false)
  final dynamic page;

  @override
  String toString() {
    return 'FilterModel(style: $style, hijab: $hijab, season: $season, page: $page)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FilterModel &&
            const DeepCollectionEquality().equals(other.style, style) &&
            const DeepCollectionEquality().equals(other.hijab, hijab) &&
            const DeepCollectionEquality().equals(other.season, season) &&
            const DeepCollectionEquality().equals(other.page, page));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(style),
      const DeepCollectionEquality().hash(hijab),
      const DeepCollectionEquality().hash(season),
      const DeepCollectionEquality().hash(page));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FilterModelCopyWith<_$_FilterModel> get copyWith =>
      __$$_FilterModelCopyWithImpl<_$_FilterModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FilterModelToJson(
      this,
    );
  }
}

abstract class _FilterModel implements FilterModel {
  const factory _FilterModel(
      {@JsonKey(includeIfNull: false) final dynamic style,
      @JsonKey(includeIfNull: false) final dynamic hijab,
      @JsonKey(includeIfNull: false) final dynamic season,
      @JsonKey(includeIfNull: false) final dynamic page}) = _$_FilterModel;

  factory _FilterModel.fromJson(Map<String, dynamic> json) =
      _$_FilterModel.fromJson;

  @override
  @JsonKey(includeIfNull: false)
  dynamic get style;
  @override
  @JsonKey(includeIfNull: false)
  dynamic get hijab;
  @override
  @JsonKey(includeIfNull: false)
  dynamic get season;
  @override
  @JsonKey(includeIfNull: false)
  dynamic get page;
  @override
  @JsonKey(ignore: true)
  _$$_FilterModelCopyWith<_$_FilterModel> get copyWith =>
      throw _privateConstructorUsedError;
}
