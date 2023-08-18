import 'package:flutter/material.dart';

class LikeCounter extends StatelessWidget {
  int counter;

  LikeCounter({
    super.key,
    required this.counter,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(
          Icons.favorite,
          color: Theme.of(context).colorScheme.primary,
          size: 50,
        ),
        Text(
          (counter <= 99) ? counter.toString() : '99+',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ],
    );
  }
}
