import 'package:freezed_annotation/freezed_annotation.dart';
part 'filter_model.g.dart';
part 'filter_model.freezed.dart';

@freezed
class FilterModel with _$FilterModel {
  const factory FilterModel({
    // ignore: invalid_annotation_target
    @JsonKey(includeIfNull: false) dynamic style,
    // ignore: invalid_annotation_target
    @JsonKey(includeIfNull: false) dynamic hijab,
    // ignore: invalid_annotation_target
    @JsonKey(includeIfNull: false) dynamic season,
    // ignore: invalid_annotation_target
    @JsonKey(includeIfNull: false) dynamic page,
  }) = _FilterModel;
  factory FilterModel.fromJson(Map<String, dynamic> json) => _$FilterModelFromJson(json);
}
