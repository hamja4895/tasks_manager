import 'package:flutter/material.dart';
class TaskCountSummeryCard extends StatelessWidget {
  const TaskCountSummeryCard({
    super.key, required this.count, required this.tittle,
  });
  final int count;
  final String tittle;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
        ),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            width: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("$count",style: Theme.of(context).textTheme.titleLarge,),
                Text(tittle,maxLines: 1,style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),),
              ],
            ),
          ),
        )
    );
  }
}