import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tasks_manager/ui/controllers/auth_controller.dart';
import 'package:tasks_manager/ui/screens/main_navbar_holder.dart';
import 'package:tasks_manager/ui/screens/signin_screen.dart';
import '../utils/asset_paths.dart';
import '../widgets/screen_background.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String name='/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _moveToNextScreen();
  }


  Future<void> _moveToNextScreen() async {
    await Future.delayed(Duration(seconds: 2));
    bool isLogedIn = await AuthController.isUserLoggedIn();
    if(isLogedIn){
      // Navigator.pushReplacementNamed(context, MainNavbarHolder.name);
      Get.offNamed(MainNavbarHolder.name);
    }else{
      // Navigator.pushReplacementNamed(context, SignInScreen.name);
      Get.offNamed(SignInScreen.name);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(child: SvgPicture.asset(AssetPaths.logo_svg)),)

    );
  }
}
