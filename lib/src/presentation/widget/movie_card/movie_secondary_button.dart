import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final IconData icon;
  final double radius;

  const SecondaryButton({
    super.key,
    required this.icon,
    this.radius = 25,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      child: IconButton.outlined(
        onPressed: () {},
        icon: Icon(icon),
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
