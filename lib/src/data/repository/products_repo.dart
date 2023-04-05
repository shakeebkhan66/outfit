import 'package:outfit/src/data/model/products_model.dart';
import 'package:outfit/src/data/network/base_api_service.dart';
import 'package:outfit/src/data/network/network_api_service.dart';
import 'package:outfit/src/utils/app_urls.dart';

class ProductsRepository {

  final BaseApiServices _apiServices = NetworkApiService() ;

  Future<ProductsModel> fetchAllPhotos(int page)async{

    try{

      dynamic response = await _apiServices.getGetApiResponse("${AppUrl.allphotosApi}?page=$page");
      return response = ProductsModel.fromJson(response);

    }catch(e){
      rethrow ;
    }
  }

}