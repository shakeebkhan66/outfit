
import 'package:outfit/src/data/model/favourites_folder.dart';
import 'package:outfit/src/data/model/products_model.dart';
import 'package:outfit/src/data/network/base_api_service.dart';
import 'package:outfit/src/data/network/network_api_service.dart';
import 'package:outfit/src/utils/app_urls.dart';

class FavFolderRepository {

  final BaseApiServices _apiServices = NetworkApiService() ;

  Future<FavouritesFolder> fetchAllFavFolders(String userId)async{

    try{

      dynamic response = await _apiServices.getGetApiResponse("${AppUrl.favouritesFolders}/$userId");
      return response = FavouritesFolder.fromJson(response);

    }catch(e){
      rethrow ;
    }
  }

  Future<ProductsModel> fetchAllFavImages(String userId)async{

    try{

      dynamic response = await _apiServices.getGetApiResponse("${AppUrl.favouritesFolders}/$userId/images");
      return response = ProductsModel.fromJson(response);

    }catch(e){
      rethrow ;
    }
  }

}