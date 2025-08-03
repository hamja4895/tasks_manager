import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_manager/ui/controllers/forgot_password_email_controller.dart';
import 'package:tasks_manager/ui/screens/pin_verification_screen.dart';
import 'package:tasks_manager/ui/widgets/centered_cicular_indicator.dart';
import '../widgets/screen_background.dart';
import '../widgets/snack_bar_massage.dart';

class ForgotPasswordEmailScreen extends StatefulWidget {
  const ForgotPasswordEmailScreen({super.key});

  static const String name='/forgot_password_email';

  @override
  State<ForgotPasswordEmailScreen> createState() => _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
  final TextEditingController _emailController=TextEditingController();
  final GlobalKey<FormState> _formKey= GlobalKey<FormState>();
  final ForgotPasswordEmailController _forgotPasswordEmailController=ForgotPasswordEmailController();
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
                          Text("Your Email Address",
                          style: Theme.of(context).textTheme.titleLarge,),
                          SizedBox(height: 16,),
                          Text("A 6-digit code will be sent to your email address",
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.grey
                          )
                          ),

                        ]
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

                    SizedBox(
                      height: 40,
                      child: GetBuilder(
                        init: _forgotPasswordEmailController,
                        builder: (controller) {
                          return Visibility(
                            visible: controller.inProgress==false,
                            replacement: CenteredCircularIndicator(),
                            child: ElevatedButton(

                                onPressed: _onTapForgotPasswordEmailSubmitButton,
                                child: Icon(Icons.arrow_circle_right_outlined,size: 30,)
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
  void _onTapForgotPasswordEmailSubmitButton(){
    if(_formKey.currentState!.validate()){
      _getRecoveryEmailVerification(_emailController.text.trim());
    }

  }

  void _onTapSignInButton(){
    // Navigator.pop(context);
    Get.back();

  }
  Future<void> _getRecoveryEmailVerification(String email)async{
    final bool isSuccess = await _forgotPasswordEmailController.getRecoveryEmailVerification(email);

    if(isSuccess){
      if(mounted){
        showSnackBarMassage(context, "6-digit code sent to your email address");
      }
          // Navigator.pushNamed(
          //     context, PinVerificationScreen.name, arguments: email);
          Get.toNamed(PinVerificationScreen.name,arguments: email);

    }else{
      if(mounted){
        showSnackBarMassage(context, _forgotPasswordEmailController.getErrorMassage);
      }
    }

  }
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

}
