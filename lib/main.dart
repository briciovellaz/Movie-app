import 'package:flutter/material.dart';

import 'src/config/themes/movie_app_theme.dart';
import 'src/presentation/view/loading_screen.dart';

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
