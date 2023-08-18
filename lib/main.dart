import 'package:bricio_vellaz/home.dart';
import 'package:flutter/material.dart';
import 'movie_app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: movieAppData(),
      home: const Scaffold(
        body: SafeArea(
          child: Home(),
        ),
      ),
    );
  }
}
