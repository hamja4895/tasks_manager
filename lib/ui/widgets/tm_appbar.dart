import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_manager/ui/screens/signin_screen.dart';
import 'package:tasks_manager/ui/widgets/snack_bar_massage.dart';

import '../controllers/auth_controller.dart';
import '../screens/update_profile_screen.dart';
class TM_AppBar extends StatefulWidget implements PreferredSizeWidget {
  const TM_AppBar({super.key});

  @override
  State<TM_AppBar> createState() => _TM_AppBarState();

  @override
// TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _TM_AppBarState extends State<TM_AppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap: _onTapProfile,
        child: Row(
          children: [
            CircleAvatar(radius: 24,
              backgroundImage:AuthController.userModel?.photo == null
                  ? null
                  : MemoryImage(
                  base64Decode(AuthController.userModel!.photo!)
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${AuthController.userModel!.firstName} ${AuthController.userModel!.lastName}",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    AuthController.userModel!.email,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: _onTapLogoutButton,
            icon: Icon(Icons.logout, size: 30, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Future<void> _onTapLogoutButton() async{
    await AuthController.clearUserData();
    // Navigator.pushNamedAndRemoveUntil(context,SignInScreen.name , (predicate)=>false);
    Get.offAllNamed(SignInScreen.name);
    showSnackBarMassage(context,"Logout Success");

  }
  void _onTapProfile(){

    if(ModalRoute.of(context)!.settings.name != UpdateProfileScreen.name){
    // Navigator.pushNamed(context,UpdateProfileScreen.name);
      Get.toNamed(UpdateProfileScreen.name);
    }

  }

}
