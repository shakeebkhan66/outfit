import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:outfit/src/data/model/pair_search_model.dart';
import 'package:outfit/src/data/model/products_model.dart';
import 'package:outfit/src/data/repository/pairs_filter_repo.dart';
import 'package:outfit/src/data/repository/products_repo.dart';
import 'package:outfit/src/data/response/api_response.dart';
import 'package:outfit/src/widgets/get_likes_count.dart';

enum Pages { products, filter, search }

class ProductsViewModel with ChangeNotifier {
  String pageName = "outfit";

  String get getPageName => pageName;

  setPage(String setPage) {
    pageName = setPage;
    notifyListeners();
  }

  int index = 0;

  int get getIndex => index;

  setSetIndex(int setIndex) {
    print("setting");
    index = setIndex;
    notifyListeners();
  }

  final _myRepo = ProductsRepository();
  final _myRepoFilter = PairFilterRepository();
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ApiResponse<ProductsModel> productsList = ApiResponse.loading();

  setPhotosList(ApiResponse<ProductsModel> response) {
    productsList = response;
    notifyListeners();
  }

  dynamic style;
  dynamic hijab;
  dynamic season;

  dynamic get getstyle => style;
  dynamic get gethijab => hijab;
  dynamic get getseason => season;

  setFilterValues(dynamic setstyle, dynamic sethijab, dynamic setseason) {
    style = setstyle;
    hijab = sethijab;
    season = setseason;
    notifyListeners();
  }

  int page = 1;
  int totalPages = 0;
  Pages currentPage = Pages.products;
  Pages get getCurrentPage => currentPage;

  setCurrentPage(Pages setPage) {
    page = 1;
    currentPage = setPage;
    notifyListeners();
  }

  int get getPage => page;
  int get getTotalPages => totalPages;

  setTotalPages(int settotalPages) {
    print(settotalPages);
    totalPages = settotalPages;
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

  setNoPage(int setPage) {
    page = setPage;
    notifyListeners();
  }

  Future<void> fetchPhotosList({required String email, required context}) async {
    setPhotosList(ApiResponse.loading());
    setImagesLoading();
    setImagesData();
    _myRepo.fetchAllPhotos(getPage).then((value) async {
      setImagesUrls(value.data!.data!);
      calculateTotalPages();
      setDisplayImages();
      setTotalPages(value.data!.last_page!);
      setFavouriteList(value.data!.data!, email: email);
      setPhotosList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      print(stackTrace);
      setPhotosList(ApiResponse.error(error.toString()));
    });
  }

  bool isLoadingImages = false;
  bool get getIsLoadingImages => isLoadingImages;

  final int pageSize = 12;
  int currentImage = 1;
  int totalImages = 0;
  int get getCurrentImage => currentImage;
  int get getTotalImage => totalImages;

  calculateTotalPages() {
    totalImages = (imagesUrls.length / pageSize).ceil();
    notifyListeners();
  }

  loadMoreImages() {
    currentImage++;
    setDisplayImages();
    notifyListeners();
  }

  setImagesLoading() {
    isLoadingImages = true;
    notifyListeners();
  }

  setImagesLoadingfalse() {
    isLoadingImages = false;
    notifyListeners();
  }

  List<String> imagesUrls = [];
  List<String> get getImagesUrls => imagesUrls;

  setImagesUrls(List<ProductsData> products) {
    for (var element in products) {
      imagesUrls.add(element.url!);
    }
    notifyListeners();
  }

  List<String> displayImages = [];
  List<String> get getDisplayImages => displayImages;

  Future setDisplayImages() async {
    final int startIndex = (currentImage - 1) * pageSize;
    final int endIndex = startIndex + pageSize;
    displayImages.addAll(imagesUrls.sublist(startIndex, endIndex));
    notifyListeners();
  }

  setImagesData() {
    currentImage = 1;
    totalImages = 0;
    imagesUrls.clear();
    displayImages.clear();
    notifyListeners();
  }

  Future<void> filterPhotoPhotosList({required String email, required context}) async {
    setPhotosList(ApiResponse.loading());
    setImagesLoading();
    setImagesData();
    _myRepo.filterAllPhotos(getstyle, gethijab, getseason, getPage).then((value) {
      setImagesUrls(value.data!.data!);
      calculateTotalPages();
      setDisplayImages();
      setFavouriteList(value.data!.data!, email: email);
      setTotalPages(value.data!.last_page!);
      setPhotosList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setPhotosList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> fetchFilterPairList(FilterPairModel pairModel, {required String email, required context}) async {
    setPhotosList(ApiResponse.loading());
    setImagesLoading();
    setImagesData();
    _myRepoFilter.fetchAllPairs(pairModel, getPage).then((value) {
      setImagesUrls(value.data!.data!);
      calculateTotalPages();
      setDisplayImages();
      setFavouriteList(value.data!.data!, email: email);
      setTotalPages(value.data!.last_page!);
      setPhotosList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setPhotosList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> likeImageById({required String email, String? id}) async {
    setLoading(true);

    _myRepo.likePhoto(email: email, id: id).then((value) {
      setLoading(false);
    }).onError((error, stackTrace) {
      setLoading(false);
    });
  }

  Future<void> unLikeImageById({required String email, String? id}) async {
    setLoading(true);

    _myRepo.unLikePhoto(email: email, id: id).then((value) {
      setLoading(false);
    }).onError((error, stackTrace) {
      setLoading(false);
    });
  }

  List<int> favouriteList = [];

  List<int> get getFavouriteList => favouriteList;

  List<int> likesList = [];

  List<int> get getlikesList => likesList;

  Future setFavouriteList(List<ProductsData>? productListData, {required String email}) async {
    favouriteList.clear();
    likesList.clear();
    for (int i = 0; i < productListData!.length; i++) {
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
        } else {
          if (checkIfLikeExists(list: productListData[i].likes.toString(), email: email)) {
            if (!favouriteList.contains(i)) {
              favouriteList.add(i);
            }
          }
          if (productListData[i].likes == "") {
            likesList.add(0);
          } else {
            likesList.add(likesCount(productListData[i].likes));
          }
        }
      } else {
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
