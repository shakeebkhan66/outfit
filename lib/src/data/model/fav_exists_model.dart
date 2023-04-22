import 'package:freezed_annotation/freezed_annotation.dart'; 

part 'fav_exists_model.freezed.dart';
part 'fav_exists_model.g.dart';

@freezed
class FavExistsModel with _$FavExistsModel {
	const factory FavExistsModel({
String? message,
List<FavExistsData>? data,
	}) = _FavExistsModel;

	factory FavExistsModel.fromJson(Map<String, dynamic> json) => _$FavExistsModelFromJson(json);
}

@freezed
class FavExistsData with _$FavExistsData {
	const factory FavExistsData({
int? id,
String? user,
int? list,
int? img,
String? created_at,
	}) = _FavExistsData;

	factory FavExistsData.fromJson(Map<String, dynamic> json) => _$FavExistsDataFromJson(json);
}