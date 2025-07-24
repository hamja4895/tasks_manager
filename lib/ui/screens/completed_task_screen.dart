import 'package:flutter/material.dart';

import '../../data/models/task_model.dart';
import '../../data/service/network_caller.dart';
import '../../data/urls.dart';
import '../widgets/centered_cicular_indicator.dart';
import '../widgets/screen_background.dart';
import '../widgets/snack_bar_massage.dart';
import '../widgets/taskSummeryCard.dart';
class CompletedTaskListScreen extends StatefulWidget {
  const CompletedTaskListScreen({super.key});

  @override
  State<CompletedTaskListScreen> createState() => _CompletedTaskListScreenState();
}

class _CompletedTaskListScreenState extends State<CompletedTaskListScreen> {
  bool _getCompletedTaskListInProgress=false;
  List<TaskModel> _completedTaskList=[];

  @override
  void initState() {
    super.initState();
    _getCompletedTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Expanded(
                child: Visibility(
                  visible: _getCompletedTaskListInProgress == false,
                  replacement: CenteredCircularIndicator(),
                  child: ListView.builder(
                      itemCount: _completedTaskList.length,
                      itemBuilder: (context,index){
                        return TaskSummeryCard(
                          taskType: TaskType.Completed,
                          taskModel: _completedTaskList[index],);
                      }
                  ),
                ),
              )
            ],
          ),
        ),
      ),

    );
  }
  Future<void> _getCompletedTaskList()async{
    _getCompletedTaskListInProgress=true;
    setState(() {});
    NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.getCompletedTaskListUrl
    );
    if(response.isSuccess){
      List<TaskModel> list=[];
      for(Map<String,dynamic> jsonData in response.body!["data"]){
        list.add(TaskModel.fromJson(jsonData));
      }
      _completedTaskList=list;

    }else{
      showSnackBarMassage(context, response.errorMassage!);
    }
    _getCompletedTaskListInProgress=false;
    setState(() {});
  }
}



