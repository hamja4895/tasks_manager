


import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';


class NetworkResponse{
  final bool isSuccess;
  final int statusCode;
  final Map<String,dynamic>? body;
  final String ? errorMassage;

  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.body,
    this.errorMassage,
});
}

class NetworkCaller{

  static const defaultErrorMassage="Something went wrong";

  static Future<NetworkResponse> getRequest({required String url}) async{
    try{
      Uri uri = Uri.parse(url);
      _logRequest(url, null);
      Response response = await get(uri);
      _logResponse(url, response);
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          body: decodedJson,
        );
      } else {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMassage: decodedJson["data"] ?? defaultErrorMassage,
        );
      }
    }catch(e){
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMassage: e.toString(),
      );
    }
  }
  static Future<NetworkResponse> postRequest({required String url,required Map<String,String>? body}) async{
    try{
      Uri uri = Uri.parse(url);
      _logRequest(url, body);
      Response response = await post(
          uri,
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode(body));
      _logResponse(url, response);
      if (response.statusCode == 200) {
        final decodedJson = json.decode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          body: decodedJson,
        );
      } else {
        final decodedJson = json.decode(response.body);
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMassage: decodedJson["data"] ?? defaultErrorMassage,
        );
      }
    }catch(e){
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMassage: e.toString(),
      );
    }

  }
  static void _logRequest(String url, Map<String,String>? body){
    debugPrint(
        "=============== REQUEST ===================\n"
            "URL:$url\n"
            "BODY:$body\n"
            "=================================="
    );

  }
  static void _logResponse(String url, Response response){
    debugPrint(
        "================ RESPONSE ==================\n"
            "URL:$url\n"
            "STATUS_CODE:${response.statusCode}\n"
            "body:${response.body}\n"
            "=================================="
    );

  }
}