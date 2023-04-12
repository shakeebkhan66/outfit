import 'package:freezed_annotation/freezed_annotation.dart'; 

part 'types_model.freezed.dart';
part 'types_model.g.dart';

@freezed
class TypesModel with _$TypesModel {
	const factory TypesModel({
String? message,
List<Data>? data,
	}) = _TypesModel;

	factory TypesModel.fromJson(Map<String, dynamic> json) => _$TypesModelFromJson(json);
}

@freezed
class Data with _$Data {
	const factory Data({
int? tid,
int? sort_order,
String? name,
String? en_name,
String? fr_name,
String? ger_name,
String? es_name,
	}) = _Data;

	factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}