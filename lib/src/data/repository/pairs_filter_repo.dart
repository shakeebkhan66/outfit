



import 'dart:convert';

import 'package:outfit/src/data/model/pair_search_model.dart';
import 'package:outfit/src/data/model/products_model.dart';
import 'package:outfit/src/data/network/base_api_service.dart';
import 'package:outfit/src/data/network/network_api_service.dart';
import 'package:outfit/src/utils/app_urls.dart';

class PairFilterRepository {

  final BaseApiServices _apiServices = NetworkApiService() ;

  Future<ProductsModel> fetchAllPairs(FilterPairModel data,page) async {
    try{
      dynamic response = await _apiServices.getPostApiResponse("${AppUrl.findByPairs}?page=$page",
        {
          "pairs" : jsonEncode(data.pairs!.map((e) => e.toJson()).toList()),
          "ptn": data.ptn,
        },
      );
      return response = ProductsModel.fromJson(response);

    }catch(e){
      rethrow ;
    }
  }

}