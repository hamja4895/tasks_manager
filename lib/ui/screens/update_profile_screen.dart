import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasks_manager/ui/widgets/tm_appbar.dart';

import '../widgets/screen_background.dart';
class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  static const String name='/update_profile';

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();
  final TextEditingController _firstNameController=TextEditingController();
  final TextEditingController _lastNameController=TextEditingController();
  final TextEditingController _mobileController=TextEditingController();
  final GlobalKey<FormState> _formKey= GlobalKey<FormState>();
  final ImagePicker _imagePicker=ImagePicker();
  XFile ? _selectedImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TM_AppBar(),
      body: ScreenBackground (
          child:
          SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsets.only(right: 30.0,left: 40.0,top: 70.0),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Update Profile",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    SizedBox(height: 24,),
                    _dealPhotoPicker(),
                    SizedBox(height: 24,),
                    TextFormField(
                      controller: _emailController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: "Email",
                      ),
                      validator: (String ? value){
                        String email= value ?? "";
                        if(EmailValidator.validate(email)==false){
                          return "Please Enter a valid email";

                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16,),
                    TextFormField(
                      controller: _firstNameController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          hintText: "First Name"
                      ),
                      validator: (String ? value){
                        if(value?.trim().isEmpty ?? true){
                          return "Please Enter first name";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16,),
                    TextFormField(
                      controller: _lastNameController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          hintText: "Last Name"
                      ),
                      validator: (String ? value){
                        if(value?.trim().isEmpty ?? true){
                          return "Please Enter last name";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16,),
                    TextFormField(
                      controller: _mobileController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          hintText: "Mobile"
                      ),
                      validator: (String ? value){
                        if(value?.trim().isEmpty ?? true){
                          return "Please Enter Number";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16,),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Password",
                      ),
                      validator: (String ? value){
                        if((value?.length ?? 0)<=6){
                          return "Please Enter a valid password";

                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16,),

                    SizedBox(
                      height: 40,
                      child: ElevatedButton(

                          onPressed: _onTapUpdateProfileButton,
                          child: Icon(Icons.arrow_circle_right_outlined,size: 30,)
                      ),
                    ),

                  ],
                ),
              ),
            ),
          )),
    );
  }

  Widget _dealPhotoPicker() {
    return GestureDetector(
      onTap: _onTapPhotoPicker,
      child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),

                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 50,
                            width:100,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade700,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                            ),
                            alignment: Alignment.center,
                            child: Text("Photos",style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),),
                          ),
                          SizedBox(width: 8,),
                          Text(_selectedImage == null ? "select Image" : _selectedImage!.name,
                            maxLines: 1,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),


                        ],
                      ),

                    ),
    );
  }

  Future<void> _onTapPhotoPicker() async {
    final XFile ? pickedImage = await _imagePicker.pickImage(source: ImageSource.gallery);
    if(pickedImage !=null){
      _selectedImage = pickedImage;
      setState(() {});
    }
  }

  void _onTapUpdateProfileButton(){
    if(_formKey.currentState!.validate()){
      //TODO Update Profile with API
    }

  }


  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

}
