import 'package:freezed_annotation/freezed_annotation.dart'; 

part 'products_model.freezed.dart';
part 'products_model.g.dart';

@freezed
class ProductsModel with _$ProductsModel {
	const factory ProductsModel({
String? message,
Data? data,
	}) = _ProductsModel;

	factory ProductsModel.fromJson(Map<String, dynamic> json) => _$ProductsModelFromJson(json);
}

@freezed
class Data with _$Data {
	const factory Data({
int? current_page,
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
int? total,
	}) = _Data;

	factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@freezed
class ProductsData with _$ProductsData {
	const factory ProductsData({
int? uid,
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
DateTime? created_at,
	}) = _ProductsData;

	factory ProductsData.fromJson(Map<String, dynamic> json) => _$ProductsDataFromJson(json);
}

@freezed
class Links with _$Links {
	const factory Links({
String? url,
String? label,
bool? active,
	}) = _Links;

	factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);
}