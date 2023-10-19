import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/layout/home_layout.dart';
import 'package:to_do_app/providers/my_provider.dart';
import 'package:to_do_app/screens/edit/edit_screen.dart';
import 'package:to_do_app/screens/login/login_screen.dart';
import 'package:to_do_app/screens/login/sign_up_screen.dart';
import 'package:to_do_app/shared/styles/theming.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // FirebaseFirestore.instance.disableNetwork();
  runApp(
      ChangeNotifierProvider(
      create: (context) => MyProvider(),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: provider.firebaseUser != null
          ? HomeLayout.routeName
          : LoginScreen.routeName,
      routes: {
        HomeLayout.routeName: (context) => HomeLayout(),
        LoginScreen.routeName: (context) => LoginScreen(),
        SignUpScreen.routeName: (context) => SignUpScreen(),
        EditScreen.routeName: (context) => EditScreen(),
      },
      themeMode: provider.theme,
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
    );
  }
}
