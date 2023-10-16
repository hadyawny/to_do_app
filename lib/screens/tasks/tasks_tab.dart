import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/screens/tasks/task_item.dart';
import 'package:to_do_app/shared/network/firebase/firebase_manager.dart';
import 'package:to_do_app/shared/styles/colors.dart';

import '../../models/task_model.dart';

class TasksTab extends StatefulWidget {
  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarTimeline(
          initialDate: selectedDate,
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateSelected: (date) {
            selectedDate = date;
            setState(() {});
          },
          leftMargin: 9,
          monthColor: primary,
          dayColor: Colors.grey,
          activeDayColor: Colors.white,
          activeBackgroundDayColor: primary,
          dotsColor: Colors.white,
          selectableDayPredicate: (date) => true,
          locale: 'en_ISO',
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
            child: StreamBuilder<QuerySnapshot<TaskModel>>(
          stream: FirebaseManager.getTasks(selectedDate),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: const CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text("Something went wrong"));
            }

            var tasks =
                snapshot.data?.docs.map((doc) => doc.data()).toList() ?? [];

            return ListView.builder(
              itemBuilder: (context, index) {
                return TaskItem(tasks[index]);
              },
              itemCount: tasks.length,
            );
          },
        ))
      ],
    );
  }
}
