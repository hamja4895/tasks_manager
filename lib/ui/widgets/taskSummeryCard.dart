import 'package:flutter/material.dart';
import 'package:tasks_manager/data/models/task_model.dart';
import 'package:tasks_manager/data/service/network_caller.dart';
import 'package:tasks_manager/data/urls.dart';
import 'package:tasks_manager/ui/widgets/snack_bar_massage.dart';

import 'centered_cicular_indicator.dart';

enum TaskType{
  Newtask,
  Completed,
  Cancelled,
  Progress,

}
class TaskSummeryCard extends StatefulWidget {
  final TaskType taskType;
  final TaskModel  taskModel;
  final VoidCallback onStatusChanged;

  const TaskSummeryCard({
    super.key, required this.taskType, required this.taskModel, required this.onStatusChanged,
  });

  @override
  State<TaskSummeryCard> createState() => _TaskSummeryCardState();
}

class _TaskSummeryCardState extends State<TaskSummeryCard> {
  bool _getEditTaskStatusInProgress=false;
  bool _deleteTaskInProgress=false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.taskModel.title,style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 23),),
            Text(widget.taskModel.description,style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey),),
            SizedBox(height: 10,),
            Text("Date: ${widget.taskModel.createdDate}",style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey),),
            SizedBox(height: 10,),
            Row(
              children: [
                Chip(
                  label: Padding(
                      padding: const EdgeInsets.only(left: 25,right: 25,top: 0,bottom: 0),
                      child: Text(_getLebelName())
                  ),
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: _getChipColor(),
                ),
                Spacer(),
                Visibility(
                  visible: _getEditTaskStatusInProgress == false,
                  replacement: CenteredCircularIndicator(),
                  child: IconButton(
                      onPressed: (){
                        _showEditTaskStatusDialog();
                      },
                      icon: Icon(Icons.edit,color: Colors.green,)
                  ),
                ),
                Visibility(
                  visible: _deleteTaskInProgress == false,
                  replacement: CenteredCircularIndicator(),
                  child: IconButton(
                      onPressed: (){
                        _showDeleteDialog();
                      },
                      icon: Icon(Icons.delete,color: Colors.red,)
                  ),
                ),

              ],
            )
          ],
        ),
      ),

    );
  }

  Color _getChipColor(){
    switch(widget.taskType){
      case TaskType.Newtask:
        return Colors.blue;
      case TaskType.Completed:
        return Colors.green;
      case TaskType.Cancelled:
        return Colors.red;
      case TaskType.Progress:
        return Colors.purple;
    }
  }

  String _getLebelName(){
    switch(widget.taskType){
      case TaskType.Newtask:
        return "New";
      case TaskType.Completed:
        return "Completed";
      case TaskType.Cancelled:
        return "Cancelled";
      case TaskType.Progress:
        return "Progress";
    }
  }
  void _showEditTaskStatusDialog(){
    showDialog(context: context, builder: (cxt){
      return AlertDialog(
        title: Text("Edit Task Status",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text("New"),
              trailing: _getTaskStatusTrailing(TaskType.Newtask),
              onTap: (){
                if(widget.taskType == TaskType.Newtask){
                  return;
                }
                _editTaskStatusTo("New");
              },
            ),
            ListTile(
              title: Text("Progress"),
              trailing: _getTaskStatusTrailing(TaskType.Progress),
              onTap: (){
                if(widget.taskType == TaskType.Progress){
                  return;
                }
                _editTaskStatusTo("Progress");
              },
            ),
            ListTile(
              title: Text("Completed"),
              trailing: _getTaskStatusTrailing(TaskType.Completed),
              onTap: (){
                if(widget.taskType == TaskType.Completed){
                  return;
                }
                _editTaskStatusTo("Completed");
              },
            ),
            ListTile(
              title: Text("Cancel"),
              trailing: _getTaskStatusTrailing(TaskType.Cancelled),
              onTap: (){
                if(widget.taskType == TaskType.Cancelled){
                  return;
                }
                _editTaskStatusTo("Cancelled");
              }

            ),
          ],
        ),




      );
    });
  }
  void _showDeleteDialog(){
    showDialog(context: context, builder: (cxt){
      return AlertDialog(
        title: Text("Delete Task",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Text("Are you sure you want to delete this task?",
        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.red),
        ),
        actions: [
          TextButton(
          onPressed: (){
            Navigator.pop(context);
          }, child: Text("Cancel",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.blue,fontSize: 25),
          ),
          ),

          TextButton(
          onPressed: (){

          },
              child: Text("Delete",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.red,fontSize: 25),
              ),
          )
        ]
      );
    });

  }
  Widget ? _getTaskStatusTrailing(TaskType type){
    return  widget.taskType == type ? Icon(Icons.check,color: Colors.green,) : null;

  }

  Future<void> _editTaskStatusTo(String status) async{
    Navigator.pop(context);
    _getEditTaskStatusInProgress=true;
    if(mounted){
      setState(() {});
    }

    NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.editTaskStatusUrl(widget.taskModel.id, status),
    );
    if(response.isSuccess){
      widget.onStatusChanged();
      if(mounted){
        showSnackBarMassage(context, "Task Status Updated to $status Successfully");
      }

    }else{
      if(mounted){
        showSnackBarMassage(context, response.errorMassage!);
      }
    }
    _getEditTaskStatusInProgress=false;
    if(mounted){
      setState(() {});
    }

  }
  Future<void> _deleteTask() async{
    Navigator.pop(context);
    _deleteTaskInProgress=true;
    if(mounted){
      setState(() {});
    }

  }


}
