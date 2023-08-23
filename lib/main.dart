import 'package:flutter/material.dart';

import 'loading_screen.dart';
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
      home: const LoadingScreen(),
    );
  }
}
