import 'package:flutter/material.dart';

import '../../data/models/task_model.dart';
import '../../data/service/network_caller.dart';
import '../../data/urls.dart';
import '../widgets/centered_cicular_indicator.dart';
import '../widgets/screen_background.dart';
import '../widgets/snack_bar_massage.dart';
import '../widgets/taskSummeryCard.dart';



class ProgressTaskListScreen extends StatefulWidget {
  const ProgressTaskListScreen({super.key});

  @override
  State<ProgressTaskListScreen> createState() => _ProgressTaskListScreenState();
}

class _ProgressTaskListScreenState extends State<ProgressTaskListScreen> {
  bool _getProgressTaskListInProgress=false;
  List<TaskModel> _progressTaskList=[];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _getProgressTaskList();
    });
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
                  visible: _getProgressTaskListInProgress == false,
                  replacement: CenteredCircularIndicator(),
                  child: ListView.builder(
                      itemCount: _progressTaskList.length,
                      itemBuilder: (context,index){
                        return TaskSummeryCard(
                          taskType: TaskType.Progress,
                          taskModel: _progressTaskList[index],
                          onStatusChanged: () {
                            _getProgressTaskList();
                          },
                        );
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
  Future<void> _getProgressTaskList()async{
    _getProgressTaskListInProgress=true;
    setState(() {});
    NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.getProgressTaskListUrl
    );
    if(response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.body!["data"]) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _progressTaskList = list;
    }else{
      if(mounted){
        showSnackBarMassage(context, response.errorMassage!);
      }
    }
    _getProgressTaskListInProgress=false;
    if(mounted){
      setState(() {});
    }
  }
}



