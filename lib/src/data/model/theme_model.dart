import 'package:flutter/material.dart';

class ThemeModel {
  final String name;
  final ThemeData themeData;

  ThemeModel({
    required this.name,
    required this.themeData,
  });

  factory ThemeModel.fromJson(Map<String, dynamic> json) {
    return ThemeModel(
      name: json['themeName'],
      themeData: ThemeData(
        canvasColor: Color(json['canvasColor']),
        colorScheme: ColorScheme(
          primary: Color(json['colorSchemeMain']),
          secondary: Color(json['secondaryColor']),
          tertiary: Color(json['tertiaryColor']),
          brightness: (json['brightness'] == 'light')
              ? Brightness.light
              : Brightness.dark,
          onPrimary: Color(json['mainColor']),
          onSecondary: Color(json['mainColor']),
          error: Color(json['colorSchemeMain']),
          onError: Color(json['mainColor']),
          background: Color(json['backgroundColor']),
          onBackground: Color(json['mainColor']),
          surface: Color(json['backgroundColor']),
          onSurface: Color(json['secondaryColor']),
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            color: Color(json['mainColor']),
            fontSize: json['titleBig'],
          ),
          titleMedium: TextStyle(
            color: Color(json['secondaryColor']),
            fontSize: json['titleMedium'],
          ),
          titleSmall: TextStyle(
            color: Color(json['secondaryColor']),
            fontSize: json['titleSmall'],
          ),
          bodyMedium: TextStyle(
            color: Color(json['secondaryColor']),
            fontSize: json['bodyMedium'],
          ),
          bodySmall: TextStyle(
            color: Color(json['secondaryColor']),
            fontSize: json['bodySmall'],
          ),
        ),
        primaryColor: Color(json['primaryColor']),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          iconSize: json['floatingButtonIconSize'],
          backgroundColor: Color(json['floatingBtnColor']),
          foregroundColor: Color(json['backgroundColor']),
        ),
      ),
    );
  }
}
