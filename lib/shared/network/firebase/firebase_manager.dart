import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/models/task_model.dart';

class FirebaseManager {
  static CollectionReference<TaskModel> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection("tasks")
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, _) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (task, _) {
        return task.toJson();
      },
    );
  }

  static Future<void> addTask(TaskModel task) {
    var collection = getTasksCollection();
    var docRef = collection.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  static Stream<QuerySnapshot<TaskModel>> getTasks(DateTime date) {
    return getTasksCollection()
        .where("date",
            isEqualTo: DateUtils.dateOnly(date).millisecondsSinceEpoch)
        .snapshots();
  }

  static Future<void> deleteTask(String taskId) {
    return getTasksCollection().doc(taskId).delete();
  }

  static void updateTask(TaskModel model) {
    getTasksCollection().doc(model.id).update(model.toJson());
  }

  static Future<void> createAccount(String email, String password,
      Function onSuccess, Function onError) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // credential.user!.sendEmailVerification();
      onSuccess();

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError(e.message);
      } else if (e.code == 'email-already-in-use') {
        onError(e.message);
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> login(String email, String password, Function onSuccess,
      Function onError) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // if(credential.user!.emailVerified){
      //   onSuccess();
      // }else{
      //   onError("Please Verify Your Email");
      // }
      onSuccess();
    } on FirebaseAuthException catch (e) {

      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
          onError("Wrong Email or Password");
         }
    }
  }
}
