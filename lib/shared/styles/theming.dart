import 'package:flutter/material.dart';
import 'package:to_do_app/shared/styles/colors.dart';

class MyThemeData {

  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: mintGreen,


      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primary,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.transparent,
      ));

  static ThemeData darkTheme = ThemeData();
}
