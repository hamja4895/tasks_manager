import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/taskStatusCount_model.dart';
import '../../data/models/task_model.dart';
import '../controllers/get_tast_status_count_controller.dart';
import '../controllers/new_task_task_list_controller.dart';
import '../widgets/centered_cicular_indicator.dart';
import '../widgets/screen_background.dart';
import '../widgets/snack_bar_massage.dart';
import '../widgets/taskCountSummeryCard.dart';
import '../widgets/taskSummeryCard.dart';
import 'add_new_task_screen.dart';



class NewTaskListScreen extends StatefulWidget {
  const NewTaskListScreen({super.key});

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {
  List<TaskModel> _newTaskList=[];
  List<TaskStatusCountModel> _taskStatusCountList=[];
  final NewTaskListController _newTaskListController=NewTaskListController();
  final TaskStatusCountController _taskStatusCountController=TaskStatusCountController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _getNewTaskList();
      _geTaskStatusCountList();
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
              SizedBox(
                height: 90,
                child: GetBuilder(
                  init: _taskStatusCountController,
                  builder: (control) {
                    return Visibility(
                      visible: control.inProgress == false,
                      replacement: CenteredCircularIndicator(),
                      child: ListView.separated(
                          itemCount: _taskStatusCountList.length,
                        scrollDirection: Axis.horizontal,
                          itemBuilder: (context,index){
                            return TaskCountSummeryCard(count: _taskStatusCountList[index].count, tittle: _taskStatusCountList[index].id);
                          },
                          separatorBuilder: (context, index)=> const SizedBox(width: 10,),

                      ),
                    );
                  }
                ),

              ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Expanded(child: TaskCountSummeryCard(count: 12, tittle: 'Cancelled',)),
              //
              //     Expanded(child: TaskCountSummeryCard(count: 12, tittle: 'Completed',)),
              //
              //     Expanded(child: TaskCountSummeryCard(count: 12, tittle: 'Progress',)),
              //
              //     Expanded(child: TaskCountSummeryCard(count: 12, tittle: 'New Task',))
              //
              //   ],
              // ),
              SizedBox(height: 5,),
              Divider(thickness: 2,),
              SizedBox(height: 5),
              Expanded(
                child: GetBuilder(
                  init: _newTaskListController,
                  builder: (control) {
                    return Visibility(
                      visible: control.inProgress == false,
                      replacement: CenteredCircularIndicator(),
                      child: ListView.builder(
                        itemCount: _newTaskList.length,
                          itemBuilder: (context,index){
                          return TaskSummeryCard(
                            taskType: TaskType.Newtask,
                            taskModel: _newTaskList[index],
                            onStatusChanged: () {
                              _getNewTaskList();
                              _geTaskStatusCountList();
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
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapAddButton,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
        ),
        child: Icon(Icons.add,size: 35,),
      ),

    );
  }
  Future<void> _getNewTaskList()async{
    final bool isSuccess = await _newTaskListController.getNewTaskList();
    if(isSuccess){
      _newTaskList=_newTaskListController.newTaskList;

    }else{
      if(mounted){
        showSnackBarMassage(context, _newTaskListController.errorMassage!);
      }
    }

  }
  Future<void> _geTaskStatusCountList()async{
    final bool isSuccess = await _taskStatusCountController.geTaskStatusCountList();
    if(isSuccess){
      _taskStatusCountList=_taskStatusCountController.taskStatusCountList;

    }else{
      if(mounted){
        showSnackBarMassage(context, _taskStatusCountController.errorMassage!);
      }
    }

  }

  void _onTapAddButton(){
    // Navigator.pushNamed(context, AddNewTaskScreen.name).then((_){
    //   _getNewTaskList();
    //   _geTaskStatusCountList();
    // });
    Get.toNamed(AddNewTaskScreen.name)?.then((_){
      _getNewTaskList();
      _geTaskStatusCountList();
    });

  }
}



