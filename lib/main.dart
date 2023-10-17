import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/layout/home_layout.dart';
import 'package:to_do_app/screens/login/login.dart';
import 'package:to_do_app/shared/styles/theming.dart';

import 'firebase_options.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // FirebaseFirestore.instance.disableNetwork();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.routeName,
      routes: {
        HomeLayout.routeName: (context) => HomeLayout(),
        LoginScreen.routeName: (context) => LoginScreen(),
      },
      themeMode: ThemeMode.light,
      theme: MyThemeData.lightTheme,
    );
  }
}
