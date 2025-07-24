import 'package:flutter/material.dart';
import 'package:tasks_manager/data/service/network_caller.dart';
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
  List<TaskModel> _newTaskList=[];

  @override
  void initState() {
    super.initState();
    _getNewTaskList();
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
                child: ListView.separated(
                    itemCount: 4,
                  scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                      return TaskCountSummeryCard(count: 12, tittle: 'Progress');
                    },
                    separatorBuilder: (context, index)=> const SizedBox(width: 10,),

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
      showSnackBarMassage(context, response.errorMassage!);

    }
    _getNewTaskListInProgress=false;
    setState(() {});
  }

  void _onTapAddButton(){
    Navigator.pushNamed(context, AddNewTaskScreen.name);

  }
}



