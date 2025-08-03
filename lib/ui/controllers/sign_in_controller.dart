import 'package:get/get.dart';

import '../../data/models/user_model.dart';
import '../../data/service/network_caller.dart';
import '../../data/urls.dart';
import 'auth_controller.dart';

class SignInController extends GetxController{
  bool _inProgress=false;
  String? _errorMassage;
  bool get inProgress => _inProgress;
  String? get errorMassage => _errorMassage;
  Future<bool> signIn(String email,String password) async{
    bool isSuccess = false;
    _inProgress = true;
    update();
    Map<String,String> requestBody={
      "email": email ,
      "password": password ,

    };
    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.loginUrl,
      body: requestBody,
      isFromLogin: true,
    );
    if(response.isSuccess){
      UserModel userModel = UserModel.fromJson(response.body!["data"]);
      String token = response.body!["token"];
      await AuthController.saveUserData(userModel, token);
      _inProgress = true;
      _errorMassage = null;

    }else{
      _errorMassage = response.errorMassage!;
    }
    _inProgress = false;
    update();
    return isSuccess;

  }
}