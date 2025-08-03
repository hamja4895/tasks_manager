import 'package:get/get.dart';

import '../../data/service/network_caller.dart';
import '../../data/urls.dart';

class ForgotPasswordEmailController extends GetxController{
  bool _inProgress=false;
  String ? errorMassage;
  bool get inProgress=>_inProgress;
  String get getErrorMassage=>errorMassage!;

  Future<bool> getRecoveryEmailVerification(String email)async{
    bool isSuccess=false;
    _inProgress=true;
    update();
    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.recoveryEmailVerificationUrl(email),
    );
    if(response.isSuccess){
      isSuccess=true;
      errorMassage=null;

    }else{
      errorMassage=response.errorMassage!;
    }
    _inProgress=false;
    update();
    return isSuccess;


  }
}