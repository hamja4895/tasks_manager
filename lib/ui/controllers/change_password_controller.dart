import 'package:get/get.dart';

import '../../data/service/network_caller.dart';
import '../../data/urls.dart';
class ChangePasswordController extends GetxController{
  bool _inProgress=false;
  String? _errorMassage;
  bool get inProgress => _inProgress;
  String? get errorMassage => _errorMassage;

  Future<bool> postChangePassword(String email,String otp,String password)async{
    bool isSuccess=false;
    _inProgress=true;
    update();
    Map<String,String> requestBody={
      "email": email,
      "OTP": otp,
      "password": password
    };
    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.changePasswordUrl,
      body: requestBody,
    );
    if(response.isSuccess){
      isSuccess=true;
      _errorMassage=null;
    }else{
      _errorMassage=response.errorMassage!;
    }
    _inProgress=false;
    update();
    return isSuccess;



  }

}