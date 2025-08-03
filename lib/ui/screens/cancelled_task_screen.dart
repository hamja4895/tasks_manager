import 'package:flutter/material.dart';

import '../../data/models/task_model.dart';
import '../controllers/cancelled_task_controller.dart';
import '../widgets/centered_cicular_indicator.dart';
import '../widgets/screen_background.dart';
import '../widgets/snack_bar_massage.dart';
import '../widgets/taskSummeryCard.dart';
import 'package:get/get.dart';
class CancelledTaskListScreen extends StatefulWidget {
  const CancelledTaskListScreen({super.key});

  @override
  State<CancelledTaskListScreen> createState() => _CancelledTaskListScreenState();
}

class _CancelledTaskListScreenState extends State<CancelledTaskListScreen> {
  List<TaskModel> _cancelledTaskList=[];
  final CancelledTaskController _cancelledTaskController=CancelledTaskController();

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
                child: GetBuilder(
                  init: _cancelledTaskController,
                  builder: (controller) {
                    return Visibility(
                      visible: controller.inProgress == false,
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
  Future<void> _getCancelledTaskList()async{
    final bool isSuccess = await _cancelledTaskController.getCancelledTaskList();
    if(isSuccess){
      _cancelledTaskList=_cancelledTaskController.cancelledTaskList;
    }else{
      if(mounted){
        showSnackBarMassage(context, _cancelledTaskController.errorMassage!);
      }

    }
  }
}



