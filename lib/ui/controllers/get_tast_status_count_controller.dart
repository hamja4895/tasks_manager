import 'package:get/get.dart';

import '../../data/models/taskStatusCount_model.dart';
import '../../data/service/network_caller.dart';
import '../../data/urls.dart';
class TaskStatusCountController extends GetxController{
  bool _inProgress=false;
  String? _errorMassage;
  List<TaskStatusCountModel> _taskStatusCountList=[];
  bool get inProgress => _inProgress;
  String? get errorMassage => _errorMassage;
  List<TaskStatusCountModel> get taskStatusCountList => _taskStatusCountList;

  Future<bool> geTaskStatusCountList()async{
    bool isSuccess = false;
    _inProgress=true;
    update();
    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.getTaskStatusCountListUrl,
    );

    if(response.isSuccess){
      List<TaskStatusCountModel> list=[];
      for(Map<String,dynamic> jsonData in response.body!["data"]){
        list.add(TaskStatusCountModel.fromJson(jsonData));
      }
      _taskStatusCountList=list;
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