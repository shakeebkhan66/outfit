

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:outfit/src/data/model/pair_search_model.dart';
import 'package:outfit/src/data/model/products_model.dart';
import 'package:outfit/src/data/repository/pairs_filter_repo.dart';
import 'package:outfit/src/data/repository/products_repo.dart';
import 'package:outfit/src/data/response/api_response.dart';
import 'package:outfit/src/widgets/get_likes_count.dart';
enum Pages {products,filter,search}
class ProductsViewModel with ChangeNotifier {

  String pageName = "outfit";

  String get getPageName => pageName;

  setPage(String setPage){
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
  bool _loading = false ;
  bool get loading => _loading ;

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  ApiResponse<ProductsModel> productsList = ApiResponse.loading();

  setPhotosList(ApiResponse<ProductsModel> response){
    productsList = response ;
    notifyListeners();
  }
  dynamic style; 
  dynamic hijab; 
  dynamic season;

  dynamic get getstyle=> style; 
  dynamic get gethijab=> hijab; 
  dynamic get getseason=> season;

  setFilterValues(dynamic setstyle, dynamic sethijab, dynamic setseason){
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
  
  setTotalPages(int settotalPages){
    totalPages = settotalPages;
    notifyListeners();
  }
  setNoPage(int setPage){
    page = setPage;
    notifyListeners();
  }

  Future<void> fetchPhotosList({required String email,required String ip}) async {
    print(email);
    print(ip);
    setPhotosList(ApiResponse.loading());

    _myRepo.fetchAllPhotos(getPage).then((value) async{
      await setFavouriteList(value.data!.data!,email: email,ip: ip);
      setTotalPages(value.data!.last_page!);
      setPhotosList(ApiResponse.completed(value));
    }).onError((error, stackTrace){

      setPhotosList(ApiResponse.error(error.toString()));

    });
  }
  Future<void> filterPhotoPhotosList({required String email, required String ip}) async {

    setPhotosList(ApiResponse.loading());

    _myRepo.filterAllPhotos(getstyle,gethijab,getseason,getPage).then((value){
      setFavouriteList(value.data!.data!,email: email, ip: ip);
      setTotalPages(value.data!.last_page!);
      setPhotosList(ApiResponse.completed(value));
    }).onError((error, stackTrace){

      setPhotosList(ApiResponse.error(error.toString()));

    });
  }

  Future<void> fetchFilterPairList(FilterPairModel pairModel,{required String email, required String ip}) async {

    setPhotosList(ApiResponse.loading());

    _myRepoFilter.fetchAllPairs(pairModel,getPage).then((value){
      setFavouriteList(value.data!.data!, email: email, ip: ip);
      setTotalPages(value.data!.last_page!);
      setPhotosList(ApiResponse.completed(value));
    }).onError((error, stackTrace){

      setPhotosList(ApiResponse.error(error.toString()));

    });
  }
  
  Future<void> likeImageById({required String email,required String ip, String? id}) async {

    setLoading(true);

    _myRepo.likePhoto(email: email,ip: ip, id: id).then((value){
      setLoading(false);
    }).onError((error, stackTrace){
      setLoading(false);
    });
  }

  Future<void> unLikeImageById({required String email, required String ip, String? id}) async {

    setLoading(true);

    _myRepo.unLikePhoto(email: email,ip: ip, id: id).then((value){
      setLoading(false);
    }).onError((error, stackTrace){
      setLoading(false);
    });
  }

  List<int> favouriteList = [];

  List<int> get getFavouriteList => favouriteList;

  List<int> likesList = [];

  List<int> get getlikesList => likesList;

  Future setFavouriteList(List<ProductsData>? productListData,{required String ip, required String email}) async {
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
    print(index);
    print(likesList);
    likesList[index]++;
    notifyListeners();
  }

  decrementFromFavourite(int index) {
    likesList[index]--;
    notifyListeners();
  }

}