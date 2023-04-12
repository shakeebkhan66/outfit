
import 'package:outfit/src/data/model/colors_model.dart';
import 'package:outfit/src/data/model/types_model.dart';
import 'package:outfit/src/data/network/base_api_service.dart';
import 'package:outfit/src/data/network/network_api_service.dart';
import 'package:outfit/src/utils/app_urls.dart';

class ColorsRepository {

  final BaseApiServices _apiServices = NetworkApiService() ;

  Future<ColorsModel> fetchAllColors() async {

    try{

      dynamic response = await _apiServices.getGetApiResponse(AppUrl.listofColors);
      return response = ColorsModel.fromJson(response);

    }catch(e){
      rethrow ;
    }
  }

   Future<TypesModel> fetchAllStyles() async {

    try{

      dynamic response = await _apiServices.getGetApiResponse(AppUrl.listofTypes);
      return response = TypesModel.fromJson(response);

    }catch(e){
      rethrow ;
    }
  }

}