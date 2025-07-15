import 'package:flutter/material.dart';

import '../widgets/screen_background.dart';
import '../widgets/taskSummeryCard.dart';
class CancelledTaskListScreen extends StatelessWidget {
  const CancelledTaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: 100,
                    itemBuilder: (context,index){
                      return TaskSummeryCard(taskType: TaskType.Cancelled,);
                    }
                ),
              )
            ],
          ),
        ),
      ),

    );
  }
}



