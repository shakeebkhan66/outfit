import 'package:freezed_annotation/freezed_annotation.dart'; 

part 'colors_model.freezed.dart';
part 'colors_model.g.dart';

@freezed
class ColorsModel with _$ColorsModel {
	const factory ColorsModel({
String? message,
List<Data>? data,
	}) = _ColorsModel;

	factory ColorsModel.fromJson(Map<String, dynamic> json) => _$ColorsModelFromJson(json);
}

@freezed
class Data with _$Data {
	const factory Data({
int? cid,
int? sort_order,
String? name,
String? hex,
String? name_en,
String? name_fr,
String? name_ger,
String? name_es,
String? pattern,
int? patterned,
int? jacket_filter,
	}) = _Data;

	factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}