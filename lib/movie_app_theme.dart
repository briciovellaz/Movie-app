import 'package:flutter/material.dart';

ThemeData movieAppData() {
  const Color backgroundColor = Color.fromRGBO(30, 30, 30, 1.0);
  const Color mainColor = Colors.white;
  const Color secondaryColor = Color.fromRGBO(190, 190, 190, 1.0);
  const Color tertiaryColor = Color.fromRGBO(120, 120, 120, 1.0);
  const Color floatingButtonBgColor = Colors.red;
  const double titleBigFontSize = 25;
  const double titleMediumFontSize = 20;
  const double titleSmallFontSize = 17;
  const double bodyMediumFontSize = 17;
  const double bodySmallFontSize = 15;
  const double floatingButtonIconSize = 30;

  return ThemeData(
    colorScheme: const ColorScheme(
      primary: Colors.red,
      secondary: secondaryColor,
      tertiary: tertiaryColor,
      brightness: Brightness.dark,
      onPrimary: mainColor,
      onSecondary: mainColor,
      error: Colors.red,
      onError: Colors.black,
      onBackground: mainColor,
      background: backgroundColor,
      surface: backgroundColor,
      onSurface: secondaryColor,
    ),
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

