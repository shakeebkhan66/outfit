
import 'dart:io';
import 'package:outfit/src/data/api_key.dart';
import 'package:outfit/src/data/app_exception.dart';
import 'package:outfit/src/data/network/base_api_service.dart';
import 'package:dio/dio.dart';
import 'package:outfit/src/data/network/network_exceptions.dart';

class NetworkApiService extends BaseApiServices {
  var dio = Dio(
    BaseOptions(
      headers: {
        'X-API-KEY': apiKey,
        "Accept": "application/json"
      },
    ),
  );
  @override
  Future getGetApiResponse(String url,{Map<String, dynamic>? queryParameters}) async {
    print(queryParameters);
    dynamic responseJson ;
    try {
      final response = await dio.get(url,
      queryParameters: queryParameters,
      ).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    }on SocketException {
      throw FetchDataException('No Internet Connection');
    }on Exception catch(ex){
      throw NetworkException.getDioException(ex).message;
    }
    return responseJson;

  }


  @override
  Future getPostApiResponse(String url , dynamic data,{Map<String, dynamic>? queryParameters}) async{
    print(url);
    print(data);
    print(apiKey);
    dynamic responseJson;
    try {
      Response response = await dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
      ).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    }on SocketException {
      throw FetchDataException('No Internet Connection');
    }on DioError catch (ex){
      throw Exception(ex.response!.data!['message']);
    }

    return responseJson;
  }

  dynamic returnResponse (Response response){
    print(response.data);
    switch(response.statusCode){
      case 200:
        dynamic responseJson = response.data;
        return responseJson;
      case 201:
        dynamic responseJson = response.data;
        return responseJson;
      case 401:
        dynamic responseJson = response.data;
        return responseJson;
      case 400:
        throw BadRequestException(response.data.toString());
      case 500:
      case 404:
        throw UnauthorisedException(response.data.toString());
      default:
        throw FetchDataException('Error accured while communicating with serverwith status code${response.statusCode}');

    }
  }
  
  @override
  Future getPutApiResponse(String url, {dynamic data}) async{
    print(url);
    print(data);
    print(apiKey);
    dynamic responseJson;
    try {
      Response response = await dio.put(
        url,
        data: data,
      ).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    }on SocketException {
      throw FetchDataException('No Internet Connection');
    }on DioError catch (ex){
      throw Exception(ex.response!.data!['message']);
    }
    return responseJson;
  }

}