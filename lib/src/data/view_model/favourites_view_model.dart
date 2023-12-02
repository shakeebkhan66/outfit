import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:outfit/src/data/model/fav_exists_model.dart';
import 'package:outfit/src/data/model/favourites_folder.dart';
import 'package:outfit/src/data/model/products_model.dart';
import 'package:outfit/src/data/repository/favourites_repo.dart';
import 'package:outfit/src/data/response/api_response.dart';
import 'package:outfit/src/utils/app_utils.dart';
import 'package:outfit/src/widgets/get_likes_count.dart';

enum Pages { products, filter, search }

class FavFoldersViewModel with ChangeNotifier {
  final _myRepo = FavFolderRepository();
  FavExistsModel favExistsModel = const FavExistsModel();

  FavExistsModel get getFavExistsModel => favExistsModel;

  setFavExists(FavExistsModel setFavExistsModel) {
    favExistsModel = setFavExistsModel;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  List<int> favImageFolderIds = [];
  List<int> favImageIds = [];

  List<int> get getFavImageFolderIds => favImageFolderIds;
  List<int> get getFavImageIds => favImageIds;

  setfavImageFolderIds(int favFolderId, int imgid) {
    favImageFolderIds.add(favFolderId);
    favImageIds.add(imgid);
    notifyListeners();
  }

  clearFavImageFolderIds() {
    favImageFolderIds.clear();
    notifyListeners();
  }

  clearFavImageIds() {
    favImageIds.clear();
    favImageFolderIds.clear();
    notifyListeners();
  }

  setRemovefavImageFolderIds(int favFolderId, int imageId) {
    favImageFolderIds.remove(favFolderId);
    favImageIds.remove(imageId);
    notifyListeners();
  }

  ApiResponse<FavouritesFolder> favFolders = ApiResponse.loading();
  ApiResponse<ProductsModel> favFoldersImages = ApiResponse.loading();

  setFavFoldersList(ApiResponse<FavouritesFolder> response) {
    favFolders = response;
    notifyListeners();
  }

  setFavImagesList(ApiResponse<ProductsModel> response) {
    favFoldersImages = response;
    notifyListeners();
  }

  int page = 1;
  int totalPages = 0;

  int get getPage => page;
  int get getTotalPages => totalPages;
  setTotalPages(int settotalPages) {
    totalPages = settotalPages;
    notifyListeners();
  }

  setNoPage(int index) {
    page = index;
    notifyListeners();
  }

  increaseTotalPages() {
    if (getTotalPages > 14) {
      int addedPage = getPage + 9;
      if (addedPage < getTotalPages) {
        page = addedPage;
      }
    }
    notifyListeners();
  }

  decreaseTotalPages() {
    if (getTotalPages > 14) {
      int addedPage = getPage - 9;
      if (addedPage > 1) {
        page = addedPage;
      }
    }
    notifyListeners();
  }

  Future<void> favFoldersList({required String userId}) async {
    setFavFoldersList(ApiResponse.loading());

    _myRepo.fetchAllFavFolders(userId: userId).then((value) {
      setFavFoldersList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setFavFoldersList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> addFolder({required String userId, UpdateFolderData? data}) async {
    setFavFoldersList(ApiResponse.loading());
    await _myRepo.addFavFolders(data!.toJson());
    _myRepo.fetchAllFavFolders(userId: userId).then((value) {
      setFavFoldersList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      print(stackTrace);
      setFavFoldersList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> checkIfFav({required String photoId, required String userId}) async {
    _myRepo.checkIfFavExists(photoId: photoId).then((value) {
      clearFavImageFolderIds();
      if (value.data!.isNotEmpty || value.data != null) {
        for (var element in value.data!) {
          if (element.user == userId) {
            if (!favImageFolderIds.contains(element.id)) {
              setfavImageFolderIds(element.list!, element.img!);
            }
          }
        }
      }
    }).onError((error, stackTrace) {
      print(stackTrace);
    });
  }

  Future<void> updateFolderName({required String folderId, required String userId, UpdateFolderData? data}) async {
    setFavFoldersList(ApiResponse.loading());
    await _myRepo.updateFavFolders(folderId, data!.toJson());
    _myRepo.fetchAllFavFolders(userId: userId).then((value) {
      setFavFoldersList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      print(stackTrace);
      setFavFoldersList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> deleteFolder({required String folderId, required String userId}) async {
    setFavFoldersList(ApiResponse.loading());
    await _myRepo.deleteFavFolders(folderId);
    _myRepo.fetchAllFavFolders(userId: userId).then((value) {
      setFavFoldersList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      print(stackTrace);
      setFavFoldersList(ApiResponse.error(error.toString()));
    });
  }

   favFolderImagesList({required String folderId, required String email}) async {
    setFavImagesList(ApiResponse.loading());

  return await _myRepo.fetchAllFavImages(folderId: folderId, page: getPage).then((value) {
      setImagesUrls(value.data!.data!);
      setTotalPages(value.data!.last_page!);
      setFavouriteList(value.data!.data!, email: email);
          setFavImagesList(ApiResponse.completed(value));
          print('likesList:${likesList}');
          return likesList;
    }).onError((error, stackTrace) {
      print("stackTrace");

      setFavImagesList(ApiResponse.error(error.toString()));
      return likesList;
    });
  }

  Future<void> dressMeImagesList({required String userId, required String email}) async {
    setFavImagesList(ApiResponse.loading());

    _myRepo.wardrobeImages(userId: userId, page: getPage).then((value) {
      print(value.data);
      if (value.data!.data == null) {
        setFavImagesList(ApiResponse.completed(value));
      } else {
        setTotalPages(value.data!.last_page!);
        setImagesUrls(value.data!.data!);
        calculateTotalPages();
        setDisplayImages();
        setFavouriteList(value.data!.data ?? [], email: email);
        setFavImagesList(ApiResponse.completed(value));
      }
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
      setFavImagesList(ApiResponse.error(error.toString()));
    });
  }

  bool isLoadingImages = false;
  bool get getIsLoadingImages => isLoadingImages;

  final int pageSize = 12;
  int currentImage = 1;
  int totalImages = 0;
  int get getCurrentImage => currentImage;
  int get getTotalImage => totalImages;

  List<String> imagesUrls = [];
  List<String> get getImagesUrls => imagesUrls;

  calculateTotalPages() {
    totalImages = (imagesUrls.length / pageSize).ceil();
    notifyListeners();
  }

  loadMoreImages() {
    print("Loadint more image that get");
    currentImage++;
    setDisplayImages();
    notifyListeners();
  }

  setImagesLoading() {
    isLoadingImages = !isLoadingImages;
    notifyListeners();
  }

  setImagesUrls(List<ProductsData> products) {
    for (var element in products) {
      imagesUrls.add(element.url!);
    }
    notifyListeners();
  }

  List<String> displayImages = [];
  List<String> get getDisplayImages => displayImages;

  Future setDisplayImages() async {
    print(imagesUrls);
    isLoadingImages = true;
    final int startIndex = (currentImage - 1) * pageSize;
    final int endIndex = startIndex + pageSize;
    print(startIndex);
    print(endIndex);
    displayImages.addAll(imagesUrls.sublist(startIndex, endIndex));
    Future.delayed(const Duration(milliseconds: 500), () {
      isLoadingImages = false;
    });
    notifyListeners();
  }

  setImagesData() {
    currentImage = 1;
    totalImages = 0;
    imagesUrls.clear();
    displayImages.clear();
    notifyListeners();
  }

  Future<bool> addImageToFolderApi({dynamic data, String? folderName, BuildContext? context}) async {
    setLoading(true);
    await _myRepo.AddFolderImages(data: data).then((value) {
      setLoading(false);
      AppUtils.flushBarSucessMessage('Added to $folderName', context!);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      AppUtils.flushBarErrorMessage(error.toString(), context!);
      if (kDebugMode) {
        print(error.toString());
      }
    });
    return Future.value(true);
  }

  Future<bool> deleteImageToFolderApi({required int imageId, required int folderId, required String folderName, BuildContext? context}) async {
    setLoading(true);
    await _myRepo.deleteFolderImages(imageId: imageId, folderId: folderId).then((value) {
      setLoading(false);
      AppUtils.flushBarErrorMessage('Removed from $folderName', context!);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      AppUtils.flushBarErrorMessage(error.toString(), context!);
      if (kDebugMode) {
        print(error.toString());
      }
    });
    return Future.value(true);
  }

  List<int> favouriteList = [];

  List<int> get getFavouriteList => favouriteList;

  List<int> likesList = [];

  List<int> get getlikesList => likesList;

  setFavouriteList(List<ProductsData>? productListData, {required String email}) {
    favouriteList.clear();
    likesList.clear();
    for (int i = 0; i < productListData!.length; i++) {
      print(productListData[i].likes);
      print("this is returning");
      if (productListData[i].likes != null) {
        if (productListData[i].likes is String) {
          if (checkIfLikeExists(list: productListData[i].likes.toString(), email: email)) {
            if (!favouriteList.contains(i)) {
              favouriteList.add(i);
            }
          }
          if (productListData[i].likes == "") {
            likesList.add(0);
          } else {
            likesList.add(likesCount(jsonDecode(productListData[i].likes)));
          }
          print(likesList);
        } else {
          if (checkIfLikeExists(list: productListData[i].likes.toString(), email: email)) {
            if (!favouriteList.contains(i)) {
              favouriteList.add(i);
            }
          }
          likesList.add(likesCount(productListData[i].likes));
        }
      } else {
        likesList.add(0);
      }
    }
    print(likesList);
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
