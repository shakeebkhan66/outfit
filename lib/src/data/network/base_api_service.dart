abstract class BaseApiServices {

  Future<dynamic> getGetApiResponse(String url,{Map<String, dynamic>? queryParameters});

  Future<dynamic> getPostApiResponse(String url , dynamic data,{Map<String, dynamic>? queryParameters});

  Future<dynamic> getPutApiResponse(String url , {dynamic data});

  Future<dynamic> getDeleteApiResponse(String url);

}