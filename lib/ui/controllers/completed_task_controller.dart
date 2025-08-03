import 'package:get/get.dart';

import '../../data/models/task_model.dart';
import '../../data/service/network_caller.dart';
import '../../data/urls.dart';

class CompletedTaskController extends GetxController{
  bool _inProgress=false;
  String? _errorMassage;
  List<TaskModel> _completedTaskList=[];
  bool get inProgress => _inProgress;
  String? get errorMassage => _errorMassage;
  List<TaskModel> get completedTaskList => _completedTaskList;
  Future<bool> getCompletedTaskList()async{
    bool isSuccess = false;
    _inProgress=true;
    update();
    NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.getCompletedTaskListUrl
    );
    if(response.isSuccess){
      List<TaskModel> list=[];
      for(Map<String,dynamic> jsonData in response.body!["data"]){
        list.add(TaskModel.fromJson(jsonData));
      }
      _completedTaskList=list;
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