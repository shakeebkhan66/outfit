

import 'dart:convert';

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

  int page = 1;
  int totalPages = 0;

  int get getPage => page;
  int get getTotalPages => totalPages;
  setTotalPages(int settotalPages){
    totalPages = settotalPages;
    notifyListeners();
  }
  setNextPage(){
    page++;
    notifyListeners();
  }
  setPreviousPage(){
    if(getPage != 1){
      page--;
      notifyListeners();
    }
  }

  Future<void> favFoldersList({required String userId}) async {

    setFavFoldersList(ApiResponse.loading());

    _myRepo.fetchAllFavFolders(userId: userId).then((value){
      setFavFoldersList(ApiResponse.completed(value));
    }).onError((error, stackTrace){

      setFavFoldersList(ApiResponse.error(error.toString()));

    });
  }

  Future<void> addFolder({required String userId, UpdateFolderData? data}) async {

    setFavFoldersList(ApiResponse.loading());
    await _myRepo.addFavFolders(data!.toJson());
    _myRepo.fetchAllFavFolders(userId: userId).then((value){
      setFavFoldersList(ApiResponse.completed(value));
    }).onError((error, stackTrace){
      print(stackTrace);
      setFavFoldersList(ApiResponse.error(error.toString()));

    });
  }

  Future<void> updateFolderName({required String folderId,required String userId, UpdateFolderData? data}) async {

    setFavFoldersList(ApiResponse.loading());
    await _myRepo.updateFavFolders(folderId, data!.toJson());
    _myRepo.fetchAllFavFolders(userId: userId).then((value){
      setFavFoldersList(ApiResponse.completed(value));
    }).onError((error, stackTrace){
      print(stackTrace);
      setFavFoldersList(ApiResponse.error(error.toString()));

    });
  }


  Future<void> deleteFolder({required String folderId, required String userId}) async {

    setFavFoldersList(ApiResponse.loading());
    await _myRepo.deleteFavFolders(folderId);
    _myRepo.fetchAllFavFolders(userId: userId).then((value){
      setFavFoldersList(ApiResponse.completed(value));
    }).onError((error, stackTrace){
      print(stackTrace);
      setFavFoldersList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> favFolderImagesList({required String folderId, required String email, required String ip}) async {
    setFavImagesList(ApiResponse.loading());

    _myRepo.fetchAllFavImages(folderId: folderId, page: getPage).then((value){
      setTotalPages(value.data!.last_page!);
      setFavouriteList(value.data!.data!,email: email,ip: ip);
      setFavImagesList(ApiResponse.completed(value));
    }).onError((error, stackTrace){
      print(stackTrace);

      setFavImagesList(ApiResponse.error(error.toString()));

    });
  }

  Future<void> dressMeImagesList({required String userId,required String email, required String ip}) async {

    setFavImagesList(ApiResponse.loading());

    _myRepo.wardrobeImages(userId: userId,page: getPage).then((value){
      print("this is last page${value.data!.last_page!}");
      setTotalPages(value.data!.last_page!);
      setFavouriteList(value.data!.data??[],email: email,ip: ip);
      setFavImagesList(ApiResponse.completed(value));
    }).onError((error, stackTrace){
      print(error);
      print(stackTrace);
      setFavImagesList(ApiResponse.error(error.toString()));

    });
  }

  Future<bool> addImageToFolderApi({dynamic data, String? folderName, BuildContext? context}) async {
    setLoading(true);
    _myRepo.AddFolderImages(data: data).then((value){
      setLoading(false);
      AppUtils.flushBarSucessMessage('Added to $folderName', context!);
      if(kDebugMode){
        print(value.toString());
      }
      return true;
    }).onError((error, stackTrace){
      setLoading(false);
      AppUtils.flushBarErrorMessage(error.toString(), context!);
      if(kDebugMode){
        print(error.toString());
      }
      return false;
    });
    return false;
  }

  List<int> favouriteList = [];

  List<int> get getFavouriteList => favouriteList;

  List<int> likesList = [];

  List<int> get getlikesList => likesList;

  setFavouriteList(List<ProductsData>? productListData,{required String ip, required String email}){
    favouriteList.clear();
    likesList.clear();
    for (int i = 0; i < productListData!.length; i++) {
      if(productListData[i].likes!=null){
        if(productListData[i].likes is String){
          if(checkIfLikeExists(
          list: productListData[i].likes.toString(),
          email: email==""? ip: email)){
            if(!favouriteList.contains(i)){
              favouriteList.add(i);
            }
          }
          likesList.add(likesCount(jsonDecode(productListData[i].likes)));
        }else{
          if(checkIfLikeExists(
          list: productListData[i].likes.toString(),
          email: email==""? ip: email)){
            if(!favouriteList.contains(i)){
              favouriteList.add(i);
            }
          }
          likesList.add(likesCount(productListData[i].likes));
        }
      }else{
        likesList.add(0);
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

  incrementFromFavourite(int index) {
    likesList[index]++;
    notifyListeners();
  }

  decrementFromFavourite(int index) {
    likesList[index]--;
    notifyListeners();
  }
}