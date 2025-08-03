import 'package:get/get.dart';

import '../../data/models/task_model.dart';
import '../../data/service/network_caller.dart';
import '../../data/urls.dart';

class CancelledTaskController extends GetxController{
  bool _inProgress=false;
  String? _errorMassage;
  List<TaskModel> _cancelledTaskList=[];
  bool get inProgress => _inProgress;
  String? get errorMassage => _errorMassage;
  List<TaskModel> get cancelledTaskList => _cancelledTaskList;
  Future<bool> getCancelledTaskList()async{
    bool isSuccess = false;
    _inProgress=true;
    update();
    NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.getCancelledTaskListUrl
    );
    if(response.isSuccess){
      List<TaskModel> list=[];
      for(Map<String,dynamic> jsonData in response.body!["data"]){
        list.add(TaskModel.fromJson(jsonData));
      }
      _cancelledTaskList=list;
      isSuccess = true;
      _errorMassage = null;
    }else{
      _errorMassage = response.errorMassage!;
    }
    _inProgress=false;
    update();
    return isSuccess;

  }
}