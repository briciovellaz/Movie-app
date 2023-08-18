import 'package:flutter/material.dart';

ThemeData movieAppData() {
  const Color mainColor=Colors.white;
  const Color secondaryColor=Colors.white70;
  return ThemeData(
    colorScheme: const ColorScheme(
      primary: Colors.red,
      secondary: secondaryColor,
      tertiary: secondaryColor,
      brightness: Brightness.light,
      onPrimary: mainColor,
      onSecondary: mainColor,
      error: Colors.red,
      onError: Colors.black,
      onBackground: mainColor,
      background: Colors.black87,
      surface: Colors.black87,
      onSurface: secondaryColor,
    ),
    brightness: Brightness.light,
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: mainColor,
        fontSize: 25,
      ),
      titleMedium: TextStyle(
        color: secondaryColor,
        fontSize: 20,
      ),
      titleSmall: TextStyle(
        color: secondaryColor,
        fontSize: 17,
      ),
      bodyMedium: TextStyle(
        color: secondaryColor,
        fontSize: 17,
      ),
      bodySmall: TextStyle(
        color: secondaryColor,
        fontSize: 15,
      ),
    ),
    primaryColor: mainColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.red,
      iconSize: 30,
    ),
  );
}
