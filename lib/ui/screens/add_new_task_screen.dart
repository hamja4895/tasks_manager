import 'package:flutter/material.dart';

import '../widgets/screen_background.dart';
import '../widgets/tm_appbar.dart';
class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});
  static const String name = "/add_new_task";

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _subjectController=TextEditingController();
  final TextEditingController _descriptionController=TextEditingController();
  final GlobalKey<FormState> _formKey= GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TM_AppBar(),
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.only(right: 20,left: 20,top: 70),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Add New Task" ,
                style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 24,),
                TextFormField(
                  controller: _subjectController,
                  textInputAction: TextInputAction.next,
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: "Subject",
                  ),
                  validator: (String ? value){
                    if(value?.trim().isEmpty ?? true){
                      return "Please Enter a subject/tittle";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16,),
                TextFormField(
                  maxLines: 10,
                  controller: _descriptionController,

                  decoration: InputDecoration(
                    hintText: "Description",

                  ),
                  validator: (String ? value){
                    if(value?.trim().isEmpty ?? true){
                      return "Please write a Description";
                    }
                    return null;
                  },


                ),
                SizedBox(height: 16,),
                SizedBox(
                  height: 40,
                  child: ElevatedButton(

                      onPressed: _onTapAddTaskButton,
                      child: Icon(Icons.arrow_circle_right_outlined,size: 30,)
                  ),
                ),


              ],
            ),
          ),
        ),),
    );
  }
  void _onTapAddTaskButton(){
    if(_formKey.currentState!.validate()){
      //TODO Add task with API
    }
    Navigator.pop(context);

  }
  @override
  void dispose() {
    _subjectController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
