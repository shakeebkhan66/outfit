

import 'package:flutter/cupertino.dart';
import 'package:outfit/src/data/model/colors_model.dart';
import 'package:outfit/src/data/model/types_model.dart';
import 'package:outfit/src/data/repository/colors_repository.dart';
import 'package:outfit/src/data/response/api_response.dart';
class ColorsAndStyleModels {
  final ColorsModel colorsModel;
  final TypesModel typesModel;

  ColorsAndStyleModels({required this.colorsModel, required this.typesModel});
}

class ColorsAndStylesViewModel with ChangeNotifier {

  final _myRepo = ColorsRepository();

  ApiResponse<ColorsAndStyleModels> colorsList = ApiResponse.loading();

  setColorsList(ApiResponse<ColorsAndStyleModels> response){
    colorsList = response ;
    notifyListeners();
  }

  Future<void> fetchColorsList() async {

    setColorsList(ApiResponse.loading());

    _myRepo.fetchAllColors().then((colors){
    _myRepo.fetchAllStyles().then((styles){
      setColorsList(
        ApiResponse.completed(
          ColorsAndStyleModels(colorsModel: colors,typesModel: styles)
        ),
      );
    });
    }).onError((error, stackTrace){

      setColorsList(ApiResponse.error(error.toString()));

    });
  }
}