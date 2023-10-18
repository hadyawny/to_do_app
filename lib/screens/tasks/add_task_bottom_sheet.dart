import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/models/task_model.dart';
import 'package:to_do_app/shared/network/firebase/firebase_manager.dart';
import 'package:to_do_app/shared/styles/colors.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Add New Task",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 24,
          ),
          TextFormField(
            controller: titleController,
            decoration: InputDecoration(
              label: const Text("Task Title",style: TextStyle(color: Colors.black45),),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: primary,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: primary,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          TextFormField(
            controller: descriptionController,
            decoration: InputDecoration(
              label: const Text("Task Description",style: TextStyle(color: Colors.black45),),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: primary,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: primary,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          Text(
            "Select Date",
            style: GoogleFonts.poppins(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(
            height: 9,
          ),
          InkWell(
            onTap: () {
              selectDate();
            },
            child: Text(
              selectedDate.toString().substring(0, 10),
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w500, color: primary),
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primary,
            ),
            onPressed: () {
              TaskModel task = TaskModel(
                  userId: FirebaseAuth.instance.currentUser!.uid,
                  title: titleController.text,
                  description: descriptionController.text,
                  date: DateUtils.dateOnly(selectedDate).millisecondsSinceEpoch);
              FirebaseManager.addTask(task).then((value) {
                Navigator.pop(context);
              });
            },
            child: const Text(
              "Add Task",
            ),
          ),
          const SizedBox(
            height: 18,
          ),
        ],
      ),
    );
  }

  selectDate() async {
    DateTime? chosenDate = await showDatePicker(
      context: context,
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                  primary: primary,
                  onPrimary: Colors.white,
                  onSurface: Colors.black),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: primary,
                ),
              ),
            ),
            child: child!);
      },
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    );
    if (chosenDate == null) {
      return;
    }
    selectedDate = chosenDate;
    setState(() {});
  }
}
