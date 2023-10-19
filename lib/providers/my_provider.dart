import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/models/user_model.dart';
import 'package:to_do_app/shared/network/firebase/firebase_manager.dart';

class MyProvider extends ChangeNotifier {
  UserModel? userModel;
  User? firebaseUser;
  ThemeMode theme = ThemeMode.light ;

  MyProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;

    if (firebaseUser != null) {
      initUser();
    }
  }

  initUser() async {
    firebaseUser = FirebaseAuth.instance.currentUser;
    userModel = await FirebaseManager.readUser(firebaseUser!.uid);
    notifyListeners();
  }

  changeTheme(){
    if(theme==ThemeMode.light){
      theme = ThemeMode.dark;
    }
    else{
      theme = ThemeMode.light;
    }
    notifyListeners();

  }

}
