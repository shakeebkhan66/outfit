

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:outfit/src/base/assets.dart';
import 'package:outfit/src/data/model/colors_model.dart';
import 'package:outfit/src/data/model/wardrobe_list_model.dart';
import 'package:outfit/src/data/repository/wardrobe_repo.dart';
import 'package:outfit/src/data/response/api_response.dart';
import 'package:outfit/src/utils/app_utils.dart';
class WardrobeModels {
  final ColorsModel colorsModel;
  final WardrobeListModel wardrobeListModel;

  WardrobeModels({required this.colorsModel, required this.wardrobeListModel});
}

class WardrobeViewModel with ChangeNotifier {

  final _myRepo = WardrobeRepository();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  ApiResponse<WardrobeModels> colorsList = ApiResponse.loading();

  setColorsList(ApiResponse<WardrobeModels> response){
    colorsList = response ;
    notifyListeners();
  }

  Future<void> fetchWardrobeList() async {

    setColorsList(ApiResponse.loading());

    _myRepo.fetchAllColors().then((colors){
    _myRepo.fetchAllWardrobeList("2794263897328614").then((wardrobelist){
      setColorsList(
        ApiResponse.completed(
          WardrobeModels(colorsModel: colors,wardrobeListModel: wardrobelist)
        ),
      );
      setSelectedColors(wardrobelist);
    });
    }).onError((error, stackTrace){
      setColorsList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> addWardrobeApi(dynamic data , BuildContext context) async {
    setLoading(true);
    _myRepo.addWardrobe(data).then((value){
      setLoading(false);
      AppUtils.flushBarSucessMessage('Added to wardrobe', context);
      if(kDebugMode){
        print(value.toString());
      }
    }).onError((error, stackTrace){
      setLoading(false);
      AppUtils.flushBarErrorMessage(error.toString(), context);
      if(kDebugMode){
        print(error.toString());
      }
    });
  }

  Future<void> updateWardrobeApi(dynamic data, String wardrobeId, BuildContext context) async {
    setLoading(true);
    _myRepo.updateWardrobe(jsonEncode(data),wardrobeId).then((value){
      setLoading(false);
      AppUtils.flushBarSucessMessage('Added to wardrobe', context);
      if(kDebugMode){
        print(value.toString());
      }
    }).onError((error, stackTrace){
      setLoading(false);
      AppUtils.flushBarErrorMessage(error.toString(), context);
      if(kDebugMode){
        print(error.toString());
      }
    });
  }

  

  final wardRobe = <DataModel>[
    DataModel(
      id: "2",
      title: 'Trousers',
      arabicTitle: "بنطلون",
      icon: AppAssets.trouserIcon,
      width: 17,
      height: 28,
      dividerMargin: const EdgeInsets.only(left: 22, right: 19),
    ),
    DataModel(
      id: "7",
      title: 'Shirt',
      arabicTitle: "قميص",
      icon: AppAssets.shirtIcon,
      width: 24,
      height: 22,
      dividerMargin: const EdgeInsets.only(left: 15, right: 19),
    ),
    DataModel(
      id: "5",
      title: 'Tops (sweater-blouse-shirt)',
      arabicTitle: "بلوزة - تيشيرت - بلوفر",
      icon: AppAssets.topsIcon,
      width: 24,
      height: 24,
      dividerMargin: const EdgeInsets.only(left: 15, right: 19),
    ),
    DataModel(
      id: "3",
      title: 'Skirt',
      arabicTitle: "جيبة تنورة",
      icon: AppAssets.skirtIcon,
      width: 25,
      height: 22,
      dividerMargin: const EdgeInsets.only(left: 14, right: 19),
    ),
    DataModel(
      id: "4",
      title: 'Dress-Jumpsuit-Abaya',
      arabicTitle: "فستان - عباية - جامبسوت",
      icon: AppAssets.dressJumpsuitAbayaIcon,
      width: 20,
      height: 25,
      dividerMargin: const EdgeInsets.only(left: 19, right: 19),
    ),
    DataModel(
      id: "1",
      title: 'Jacket-coat',
      arabicTitle: "جاكيت - معطف",
      icon: AppAssets.jacketCoatIcon,
      width: 23,
      height: 25,
      dividerMargin: const EdgeInsets.only(left: 16, right: 19),
    ),
    DataModel(
      id: "8",
      title: 'Blazer',
      arabicTitle: "بليزر",
      icon: AppAssets.blazerIcon,
      width: 17,
      height: 25,
      dividerMargin: const EdgeInsets.only(left: 22, right: 19),
    ),
    DataModel(
      id: "6",
      title: 'Cardigon-Kimono-Bolero',
      arabicTitle: "كارديجان - كيمونو",
      icon: AppAssets.cardigonKimonoBoleroIcon,
      width: 22.67,
      height: 24,
      dividerMargin: const EdgeInsets.only(left: 16.33, right: 19),
    ),
  ];

  late final Map<String, List<String>> selectedColors = <String, List<String>>{
    for (int i = 0; i < wardRobe.length; i++) wardRobe[i].id: [],
  };

  late final Map<String, String> wardrobeIds = <String, String>{
    for (int i = 0; i < wardRobe.length; i++) wardRobe[i].id: "",
  };

  Map<String, List<String>> get getSelectedColors => selectedColors;

  Map<String, String> get getwardrobeIds => wardrobeIds;

  setSelectedColors(WardrobeListModel  wardrobeList) {
      for (var d in wardrobeList.data!) {
        debugPrint(d.colors.toString());
        debugPrint(d.id.toString());
        selectedColors[d.type!]!.addAll(d.colors!);
        wardrobeIds[d.type!] = d.id.toString();
      }
     notifyListeners();
  }
}





class DataModel {
  final String id;
  final String title;
  final String arabicTitle;
  final String icon;
  final double height;
  final double width;
  final EdgeInsets dividerMargin;
  bool isExpanded;

  DataModel({
    required this.id,
    required this.title,
    required this.icon,
    required this.width,
    required this.height,
    required this.arabicTitle,
    required this.dividerMargin,
    this.isExpanded = false,
  });
}