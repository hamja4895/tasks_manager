import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasks_manager/data/models/user_model.dart';
import 'package:tasks_manager/data/service/network_caller.dart';
import 'package:tasks_manager/data/urls.dart';
import 'package:tasks_manager/ui/widgets/tm_appbar.dart';
import '../controllers/auth_controller.dart';
import '../widgets/centered_cicular_indicator.dart';
import '../widgets/screen_background.dart';
import '../widgets/snack_bar_massage.dart';


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
  bool _updateProfileProgress=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController.text=AuthController.userModel!.email;
    _firstNameController.text=AuthController.userModel!.firstName;
    _lastNameController.text=AuthController.userModel!.lastName;
    _mobileController.text=AuthController.userModel!.mobile;
  }


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
                      enabled: false,

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
                        int length = value?.length ?? 0;
                        if(length >0 && length <=6){
                          return "Please Enter a valid password";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16,),

                    SizedBox(
                      height: 40,
                      child: Visibility(
                        visible: _updateProfileProgress == false,
                        replacement: CenteredCircularIndicator(),

                        child: ElevatedButton(
                            onPressed: _onTapUpdateProfileButton,
                            child: Icon(Icons.arrow_circle_right_outlined,size: 30,)
                        ),
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
                          Expanded(
                            child: Text(_selectedImage == null ? "select Image" : _selectedImage!.name,
                              maxLines: 1,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                              ),
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
      _postUpdateDProfile();
    }

  }

  Future<void> _postUpdateDProfile() async{
    _updateProfileProgress = true;
    if(mounted){
      setState(() {});
    }
    Uint8List ? imageBytes;
    Map<String,String> requestBody={
      "email": _emailController.text.trim(),
      "firstName": _firstNameController.text.trim(),
      "lastName": _lastNameController.text.trim(),
      "mobile": _mobileController.text.trim(),
    };
    if(_passwordController.text.isNotEmpty){
      requestBody["password"] = _passwordController.text;
    }
    if(_selectedImage != null){
      imageBytes = await _selectedImage!.readAsBytes();
      requestBody["photo"] = base64Encode(imageBytes);
    }
    NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.updateProfileUrl,
        body: requestBody,
    );
    if(response.isSuccess){
      UserModel updatedUserModel=UserModel(
          id: AuthController.userModel!.id,
          email: _emailController.text.trim(),
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          mobile: _mobileController.text.trim(),
          photo: imageBytes == null ? AuthController.userModel?.photo : base64Encode(imageBytes),

      );
      await AuthController.updateUserData(updatedUserModel);
      _passwordController.clear();
      if(mounted){
        showSnackBarMassage(context, "Profile Updated Successfully");
      }

    }
    else{
      if(mounted){
        showSnackBarMassage(context, response.errorMassage!);
      }
    }

    _updateProfileProgress = false;
    if(mounted){
      setState(() {});
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
