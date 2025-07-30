import 'package:flutter/material.dart';
import 'package:tasks_manager/data/service/network_caller.dart';
import '../../data/models/taskStatusCount_model.dart';
import '../../data/models/task_model.dart';
import '../../data/urls.dart';
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
  bool _getNewTaskListInProgress=false;
  bool _getTaskStatusCountListInProgress=false;
  List<TaskModel> _newTaskList=[];
  List<TaskStatusCountModel> _taskStatusCountList=[];

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
                child: Visibility(
                  visible: _getTaskStatusCountListInProgress == false,
                  replacement: CenteredCircularIndicator(),
                  child: ListView.separated(
                      itemCount: _taskStatusCountList.length,
                    scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index){
                        return TaskCountSummeryCard(count: _taskStatusCountList[index].count, tittle: _taskStatusCountList[index].id);
                      },
                      separatorBuilder: (context, index)=> const SizedBox(width: 10,),

                  ),
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
                child: Visibility(
                  visible: _getNewTaskListInProgress == false,
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
    _getNewTaskListInProgress=true;
    setState(() {});
    NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.getNewTaskListUrl
    );

    if(response.isSuccess){
      List<TaskModel> list=[];
      for(Map<String,dynamic> jsonData in response.body!["data"]){
        list.add(TaskModel.fromJson(jsonData));
      }
      _newTaskList=list;

    }else{
      if(mounted){
        showSnackBarMassage(context, response.errorMassage!);
      }
    }
    _getNewTaskListInProgress=false;
    if(mounted){
      setState(() {});
    }
  }
  Future<void> _geTaskStatusCountList()async{
    _getTaskStatusCountListInProgress=true;
    setState(() {});
    NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.getTaskStatusCountListUrl,
    );

    if(response.isSuccess){
      List<TaskStatusCountModel> list=[];
      for(Map<String,dynamic> jsonData in response.body!["data"]){
        list.add(TaskStatusCountModel.fromJson(jsonData));
      }
      _taskStatusCountList=list;

    }else{
      if(mounted){
        showSnackBarMassage(context, response.errorMassage!);
      }
    }
    _getTaskStatusCountListInProgress=false;
    if(mounted){
      setState(() {});
    }
  }

  void _onTapAddButton(){
    Navigator.pushNamed(context, AddNewTaskScreen.name).then((_){
      _getNewTaskList();
      _geTaskStatusCountList();
    });

  }
}



