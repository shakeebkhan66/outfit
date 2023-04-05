

import 'package:flutter/cupertino.dart';
import 'package:outfit/src/data/model/products_model.dart';
import 'package:outfit/src/data/repository/products_repo.dart';
import 'package:outfit/src/data/response/api_response.dart';

class ProductsViewModel with ChangeNotifier {

  final _myRepo = ProductsRepository();

  ApiResponse<ProductsModel> productsList = ApiResponse.loading();

  setPhotosList(ApiResponse<ProductsModel> response){
    productsList = response ;
    notifyListeners();
  }
  int page = 1;

  int get getPage => page;

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
      setPhotosList(ApiResponse.completed(value));

    }).onError((error, stackTrace){

      setPhotosList(ApiResponse.error(error.toString()));

    });
  }
}