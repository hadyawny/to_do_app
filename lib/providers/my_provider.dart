import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/models/user_model.dart';
import 'package:to_do_app/shared/network/firebase/firebase_manager.dart';

import '../prefs/prefs_helper.dart';

class MyProvider extends ChangeNotifier {
  UserModel? userModel;
  User? firebaseUser;
  ThemeMode theme = ThemeMode.light ;


  void init() async {

    String newTheme = PrefsHelper.getTheme();

    if (newTheme == "dark") {
      theme = ThemeMode.dark;
    } else {
      theme = ThemeMode.light;
    }
  }



  changeTheme(){
    if(theme==ThemeMode.light){
      theme = ThemeMode.dark;
      PrefsHelper.saveTheme("dark");
    }
    else{
      theme = ThemeMode.light;
      PrefsHelper.saveTheme("light");
    }
    notifyListeners();

  }




  MyProvider() {
    init();
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


}
