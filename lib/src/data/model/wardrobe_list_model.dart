import 'package:freezed_annotation/freezed_annotation.dart'; 

part 'wardrobe_list_model.freezed.dart';
part 'wardrobe_list_model.g.dart';

@freezed
class WardrobeListModel with _$WardrobeListModel {
	const factory WardrobeListModel({
String? message,
List<Data>? data,
	}) = _WardrobeListModel;

	factory WardrobeListModel.fromJson(Map<String, dynamic> json) => _$WardrobeListModelFromJson(json);
}

@freezed
class Data with _$Data {
	const factory Data({
int? id,
String? user_id,
String? type,
List<String>? colors,
DateTime? last_updated,
DateTime? created_at,
	}) = _Data;

	factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}