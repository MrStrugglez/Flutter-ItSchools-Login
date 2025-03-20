import 'package:flutter/material.dart';

class ThemeConfig {
  static ThemeData educateTheme = ThemeData(
    primaryColor: Color(0xFF0F143B),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      error: Color(0xFFD72632),
      secondary: Color(0xFF0064FF),
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF0F143B),
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF0F143B),
        textStyle: TextStyle(fontSize: 20),
      ),
    ),

    textTheme: TextTheme(
      headlineMedium: TextStyle(
        color: Color(0xFF0F143B),
        fontSize: 48,
        fontWeight: FontWeight.bold,
      ),
    ),

    iconTheme: IconThemeData(color: Color(0xFF0F143B)),
  );
}
