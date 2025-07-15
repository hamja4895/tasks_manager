import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../widgets/screen_background.dart';
import 'package:tasks_manager/ui/screens/signin_screen.dart';

import 'change_password_screen.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});

  static const String name='/pin_verification';

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final TextEditingController _otpTeController=TextEditingController();
  final GlobalKey<FormState> _formKey= GlobalKey<FormState>();
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
                            Text("Pin Verification",
                              style: Theme.of(context).textTheme.titleLarge,),
                            SizedBox(height: 16,),
                            Text("A 6-digit code has been sent to your email address",
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.grey
                                )
                            ),

                          ]
                      ),
                    ),
                    SizedBox(height: 24,),
                    PinCodeTextField(
                      length: 6,
                      keyboardType: TextInputType.number,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 50,
                        activeFillColor: Colors.white,
                        inactiveColor: Colors.grey,
                        selectedColor: Colors.green,
                      ),
                      animationDuration: Duration(milliseconds: 300),
                      backgroundColor: Colors.white,
                      controller: _otpTeController,
                      appContext: context,


                    ),
                    SizedBox(height: 16,),

                    SizedBox(
                      height: 40,
                      child: ElevatedButton(

                          onPressed: _onTapPinVerificationSubmitButton,
                          child: Text("Verify")
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
  void _onTapPinVerificationSubmitButton(){
    Navigator.pushNamed(context, ChangePasswordScreen.name);

  }

  void _onTapSignInButton(){
    Navigator.pushNamedAndRemoveUntil(context, SignInScreen.name, (predicate)=>false);

  }
  @override
  void dispose() {
    _otpTeController.dispose();
    super.dispose();
  }

}
