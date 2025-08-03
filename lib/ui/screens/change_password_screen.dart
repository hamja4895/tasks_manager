import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tasks_manager/ui/screens/signin_screen.dart';
import 'package:tasks_manager/ui/widgets/centered_cicular_indicator.dart';
import '../controllers/change_password_controller.dart';
import '../widgets/screen_background.dart';
import '../widgets/snack_bar_massage.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  static const String name='/change_password';

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _passwordTeController=TextEditingController();
  final TextEditingController _confirmPasswordTeController=TextEditingController();
  final GlobalKey<FormState> _formKey= GlobalKey<FormState>();
  late Map<String,dynamic> args;
  final ChangePasswordController _changePasswordController=ChangePasswordController();

@override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    args=ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
  }
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
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Set Password",
                              style: Theme.of(context).textTheme.titleLarge,),
                            SizedBox(height: 16,),
                            Text("Minimum length password 8 characters with letter and number combination",
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.grey
                                )
                            ),

                          ]
                      ),
                    ),
                    SizedBox(height: 24,),
                    TextFormField(
                      controller: _passwordTeController,
                      obscureText: true,

                      textInputAction: TextInputAction.next,
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
                    TextFormField(
                      controller: _confirmPasswordTeController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Confirm Password",
                      ),
                      validator: (String ? value){
                        if((value ?? "" ) != _passwordTeController.text){
                          return "Confirm password doesn't match";

                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16,),

                    SizedBox(
                      height: 40,
                      child: GetBuilder(
                        init: _changePasswordController,
                        builder: (controller) {
                          return Visibility(
                            visible: controller.inProgress==false,
                            replacement: CenteredCircularIndicator(),
                            child: ElevatedButton(

                                onPressed: _onTapChangePasswordConfirmSubmitButton,
                                child: Text("Confirm"),
                            ),
                          );
                        }
                      ),
                    ),
                    SizedBox(height: 60,),
                    RichText(
                        text: TextSpan(
                          text: "have account? ",
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
  void _onTapChangePasswordConfirmSubmitButton(){
    if(_formKey.currentState!.validate()){
      _postChangePassword(args["email"],args["otp"],_passwordTeController.text);
    }
    // Navigator.pushNamed(context, PinVerificationScreen.name);

  }

  Future<void> _postChangePassword(String email,String otp,String password)async{
    bool isSuccess = await _changePasswordController.postChangePassword(email, otp, password);

    if(isSuccess){
      // Navigator.pushNamedAndRemoveUntil(
      //     context, SignInScreen.name, (predicate) => false);
      Get.offAllNamed(SignInScreen.name);
      if(mounted){
        showSnackBarMassage(context, "Password Changed Successfully");
      }
    }else{
      _passwordTeController.clear();
      _confirmPasswordTeController.clear();
      if(mounted){
        showSnackBarMassage(context, _changePasswordController.errorMassage!);
      }

    }



  }

  void _onTapSignInButton(){
    // Navigator.pushNamedAndRemoveUntil(context, SignInScreen.name, (predicate)=>false);
    Get.offAllNamed(SignInScreen.name);

  }
  @override
  void dispose() {
    _passwordTeController.dispose();
    _confirmPasswordTeController.dispose();
    super.dispose();
  }

}
