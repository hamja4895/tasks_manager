import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_manager/data/service/network_caller.dart';
import 'package:tasks_manager/ui/screens/signin_screen.dart';
import 'package:tasks_manager/ui/widgets/centered_cicular_indicator.dart';
import 'package:tasks_manager/ui/widgets/snack_bar_massage.dart';
import '../../data/urls.dart';
import '../widgets/screen_background.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String name='/signup';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();
  final TextEditingController _firstNameController=TextEditingController();
  final TextEditingController _lastNameController=TextEditingController();
  final TextEditingController _mobileController=TextEditingController();
  final GlobalKey<FormState> _formKey= GlobalKey<FormState>();
  bool _signupInProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground (
          child:
          SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsets.only(right: 30.0,left: 40.0,top: 200.0),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Join With Us",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
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
                      child: Visibility(
                        visible: _signupInProgress == false,
                        replacement: CenteredCircularIndicator(),
                        child: ElevatedButton(

                            onPressed: _onTapSignUpButton,
                            child: Icon(Icons.arrow_circle_right_outlined,size: 30,)
                        ),
                      ),
                    ),
                    SizedBox(height: 100,),
                    RichText(
                        text: TextSpan(
                          text: "Have account? ",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: "Sign in",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                              recognizer: TapGestureRecognizer()..onTap= _onTapSignInButton,
                            )
                          ],

                        )
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  void _onTapSignUpButton(){
    if(_formKey.currentState!.validate()){
      _signUp();
    }

  }

  Future<void> _signUp() async{
    _signupInProgress = true;
    setState(() {});
    Map<String,String> requestBody= {
      "email": _emailController.text.trim(),
      "firstName": _firstNameController.text.trim(),
      "lastName": _lastNameController.text.trim(),
      "mobile": _mobileController.text.trim(),
      "password": _passwordController.text,
    };
    NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.registrationUrl,
        body: requestBody,
    );
    _signupInProgress = false;
    setState(() {});

    if(response.isSuccess){
      _clearTextFields();
      // Navigator.pushNamedAndRemoveUntil(context, SignInScreen.name, (predicate)=>false);
      Get.offAllNamed(SignInScreen.name);
      showSnackBarMassage(context, "Registration Success.Please Login");

    }else{
      showSnackBarMassage(context, response.errorMassage!);

    }

  }

  void _clearTextFields(){
    _emailController.clear();
    _firstNameController.clear();
    _lastNameController.clear();
    _mobileController.clear();
    _passwordController.clear();
  }

  void _onTapSignInButton(){
    // Navigator.pop(context);
    Get.back();

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
