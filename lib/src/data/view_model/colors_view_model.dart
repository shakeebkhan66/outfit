import 'package:flutter/cupertino.dart';
import 'package:outfit/src/data/model/colors_model.dart';
import 'package:outfit/src/data/model/types_model.dart';
import 'package:outfit/src/data/model/types_model.dart' as type;
import 'package:outfit/src/data/repository/colors_repository.dart';
import 'package:outfit/src/data/response/api_response.dart';

class ColorsAndStyleModels {
  final ColorsModel colorsModel;
  final TypesModel typesModel;

  ColorsAndStyleModels({required this.colorsModel, required this.typesModel});
}

class ColorsAndStylesViewModel with ChangeNotifier {
  final _myRepo = ColorsRepository();

  List<Map<String, List<dynamic>>?> selectedGradientColors = <Map<String, List<dynamic>>?>[null];

  List<Map<String, List<dynamic>>?> get getSelectedGradientColors => selectedGradientColors;

  List<bool> isColorExpanded = [false];
  List<bool> get getIsColorExpanded => isColorExpanded;

  List<bool> isStyleExpanded = [false];
  List<bool> get getIsStyleExpanded => isStyleExpanded;

  List<type.Data?> searchStyle = <type.Data?>[null];

  List<type.Data?> get getSearchStyle => searchStyle;

  clearStyleAndColorSearch() {
    print("clearing");
    isColorExpanded.clear();
    isStyleExpanded.clear();
    selectedGradientColors.clear();
    searchStyle.clear();
    selectedGradientColors.add(null);
    searchStyle.add(null);
    isColorExpanded.add(false);
    isStyleExpanded.add(false);
    notifyListeners();
  }

  void selectGradientColors(int i, String color, List<dynamic> colors) {
    selectedGradientColors[i] = {};
    selectedGradientColors[i]![color] = colors;
    isColorExpanded[i] = !isColorExpanded[i];
    notifyListeners();
  }

  setIsColorExpanded(bool colorValue) {
    print(colorValue);
    isColorExpanded.add(colorValue);
    notifyListeners();
  }

  setIsStyleExpanded(bool styleValue) {
    isStyleExpanded.add(styleValue);
    notifyListeners();
  }

  updateIsStyleExpanded(int i) {
    isStyleExpanded[i] = !isStyleExpanded[i];
    notifyListeners();
  }

  updateIsColorExpanded(int i) {
    print(i);
    print(isColorExpanded[i]);
    isColorExpanded[i] = !isColorExpanded[i];
    print(isColorExpanded[i]);
    notifyListeners();
  }

  setSearchStyle(type.Data? searchStyleValue) {
    print(searchStyleValue);
    searchStyle.add(searchStyleValue);
    notifyListeners();
  }

  updateSearchStyle(int i, type.Data? searchStyleValue) {
    searchStyle[i] = searchStyleValue;
    notifyListeners();
  }

  setIsSelectedGradientColor(dynamic value) {
    print(value);
    print(selectedGradientColors);
    selectedGradientColors.add(value);
    print(selectedGradientColors);

    notifyListeners();
  }

  removeIsColorExpanded(int index) {
    isColorExpanded.removeAt(index);
    notifyListeners();
  }

  removeIsStyleExpanded(bool styleValue) {
    isStyleExpanded.add(styleValue);
    notifyListeners();
  }

  removeSearchStyle(int index) {
    searchStyle.removeAt(index);
  }

  removeIsSelectedGradientColor(int index) {
    selectedGradientColors.removeAt(index);
    notifyListeners();
  }

  ApiResponse<ColorsAndStyleModels> colorsList = ApiResponse.loading();

  setColorsList(ApiResponse<ColorsAndStyleModels> response) {
    colorsList = response;
    notifyListeners();
  }

  Future<void> fetchColorsList() async {
    setColorsList(ApiResponse.loading());

    _myRepo.fetchAllColors().then((colors) {
      _myRepo.fetchAllStyles().then((styles) {
        setColorsList(
          ApiResponse.completed(ColorsAndStyleModels(colorsModel: colors, typesModel: styles)),
        );
      });
    }).onError((error, stackTrace) {
      setColorsList(ApiResponse.error(error.toString()));
    });
  }
}
