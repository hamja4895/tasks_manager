import 'package:flutter/material.dart';

import '../../data/models/task_model.dart';
import '../controllers/progress_task_controller.dart';
import '../widgets/centered_cicular_indicator.dart';
import '../widgets/screen_background.dart';
import '../widgets/snack_bar_massage.dart';
import '../widgets/taskSummeryCard.dart';
import 'package:get/get.dart';



class ProgressTaskListScreen extends StatefulWidget {
  const ProgressTaskListScreen({super.key});

  @override
  State<ProgressTaskListScreen> createState() => _ProgressTaskListScreenState();
}

class _ProgressTaskListScreenState extends State<ProgressTaskListScreen> {
  List<TaskModel> _progressTaskList=[];
  final ProccessTaskController _proccessTaskController=ProccessTaskController();

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
                child: GetBuilder(
                  init: _proccessTaskController,
                  builder: (control) {
                    return Visibility(
                      visible: control.inProgress== false,
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
                    );
                  }
                ),
              )
            ],
          ),
        ),
      ),

    );
  }
  Future<void> _getProgressTaskList()async{
   final bool isSuccess = await _proccessTaskController.getProgressTaskList();
    if(isSuccess) {
      _progressTaskList = _proccessTaskController.progressTaskList;
    }else{
      if(mounted){
        showSnackBarMassage(context, _proccessTaskController.errorMassage!);
      }
    }
  }
}



