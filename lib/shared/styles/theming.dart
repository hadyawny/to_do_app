import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/shared/styles/colors.dart';

class MyThemeData {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: lightBackground,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: primary,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.transparent,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: primary
    ),

    textTheme: TextTheme(bodyLarge: GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.black
    ),),
  );

  static ThemeData darkTheme = ThemeData();
}
