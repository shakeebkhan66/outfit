



import 'package:outfit/src/data/model/fav_exists_model.dart';
import 'package:outfit/src/data/model/favourites_folder.dart';
import 'package:outfit/src/data/model/products_model.dart';
import 'package:outfit/src/data/model/products_model.dart' as productModel;
import 'package:outfit/src/data/network/base_api_service.dart';
import 'package:outfit/src/data/network/network_api_service.dart';
import 'package:outfit/src/utils/app_urls.dart';

class FavFolderRepository {

  final BaseApiServices _apiServices = NetworkApiService() ;

  Future<FavouritesFolder> fetchAllFavFolders({required String userId})async{

    try{

      dynamic response = await _apiServices.getGetApiResponse("${AppUrl.favouritesFolders}/$userId");
      return response = FavouritesFolder.fromJson(response);

    }catch(e){
      rethrow ;
    }
  }

  Future<dynamic> addFavFolders(dynamic data)async{

    try{

      dynamic response = await _apiServices.getPostApiResponse(
        AppUrl.favouritesFolders,
        data,
      );
      return response;

    }catch(e){
      rethrow ;
    }
  }

  Future<dynamic> updateFavFolders(String folderId, dynamic data)async{

    try{

      dynamic response = await _apiServices.getPutApiResponse("${AppUrl.favouritesFolders}/$folderId",
        data: data,
      );
      return response;

    }catch(e){
      rethrow ;
    }
  }

  Future<dynamic> deleteFavFolders(String folderId)async{

    try{

      dynamic response = await _apiServices.getDeleteApiResponse("${AppUrl.favouritesFolders}/$folderId");
      return response;

    }catch(e){
      rethrow ;
    }
  }

  Future<FavExistsModel> checkIfFavExists({required String photoId})async{
    try{
      dynamic response = await _apiServices.getGetApiResponse("${AppUrl.favouritesFolders}/$photoId/exists");
      return response = FavExistsModel.fromJson(response);
    }catch(e){
      rethrow ;
    }
  }

  Future<ProductsModel> fetchAllFavImages({required String folderId, required int page})async{

    try{

      dynamic response = await _apiServices.getGetApiResponse("${AppUrl.favouritesFolders}/$folderId/images?page=$page");
      if(response['message'] == "Resource not found!"){
        return response = const ProductsModel(message: "",data: productModel.Data());
      }
      return response = ProductsModel.fromJson(response);

    }catch(e){
      rethrow ;
    }
  }

  Future<ProductsModel> wardrobeImages({required String userId, required int page})async{

    try{

      dynamic response = await _apiServices.getGetApiResponse("${AppUrl.wardrobeListPhotos}$userId/photos?page=$page");
      if(response['message'] == "No photo found."){
        return response = const ProductsModel(message: "",data: productModel.Data());
      }
      return response = ProductsModel.fromJson(response);

    }catch(e){
      rethrow ;
    }
  }

  Future<dynamic> AddFolderImages({dynamic data})async{

    try{

      dynamic response = await _apiServices.getPostApiResponse(AppUrl.addImageToFolder,data);
      return response;

    }catch(e){
      rethrow ;
    }
  }

  Future<dynamic> deleteFolderImages({required int id})async{

    try{

      dynamic response = await _apiServices.getDeleteApiResponse("${AppUrl.addImageToFolder}/$id");
      return response;

    }catch(e){
      rethrow ;
    }
  }

}