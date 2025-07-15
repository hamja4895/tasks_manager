import 'package:flutter/material.dart';

enum TaskType{
  Newtask,
  Completed,
  Cancelled,
  Progress,

}
class TaskSummeryCard extends StatelessWidget {
  final TaskType taskType;

  const TaskSummeryCard({
    super.key, required this.taskType,
  });

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
            Text("Tittle will be here",style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 23),),
            Text("Description will be here",style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey),),
            SizedBox(height: 10,),
            Text("Date: 12/12/2023",style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey),),
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
                IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.edit,color: Colors.green,)
                ),
                IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.delete,color: Colors.red,)
                ),

              ],
            )
          ],
        ),
      ),

    );
  }
  Color _getChipColor(){
    switch(taskType){
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
    switch(taskType){
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

}
