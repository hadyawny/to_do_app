import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/layout/home_layout.dart';

import '../../models/task_model.dart';
import '../../shared/network/firebase/firebase_manager.dart';
import '../../shared/styles/colors.dart';
import '../login/login_screen.dart';

class EditScreen extends StatefulWidget {
  static const String routeName = "editScreen";

  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var selectedDate;

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as TaskModel;

    selectedDate ??= DateTime.fromMillisecondsSinceEpoch(args.date);
    titleController.text = args.title;
    descriptionController.text = args.description;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginScreen.routeName, (route) => false);
              },
              icon: const Icon(Icons.logout))
        ],
        title: const Text("To Do "),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Theme.of(context).colorScheme.onBackground),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Edit Task",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: titleController,
                  style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                  decoration: InputDecoration(
                    label:  Text(
                      "Task Title",
                      style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
                    ),
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
                  style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                  decoration: InputDecoration(
                    label:  Text(
                      "Task Description",
                      style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
                    ),

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
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary),
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
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: primary),
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
                    args.title = titleController.text;
                    args.description = descriptionController.text;
                    args.date =
                        DateUtils.dateOnly(selectedDate).millisecondsSinceEpoch;

                    FirebaseManager.updateTask(args);
                    Navigator.pushNamedAndRemoveUntil(
                        context, HomeLayout.routeName, (route) => false);
                  },
                  child: const Text(
                    "Save",
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
              ],
            ),
          ),
        ),
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
