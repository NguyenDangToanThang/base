
import 'dart:convert';
import 'dart:io';

import 'package:base/data/app_exceptions.dart';
import 'package:base/data/network/base_api_services.dart';
import 'package:http/http.dart';

class NetworkApiServices extends BaseApiServices {

  final headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept-Charset': 'UTF-8',
  };

  @override
  Future getDeleteApiResponse(String url, data) async {
    dynamic responseJson;
    try {
      Response response = await delete(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: headers,
      ).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("Mất kết nối");
    }
    return responseJson;
  }

  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response = await get(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("Mất kết nối");
    }
    return responseJson;
  }

  @override
  Future getMultipartApiResponse(String url, File image) {
    throw UnimplementedError();
  }

  @override
  Future getPostApiResponse(String url, data) async {
    dynamic responseJson;
    try {
      Response response = await post(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: headers,
      ).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("Mất kết nối");
    }
    return responseJson;
  }

  @override
  Future getPutApiResponse(String url, data) async {
    dynamic responseJson;
    try {
      Response response = await put(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: headers,
      ).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("Mất kết nối");
    }
    return responseJson;
  }

  dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        if (response.body.isNotEmpty) {
          dynamic responseJson = jsonDecode(utf8.decode(response.bodyBytes));
          return responseJson;
        }
      case 400:
        throw BadRequestException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException(
            "Lỗi khi liên lạc với máy chủ bằng mã trạng thái: ${response.statusCode}");
    }
  }

}