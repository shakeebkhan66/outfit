import 'package:outfit/src/data/model/filter_model.dart';
import 'package:outfit/src/data/model/products_model.dart';
import 'package:outfit/src/data/network/base_api_service.dart';
import 'package:outfit/src/data/network/network_api_service.dart';
import 'package:outfit/src/utils/app_urls.dart';

class ProductsRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<ProductsModel> fetchAllPhotos(int page) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse("${AppUrl.allphotosApi}?page=$page");
      return response = ProductsModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<ProductsModel> filterAllPhotos(dynamic style, dynamic hijab, dynamic season, int page) async {
    FilterModel queryParams = FilterModel(
      style: style,
      hijab: hijab,
      season: season,
      page: page,
    );
    try {
      dynamic response = await _apiServices.getGetApiResponse(AppUrl.filterPhotoApi, queryParameters: queryParams.toJson());
      return response = ProductsModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> likePhoto({required String email, String? id}) async {
    Map<String, String> data = {
      "email": email,
    };
    try {
      dynamic response = await _apiServices.getPutApiResponse(
        "${AppUrl.allphotosApi}/$id/like",
        data: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> unLikePhoto({required String email, String? id}) async {
    Map<String, String> data = {
      "email": email,
    };
    try {
      dynamic response = await _apiServices.getPutApiResponse(
        "${AppUrl.allphotosApi}/$id/unlike",
        data: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
