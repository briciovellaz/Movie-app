import 'package:flutter/material.dart';

class LikeCounter extends StatelessWidget {
  final int counter;
  final int limit;
  static const double iconSize = 50;
  static const double likesFontSize = 12;

  const LikeCounter({
    super.key,
    required this.counter,
    this.limit = 9999,
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
            fontSize: likesFontSize,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ],
    );
  }
}
