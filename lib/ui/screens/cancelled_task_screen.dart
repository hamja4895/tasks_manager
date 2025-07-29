import 'package:flutter/material.dart';

import '../../data/models/task_model.dart';
import '../../data/service/network_caller.dart';
import '../../data/urls.dart';
import '../widgets/centered_cicular_indicator.dart';
import '../widgets/screen_background.dart';
import '../widgets/snack_bar_massage.dart';
import '../widgets/taskSummeryCard.dart';
class CancelledTaskListScreen extends StatefulWidget {
  const CancelledTaskListScreen({super.key});

  @override
  State<CancelledTaskListScreen> createState() => _CancelledTaskListScreenState();
}

class _CancelledTaskListScreenState extends State<CancelledTaskListScreen> {
  bool _getCancelledTaskListInProgress=false;
  List<TaskModel> _cancelledTaskList=[];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _getCancelledTaskList();
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
                  visible: _getCancelledTaskListInProgress == false,
                  replacement: CenteredCircularIndicator(),
                  child: ListView.builder(
                      itemCount: _cancelledTaskList.length,
                      itemBuilder: (context,index){
                        return TaskSummeryCard(
                          taskType: TaskType.Cancelled,
                          taskModel: _cancelledTaskList[index],
                          onStatusChanged: () {
                            _getCancelledTaskList();
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
  Future<void> _getCancelledTaskList()async{
    _getCancelledTaskListInProgress=true;
    setState(() {});
    NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.getCancelledTaskListUrl
    );
    if(response.isSuccess){
      List<TaskModel> list=[];
      for(Map<String,dynamic> jsonData in response.body!["data"]){
        list.add(TaskModel.fromJson(jsonData));
      }
      _cancelledTaskList=list;
    }else{
      if(mounted){
        showSnackBarMassage(context, response.errorMassage!);
      }

    }
    _getCancelledTaskListInProgress=false;
    if(mounted){
      setState(() {});
    }
  }
}



