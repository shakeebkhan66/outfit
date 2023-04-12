

import 'package:flutter/cupertino.dart';
import 'package:outfit/src/data/model/pair_search_model.dart';
import 'package:outfit/src/data/model/products_model.dart';
import 'package:outfit/src/data/repository/pairs_filter_repo.dart';
import 'package:outfit/src/data/repository/products_repo.dart';
import 'package:outfit/src/data/response/api_response.dart';
enum Pages {products,filter,search}
class ProductsViewModel with ChangeNotifier {

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

  Future<void> fetchPhotosList() async {
    setPhotosList(ApiResponse.loading());

    _myRepo.fetchAllPhotos(getPage).then((value){
      setTotalPages(value.data!.last_page!);
      setPhotosList(ApiResponse.completed(value));
    }).onError((error, stackTrace){

      setPhotosList(ApiResponse.error(error.toString()));

    });
  }
  Future<void> filterPhotoPhotosList() async {

    setPhotosList(ApiResponse.loading());

    _myRepo.filterAllPhotos(getstyle,gethijab,getseason,getPage).then((value){
      setTotalPages(value.data!.last_page!);
      setPhotosList(ApiResponse.completed(value));
    }).onError((error, stackTrace){

      setPhotosList(ApiResponse.error(error.toString()));

    });
  }

  Future<void> fetchFilterPairList(FilterPairModel pairModel) async {

    setPhotosList(ApiResponse.loading());

    _myRepoFilter.fetchAllPairs(pairModel,getPage).then((value){
      setTotalPages(value.data!.last_page!);
      setPhotosList(ApiResponse.completed(value));
    }).onError((error, stackTrace){

      setPhotosList(ApiResponse.error(error.toString()));

    });
  }
  
  Future<void> likeImageById({String? email, String? id}) async {

    setLoading(true);

    _myRepo.likePhoto(email: "umair@gmail.com", id: "43377").then((value){
      setLoading(false);
    }).onError((error, stackTrace){
      setLoading(false);
    });
  }

  Future<void> unLikeImageById({String? email, String? id}) async {

    setLoading(true);

    _myRepo.unLikePhoto(email: "umair@gmail.com", id: "43377").then((value){
      setLoading(false);
    }).onError((error, stackTrace){
      setLoading(false);
    });
  }

}