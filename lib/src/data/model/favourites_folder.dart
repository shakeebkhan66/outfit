import 'package:freezed_annotation/freezed_annotation.dart'; 

part 'favourites_folder.freezed.dart';
part 'favourites_folder.g.dart';

@freezed
class FavouritesFolder with _$FavouritesFolder {
	const factory FavouritesFolder({
String? message,
List<Data>? data,
	}) = _FavouritesFolder;

	factory FavouritesFolder.fromJson(Map<String, dynamic> json) => _$FavouritesFolderFromJson(json);
}

@freezed
class Data with _$Data {
	const factory Data({
int? id,
String? user,
String? list_name,
String? description,
String? type,
DateTime? created_at,
FirstImage? first_image,
	}) = _Data;

	factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@freezed
class FirstImage with _$FirstImage {
	const factory FirstImage({
    Photo? photo,
	}) = _FirstImage;

	factory FirstImage.fromJson(Map<String, dynamic> json) => _$FirstImageFromJson(json);
}

@freezed
class Photo with _$Photo {
	const factory Photo({
    String? url,
	}) = _Photo;

	factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);
}