import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_app/models/task_model.dart';
import 'package:to_do_app/screens/edit/edit_screen.dart';
import 'package:to_do_app/shared/network/firebase/firebase_manager.dart';
import 'package:to_do_app/shared/styles/colors.dart';

class TaskItem extends StatelessWidget {
  TaskModel task;

  TaskItem(this.task, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      color: Theme.of(context).colorScheme.onBackground,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:  BorderSide(color: Theme.of(context).colorScheme.onBackground,)),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Slidable(
      
        startActionPane: ActionPane(motion: const BehindMotion(), children: [
          SlidableAction(
            onPressed: (context) {
              FirebaseManager.deleteTask(task.id);
            },
            backgroundColor: Colors.red,
            label: "Delete",
            icon: Icons.delete,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(12),bottomLeft: Radius.circular(12)),
          ),
          SlidableAction(
            onPressed: (context) {

              Navigator.pushNamed(context, EditScreen.routeName,arguments: task);
            },
            backgroundColor: Colors.blue,
            label: "Edit",
            icon: Icons.edit,
          ),
        ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).colorScheme.onBackground,
          ),
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                height: 80,
                width: 4,
                decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: primary)),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primary,
                    ),
                  ),
                  Text(
                    task.description,
                    style:  TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              InkWell(
                onTap: (){
                  if (task.isDone == true){
                    task.isDone=false;
                  }
                  else {
                    task.isDone=true;
                  }
                  FirebaseManager.updateTask(task);

                },
                child: Container(
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                  decoration: BoxDecoration(
                    color: task.isDone ? Colors.green : primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: task.isDone ? const Text("Done",style: TextStyle(fontSize: 24,color: Colors.white),) :const Icon(
                    Icons.done,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
