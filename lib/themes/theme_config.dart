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
      titleLarge: const TextStyle(color: Colors.white, fontSize: 24),
      titleMedium: TextStyle(
        color: Color(0xFF0F143B),
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(color: Colors.grey, fontSize: 14),
      headlineLarge: TextStyle(
        color: Color(0xFF0F143B),
        fontSize: 48,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: Colors.white,
        fontSize: 34,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(color: Colors.white, fontSize: 26),
    ),

    iconTheme: IconThemeData(color: Color(0xFF0F143B)),
  );
}
