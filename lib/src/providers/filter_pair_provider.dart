import 'package:flutter/material.dart';

class FilterPairProvider extends ChangeNotifier {
  List<int?> searchColor = <int?>[null];
  List<int?> searchType = <int?>[null];
  List<int?> searchpattern = <int?>[null];

  List<int?> get getSearchColor => searchColor;
  List<int?> get getSearchType => searchType;
  List<int?> get getSearchPattern => searchpattern;

  setSearchColor(int i, int color){
    searchColor[i] = color;
  }
  setType(int i, int type){
    searchType[i] = type;
  }
  setPattern(int i , int pattern){
    searchpattern[i] = pattern;
  }
  addNullAtEnd(){
    searchColor.add(null);
    searchType.add(null);
    searchpattern.add(null);
    notifyListeners();
  }

  removeNullAtEnd(int index){
    searchColor.removeAt(index);
    searchType.removeAt(index);
    searchpattern.removeAt(index);
    notifyListeners();
  }
  clearaddNullAtEnd(){
    searchColor.clear();
    searchType.clear();
    searchpattern.clear();
    searchColor.add(null);
    searchType.add(null);
    searchpattern.add(null);
    notifyListeners();
  }
}