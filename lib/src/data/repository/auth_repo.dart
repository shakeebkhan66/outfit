import '../../utils/app_urls.dart';

import '../network/base_api_service.dart';
import '../network/network_api_service.dart';

class AuthRepository  {

  final BaseApiServices _apiServices = NetworkApiService() ;


  Future<dynamic> loginApi(dynamic data )async{

    try{

      dynamic response = await _apiServices.getPostApiResponse(AppUrl.loginEndPint, data);
      return response;

    }catch(e){
      rethrow ;
    }
  }

  Future<dynamic> socialLogin(dynamic data )async{

    try{

      dynamic response = await _apiServices.getPostApiResponse(AppUrl.socialLoginEndPint, data);
      return response;

    }catch(e){
      rethrow ;
    }
  }

  Future<dynamic> signUpApi(dynamic data )async{

    try{

      dynamic response = await _apiServices.getPostApiResponse(AppUrl.registerApiEndPoint, data);
      return response ;


    }catch(e){
      rethrow ;
    }
  }

}