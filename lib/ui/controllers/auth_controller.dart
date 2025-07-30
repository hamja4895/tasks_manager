import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks_manager/data/models/user_model.dart';

class AuthController{
  static UserModel ? userModel;
  static String ? accesToken;

  static const String _userDataKey = "user-data";
  static const String _tokenKey = "token";

  static Future<void> saveUserData(UserModel model, String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_userDataKey, jsonEncode(model.toJson()));
    await sharedPreferences.setString(_tokenKey, token);
    userModel = model;
    accesToken = token;
  }


  static Future<void> updateUserData(UserModel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_userDataKey, jsonEncode(model.toJson()));
    userModel = model;
  }

  static Future<void> getUserData() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userModel = UserModel.fromJson(jsonDecode(sharedPreferences.getString(_userDataKey)!));
    accesToken = sharedPreferences.getString(_tokenKey);

  }

  static Future<bool> isUserLoggedIn() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String ? token = sharedPreferences.getString(_tokenKey);
    if(token != null){
      await getUserData();
      return true ;
    }else{
      return false;
    }

  }

  static Future<void> clearUserData() async{
    SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    userModel=null;
    accesToken=null;
  }

}