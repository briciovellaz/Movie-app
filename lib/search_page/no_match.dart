import 'package:flutter/material.dart';
import '../constants/strings.dart' as strings;

class NoMatchAlert extends StatelessWidget {
  const NoMatchAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          strings.noMatchingSearch,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
