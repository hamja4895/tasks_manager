import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import '../../app.dart';
import '../../ui/controllers/auth_controller.dart';
import 'package:tasks_manager/ui/screens/signin_screen.dart';


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

  static const _defaultErrorMassage="Something went wrong";
  static const String _unAuthorizedErrorMassage="UnAuthorized token";

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
      }
      else if(response.statusCode == 401){
        _onUnAuthorize();
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMassage: _unAuthorizedErrorMassage,
        );
      }
      else {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMassage: decodedJson["data"] ?? _defaultErrorMassage,
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
  static Future<NetworkResponse> postRequest({required String url, Map<String,String>? body,bool isFromLogin=false}) async{
    try{
      Uri uri = Uri.parse(url);
      _logRequest(url, body);
      Response response = await post(
          uri,
          headers: {
            "Content-Type": "application/json",
            "token": AuthController.accesToken ??"",
          },
          body: jsonEncode(body));
      _logResponse(url, response);
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          body: decodedJson,
        );
      }
      else if(response.statusCode == 401){
        if(isFromLogin){
          _onUnAuthorize();
        }
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
      else {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMassage: decodedJson["data"] ?? _defaultErrorMassage,
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
  static Future<void> _onUnAuthorize() async{
    await AuthController.clearUserData();
    Navigator.pushNamedAndRemoveUntil(
        TaskManagerApp.navigator.currentContext!, SignInScreen.name, (predicate) => false);

  }
}