import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/screens/tasks/task_item.dart';
import 'package:to_do_app/shared/styles/colors.dart';

class TasksTab extends StatelessWidget {
  const TasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarTimeline(
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateSelected: (date) => print(date),
          leftMargin: 9,
          monthColor: primary,
          dayColor: Colors.grey,
          activeDayColor: Colors.white,
          activeBackgroundDayColor: primary,
          dotsColor: Colors.white,
          selectableDayPredicate: (date) => true,
          locale: 'en_ISO',
        ),
        SizedBox(height: 10,),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return TaskItem();
            },
            itemCount: 8,
          ),
        )
      ],
    );
  }
}
