import 'package:bricio_vellaz/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: const ColorScheme(
          primary: Colors.red,
          secondary: Colors.white70,
          tertiary: Colors.white70,
          brightness: Brightness.light,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.black,
          onBackground: Colors.white,
          background: Colors.black87,
          surface: Colors.black87,
          onSurface: Colors.white70,
        ),
        brightness: Brightness.light,
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
          titleMedium: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          titleSmall: TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
          bodyMedium: TextStyle(
            color: Colors.white70,
            fontSize: 17,
          ),
          bodySmall: TextStyle(
            color: Colors.white70,
            fontSize: 15,
          ),
        ),
        primaryColor: Colors.white,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.red,
          iconSize: 30,
        ),
        //theme for the entire app
      ),
      home: const Scaffold(
        body: SafeArea(
          top: true,
          bottom: true,
          left: true,
          right: true,
          child: Home(),
        ),
      ),
    );
  }
}
