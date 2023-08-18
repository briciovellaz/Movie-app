import 'package:flutter/material.dart';

ThemeData movieAppData() {
  const Color mainColor=Colors.white;
  const Color secondaryColor=Colors.white70;
  const Color floatingButtonBgColor=Colors.red;
  const double titleBigFontSize=25;
  const double titleMediumFontSize=20;
  const double titleSmallFontSize=17;
  const double bodyMediumFontSize=17;
  const double bodySmallFontSize=15;
  const double floatingButtonIconSize=30;

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
        fontSize: titleBigFontSize,
      ),
      titleMedium: TextStyle(
        color: secondaryColor,
        fontSize: titleMediumFontSize,
      ),
      titleSmall: TextStyle(
        color: secondaryColor,
        fontSize: titleSmallFontSize,
      ),
      bodyMedium: TextStyle(
        color: secondaryColor,
        fontSize: bodyMediumFontSize,
      ),
      bodySmall: TextStyle(
        color: secondaryColor,
        fontSize: bodySmallFontSize,
      ),
    ),
    primaryColor: mainColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: floatingButtonBgColor,
      iconSize: floatingButtonIconSize,
    ),
  );
}
