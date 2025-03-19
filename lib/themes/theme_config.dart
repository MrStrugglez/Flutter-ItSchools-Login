import 'package:flutter/material.dart';

class ThemeConfig {
  static ThemeData geneticsTheme = ThemeData(
    primaryColor: Color(0xFF7853A2),
    colorScheme: ColorScheme.fromSwatch().copyWith(error: Color(0xFFE84B39)),

    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF7853A2),
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF7853A2),
        textStyle: TextStyle(fontSize: 20),
      ),
    ),

    textTheme: TextTheme(
      headlineMedium: TextStyle(
        color: Color(0xFF7853A2),
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),

    iconTheme: IconThemeData(color: Color(0xFF7853A2)),
  );
}
