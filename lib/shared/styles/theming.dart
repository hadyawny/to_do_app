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

    colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: primary,
        onPrimary: Colors.white,
        secondary: Colors.black,
        onSecondary: Colors.black45,
        error: Colors.red,
        onError: Colors.white,
        background: lightBackground,
        onBackground: Colors.white,
        surface: lightBackground,
        onSurface: Colors.white),

  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: darkBackground,
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

    colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: primary,
        onPrimary: Colors.white,
        secondary: Colors.white,
        onSecondary: Colors.grey,
        error: Colors.red,
        onError: Colors.white,
        background: darkBackground,
        onBackground: Color(0xff141922),
        surface: lightBackground,
        onSurface: Colors.white),

  );
}
