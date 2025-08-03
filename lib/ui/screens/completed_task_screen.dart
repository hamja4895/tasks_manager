import 'package:flutter/material.dart';

import '../../data/models/task_model.dart';
import '../controllers/completed_task_controller.dart';
import '../widgets/centered_cicular_indicator.dart';
import '../widgets/screen_background.dart';
import '../widgets/snack_bar_massage.dart';
import '../widgets/taskSummeryCard.dart';
import 'package:get/get.dart';
class CompletedTaskListScreen extends StatefulWidget {
  const CompletedTaskListScreen({super.key});

  @override
  State<CompletedTaskListScreen> createState() => _CompletedTaskListScreenState();
}

class _CompletedTaskListScreenState extends State<CompletedTaskListScreen> {
  List<TaskModel> _completedTaskList=[];
  final CompletedTaskController _completedTaskController=CompletedTaskController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _getCompletedTaskList();
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
                  init: _completedTaskController,
                  builder: (controller) {
                    return Visibility(
                      visible: controller.inProgress == false,
                      replacement: CenteredCircularIndicator(),
                      child: ListView.builder(
                          itemCount: _completedTaskList.length,
                          itemBuilder: (context,index){
                            return TaskSummeryCard(
                              taskType: TaskType.Completed,
                              taskModel: _completedTaskList[index],
                              onStatusChanged: () {
                                _getCompletedTaskList();
                              },);
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
  Future<void> _getCompletedTaskList()async{
    final bool isSuccess = await _completedTaskController.getCompletedTaskList();

    if(isSuccess){
      _completedTaskList=_completedTaskController.completedTaskList;
    }else{
      if(mounted){
        showSnackBarMassage(context, _completedTaskController.errorMassage!);
      }
    }
  }
}



