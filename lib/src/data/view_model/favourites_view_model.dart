

import 'package:flutter/cupertino.dart';
import 'package:outfit/src/data/model/favourites_folder.dart';
import 'package:outfit/src/data/model/products_model.dart';
import 'package:outfit/src/data/repository/favourites_repo.dart';
import 'package:outfit/src/data/response/api_response.dart';
enum Pages {products,filter,search}
class FavFoldersViewModel with ChangeNotifier {

  final _myRepo = FavFolderRepository();

  ApiResponse<FavouritesFolder> favFolders = ApiResponse.loading();
  ApiResponse<ProductsModel> favFoldersImages = ApiResponse.loading();

  setFavFoldersList(ApiResponse<FavouritesFolder> response){
    favFolders = response ;
    notifyListeners();
  }
  setFavImagesList(ApiResponse<ProductsModel> response){
    favFoldersImages = response ;
    notifyListeners();
  }
  Future<void> favFoldersList() async {

    setFavFoldersList(ApiResponse.loading());

    _myRepo.fetchAllFavFolders("2906").then((value){
      setFavFoldersList(ApiResponse.completed(value));
    }).onError((error, stackTrace){

      setFavFoldersList(ApiResponse.error(error.toString()));

    });
  }

  Future<void> favFolderImagesList() async {

    setFavImagesList(ApiResponse.loading());

    _myRepo.fetchAllFavImages("48").then((value){
      setFavImagesList(ApiResponse.completed(value));
    }).onError((error, stackTrace){

      setFavImagesList(ApiResponse.error(error.toString()));

    });
  }
}