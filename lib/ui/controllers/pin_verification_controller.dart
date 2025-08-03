import 'package:get/get.dart';
import '../../data/service/network_caller.dart';
import '../../data/urls.dart';

class PinVerificationController extends GetxController{
  bool _inProgress=false;
  String? errorMassage;
  bool get inProgress => _inProgress;
  String? get errorMessage => errorMassage;

  Future<bool> verifyOtp(String email,String otp)async{
    bool isSuccess=false;
    _inProgress=true;
    update();
    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.verifyOTPUrl(email, otp),
    );
    if(response.isSuccess){
      isSuccess=true;
      errorMassage=null;
    }
    else{
      errorMassage=response.errorMassage!;
    }
    _inProgress=false;
    update();
    return isSuccess;


  }
}