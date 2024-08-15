import 'dart:io';

abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(String url);
  Future<dynamic> getPostApiResponse(String url, dynamic data);
  Future<dynamic> getMultipartApiResponse(String url, File image);
  Future<dynamic> getPutApiResponse(String url, dynamic data);
  Future<dynamic> getDeleteApiResponse(String url, dynamic data);
}
