import 'package:flutter/material.dart';
import 'package:tasks_manager/ui/screens/new_task_list_screen.dart';
import 'package:tasks_manager/ui/screens/progress_task_screen.dart';
import '../widgets/tm_appbar.dart';
import 'cancelled_task_screen.dart';
import 'completed_task_screen.dart';

class MainNavbarHolder extends StatefulWidget {
  const MainNavbarHolder({super.key});
  static const String name = "/main_navbar_holder";

  @override
  State<MainNavbarHolder> createState() => _MainNavbarHolderState();
}

class _MainNavbarHolderState extends State<MainNavbarHolder> {
  final List<Widget> _screen = [NewTaskListScreen(),CompletedTaskListScreen(),CancelledTaskListScreen(),ProgressTaskListScreen()];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TM_AppBar(),


      body: _screen[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        indicatorColor: Colors.green,
        elevation: 10,

        // labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        onDestinationSelected: (int index) {
          _selectedIndex = index;
          setState(() {});
        },

        destinations: [
          NavigationDestination(
            icon: Icon(Icons.new_label, color: Colors.blue, size: 35),
            label: "New Task",
            selectedIcon: Icon(Icons.new_label, color: Colors.white, size: 40),
          ),
          NavigationDestination(
            icon: Icon(Icons.done_all, color: Colors.green, size: 35),
            label: "Completed",
            selectedIcon: Icon(Icons.done_all, color: Colors.white, size: 40),
          ),
          NavigationDestination(
            icon: Icon(Icons.cancel, color: Colors.red, size: 35),
            label: "Cancelled",
            selectedIcon: Icon(Icons.cancel, color: Colors.white, size: 40),
          ),
          NavigationDestination(
            icon: Icon(
              Icons.arrow_circle_right_outlined,
              color: Colors.purple,
              size: 35,
            ),
            label: "Progress",
            selectedIcon: Icon(
              Icons.arrow_circle_right_outlined,
              color: Colors.white,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}


