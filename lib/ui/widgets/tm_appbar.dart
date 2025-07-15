import 'package:flutter/material.dart';
import 'package:tasks_manager/ui/screens/signin_screen.dart';

import '../../app.dart';
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
              backgroundImage: NetworkImage("https://media.istockphoto.com/id/155415624/photo/for-the-man-who-has-it-all.jpg?s=612x612&w=0&k=20&c=adhW7qc6YpaGC-iHprngGonVOrnz7sdlYCj126-Mo5A="),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Amir Hamja",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "amir@gmail.com",
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

  void _onTapLogoutButton(){
    Navigator.pushNamedAndRemoveUntil(context,SignInScreen.name , (predicate)=>false);

  }
  void _onTapProfile(){

    if(ModalRoute.of(context)!.settings.name != UpdateProfileScreen.name){
    Navigator.pushNamed(context,UpdateProfileScreen.name);
    }

  }


}
