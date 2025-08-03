import 'package:get/get.dart';

import '../../data/service/network_caller.dart';
import '../../data/urls.dart';

class SignUpController extends GetxController{
  bool _inProgress=false;
  String? _errorMassage;
  bool get inProgress => _inProgress;
  String? get errorMassage => _errorMassage;
  Future<bool> signUp(String email,String firstName,String lastName,String mobile,String password) async{
    bool isSuccess = false;
    _inProgress = true;
    update();
    Map<String,String> requestBody= {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password,
    };
    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.registrationUrl,
      body: requestBody,
    );

    if(response.isSuccess){
      isSuccess = true;
      _errorMassage = null;
    }else{
      _errorMassage = response.errorMassage!;

    }
    _inProgress = false;
    update();
    return isSuccess;

  }
}