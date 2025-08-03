import 'package:get/get.dart';

import '../../data/service/network_caller.dart';
import '../../data/urls.dart';

class AddNewTaskController extends GetxController{
  bool _inProgress=false;
  String? _errorMassage;
  bool get inProgress => _inProgress;
  String? get errorMassage => _errorMassage;
  Future<bool> addNewTask(String subject,String description) async{
    bool isSuccess = false;
    _inProgress = true;
    update();
    Map<String,String> requestBody={
      "title": subject,
      "description": description,
      "status": "New"
    };
    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.createNewTaskUrl,
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