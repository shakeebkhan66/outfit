

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:outfit/src/data/model/favourites_folder.dart';
import 'package:outfit/src/data/model/products_model.dart';
import 'package:outfit/src/data/repository/favourites_repo.dart';
import 'package:outfit/src/data/response/api_response.dart';
import 'package:outfit/src/utils/app_utils.dart';
import 'package:outfit/src/widgets/get_likes_count.dart';
enum Pages {products,filter,search}
class FavFoldersViewModel with ChangeNotifier {

  final _myRepo = FavFolderRepository();
  
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

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

  Future<void> updateFolderName(String folderId, UpdateFolderData data) async {

    setFavFoldersList(ApiResponse.loading());
    await _myRepo.updateFavFolders(folderId, data.toJson());
    _myRepo.fetchAllFavFolders("2906").then((value){
      setFavFoldersList(ApiResponse.completed(value));
    }).onError((error, stackTrace){

      setFavFoldersList(ApiResponse.error(error.toString()));

    });
  }

  Future<void> deleteFolder(String folderId) async {

    setFavFoldersList(ApiResponse.loading());
    await _myRepo.deleteFavFolders(folderId);
    _myRepo.fetchAllFavFolders("2906").then((value){
      setFavFoldersList(ApiResponse.completed(value));
    }).onError((error, stackTrace){
      setFavFoldersList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> favFolderImagesList() async {

    setFavImagesList(ApiResponse.loading());

    _myRepo.fetchAllFavImages("854").then((value){
      setFavouriteList(value.data!.data!);
      setFavImagesList(ApiResponse.completed(value));
    }).onError((error, stackTrace){

      setFavImagesList(ApiResponse.error(error.toString()));

    });
  }

  Future<void> dressMeImagesList() async {

    setFavImagesList(ApiResponse.loading());

    _myRepo.wardrobeImages("854").then((value){
      setFavouriteList(value.data!.data!);
      setFavImagesList(ApiResponse.completed(value));
    }).onError((error, stackTrace){

      setFavImagesList(ApiResponse.error(error.toString()));

    });
  }

  Future<bool> addImageToFolderApi(dynamic data ,String folderName, BuildContext context) async {
    setLoading(true);
    _myRepo.AddFolderImages("2794263897328614",data).then((value){
      setLoading(false);
      AppUtils.flushBarSucessMessage('Added to $folderName', context);
      if(kDebugMode){
        print(value.toString());
      }
      return true;
    }).onError((error, stackTrace){
      setLoading(false);
      AppUtils.flushBarErrorMessage(error.toString(), context);
      if(kDebugMode){
        print(error.toString());
      }
      return false;
    });
    return false;
  }

  List<int> favouriteList = [];

  List<int> get getFavouriteList => favouriteList;

  setFavouriteList(List<ProductsData>? productListData){
    favouriteList.clear();
    for (int i = 0; i < productListData!.length; i++) {
      if(checkIfLikeExists(
        list: productListData[i].likes,
        email: "umair@gmail.com")){
          if(!favouriteList.contains(i)){
            favouriteList.add(i);
          }
        }
    }
    notifyListeners();
  }

  addFromFavourite(int value) {
    favouriteList.add(value);
    notifyListeners();
  }

  removeFromFavourite(int value) {
    favouriteList.remove(value);
    notifyListeners();
  }
}