import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_app/models/task_model.dart';
import 'package:to_do_app/shared/network/firebase/firebase_manager.dart';
import 'package:to_do_app/shared/styles/colors.dart';

class TaskItem extends StatelessWidget {
  TaskModel task;

  TaskItem(this.task, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.transparent)),
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Slidable(

        startActionPane: ActionPane(motion: BehindMotion(), children: [
          SlidableAction(
            onPressed: (context) {
              FirebaseManager.deleteTask(task.id);
            },
            backgroundColor: Colors.red,
            label: "Delete",
            icon: Icons.delete,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(12),bottomLeft: Radius.circular(12)),
          ),
          SlidableAction(
            onPressed: (context) {},
            backgroundColor: Colors.blue,
            label: "Edit",
            icon: Icons.edit,
          ),
        ],
        ),
        child: Padding(
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
              SizedBox(
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
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              Spacer(),
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
                  margin: EdgeInsets.only(right: 12),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                  decoration: BoxDecoration(
                    color: task.isDone ? Colors.green : primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: task.isDone ? Text("Done",style: TextStyle(fontSize: 24,color: Colors.white),) :Icon(
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
