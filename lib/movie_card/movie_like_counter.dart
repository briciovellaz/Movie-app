import 'package:flutter/material.dart';

class LikeCounter extends StatelessWidget {
  final int counter;
  final int limit;
  static const double iconSize = 50;

  const LikeCounter({
    super.key,
    required this.counter,
    this.limit = 99,
  });

  @override
  Widget build(BuildContext context) {
    final String iconShowLimit = '$limit+';
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(
          Icons.favorite,
          color: Theme.of(context).colorScheme.primary,
          size: iconSize,
        ),
        Text(
          (counter <= limit) ? counter.toString() : iconShowLimit,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ],
    );
  }
}
