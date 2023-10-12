import 'package:flutter/material.dart';
import 'package:to_do_app/screens/settings/settings_tab.dart';
import 'package:to_do_app/screens/tasks/tasks_tab.dart';
import 'package:to_do_app/shared/styles/colors.dart';

import '../screens/tasks/add_task_bottom_sheet.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName = "homeLayout";

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int index = 0;
  List<Widget> tabs = [TasksTab(), SettingsTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: mintGreen,
      appBar: AppBar(
        backgroundColor: primary,
        title: Text("To Do"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: primary,
        onPressed: () {
          showAddTaskBottomSheet();
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 7,
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
            elevation: 0,
            currentIndex: index,
            onTap: (value) {
              setState(() {
                index = value;
              });
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.list), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
            ]),
      ),
      body: tabs[index],
    );
  }

  showAddTaskBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: AddTaskBottomSheet(),
        );
      },
    );
  }
}
