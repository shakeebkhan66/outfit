import 'package:outfit/src/data/model/colors_model.dart';
import 'package:outfit/src/data/model/wardrobe_list_model.dart';
import 'package:outfit/src/data/network/base_api_service.dart';
import 'package:outfit/src/data/network/network_api_service.dart';
import 'package:outfit/src/utils/app_urls.dart';

class WardrobeRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<ColorsModel> fetchAllColors() async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(AppUrl.listofColors);
      return response = ColorsModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<WardrobeListModel> fetchAllWardrobeList({required String userId}) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse("${AppUrl.wardrobeList}/$userId");
      return response = WardrobeListModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> addWardrobe(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.wardrobeList, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> updateWardrobe(dynamic data, String wardrobeId) async {
    try {
      dynamic response = await _apiServices.getPutApiResponse("${AppUrl.wardrobeList}/$wardrobeId", data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deleteWardrobe(int wardrobeId) async {
    try {
      dynamic response = await _apiServices.getDeleteApiResponse("${AppUrl.wardrobeList}/$wardrobeId");
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
