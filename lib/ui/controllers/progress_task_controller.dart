import 'package:get/get.dart';

import '../../data/models/task_model.dart';
import '../../data/service/network_caller.dart';
import '../../data/urls.dart';

class ProccessTaskController extends GetxController{
  bool _inProgress=false;
  String? _errorMassage;
  List<TaskModel> _progressTaskList=[];
  bool get inProgress => _inProgress;
  String? get errorMassage => _errorMassage;
  List<TaskModel> get progressTaskList => _progressTaskList;

  Future<bool> getProgressTaskList()async{
    bool isSuccess = false;
    _inProgress=true;
    update();
    NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.getProgressTaskListUrl
    );
    if(response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.body!["data"]) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _progressTaskList = list;
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