import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_manager/ui/screens/signup_screen.dart';
import 'package:tasks_manager/ui/widgets/centered_cicular_indicator.dart';

import '../controllers/sign_in_controller.dart';
import '../widgets/screen_background.dart';
import '../widgets/snack_bar_massage.dart';
import 'forgot_password_email_screen.dart';
import 'main_navbar_holder.dart';
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String name='/signin';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();
  final GlobalKey<FormState> _formKey= GlobalKey<FormState>();
  final SignInController _signInController=SignInController();
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
                    child: Text("Get Started With",
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
                      child:  GetBuilder(
                        init: _signInController,
                        builder: (controller) {
                          return Visibility(
                            visible: controller.inProgress == false,
                            replacement: CenteredCircularIndicator(),
                            child: ElevatedButton(

                                onPressed: _onTapSignInButton,
                                child: Icon(Icons.arrow_circle_right_outlined,size: 30,)
                            ),
                          );
                        }
                      ),
                    ),
                  SizedBox(height: 100,),
                  TextButton(
                    onPressed: _onTapForgotPasswordButton,
                      child: Text("Forget password?",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ),
                  RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        children: [
                          TextSpan(
                            text: "Sign Up",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                            recognizer: TapGestureRecognizer()..onTap= _onTapSignUpButton,
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
  void _onTapSignInButton(){
    if(_formKey.currentState!.validate()){
      _signIn();
    }

  }

  Future<void> _signIn() async{
    final bool isSuccess = await _signInController.signIn(
      _emailController.text.trim(),
      _passwordController.text,
    );
    if(isSuccess){
      Get.offAllNamed(MainNavbarHolder.name);
      if(mounted){
        showSnackBarMassage(context, "Login Successfully");
      }

    }else{
      if(mounted){
        showSnackBarMassage(context, _signInController.errorMassage!);
      }
      
    }
  }

  void _onTapForgotPasswordButton(){
    // Navigator.pushNamed(context, ForgotPasswordEmailScreen.name);
    Get.toNamed(ForgotPasswordEmailScreen.name);

  }
  void _onTapSignUpButton(){
    // Navigator.pushNamed(context, SignUpScreen.name);
    Get.toNamed(SignUpScreen.name);

  }
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

}
