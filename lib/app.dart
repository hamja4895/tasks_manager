import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:tasks_manager/ui/screens/add_new_task_screen.dart';
import 'package:tasks_manager/ui/screens/change_password_screen.dart';
import 'package:tasks_manager/ui/screens/forgot_password_email_screen.dart';
import 'package:tasks_manager/ui/screens/main_navbar_holder.dart';
import 'package:tasks_manager/ui/screens/pin_verification_screen.dart';
import 'package:tasks_manager/ui/screens/signin_screen.dart';
import 'package:tasks_manager/ui/screens/signup_screen.dart';
import 'package:tasks_manager/ui/screens/splash_screen.dart';
import 'package:tasks_manager/ui/screens/update_profile_screen.dart';
class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});
  static final GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      navigatorKey: navigator,
      theme: ThemeData(
        textTheme: TextTheme(
          titleLarge:TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,

          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,

          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,

          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            minimumSize: Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        )
      ),
      initialRoute: SplashScreen.name,
      routes: {
        SplashScreen.name:(context)=>SplashScreen(),
        SignInScreen.name:(context)=>SignInScreen(),
        SignUpScreen.name:(context)=>SignUpScreen(),
        ForgotPasswordEmailScreen.name:(context)=>ForgotPasswordEmailScreen(),
        PinVerificationScreen.name:(context)=>PinVerificationScreen(),
        ChangePasswordScreen.name:(context)=>ChangePasswordScreen(),
        MainNavbarHolder.name:(context)=>MainNavbarHolder(),
        AddNewTaskScreen.name:(context)=>AddNewTaskScreen(),
        UpdateProfileScreen.name:(context)=>UpdateProfileScreen(),
      },
      initialBinding: ,
    );
  }

}
