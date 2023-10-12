import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:to_do_app/models/task_model.dart';

class FirebaseManager {
  static CollectionReference<TaskModel> getTasksCollection() {
    return FirebaseFirestore.instance.collection("tasks").withConverter<TaskModel>(
      fromFirestore: (snapshot, _) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (task, _) {
        return task.toJson();
      },
    );
  }

  static void addTask (TaskModel task){

    var collection = getTasksCollection();
    var docRef =collection.doc();
    task.id = docRef.id;
    docRef.set(task);

  }

}
