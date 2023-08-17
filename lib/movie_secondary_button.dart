import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final IconData icon;

  //final VoidCallback onPressed;

  const SecondaryButton({super.key, required this.icon}); //add onpressed action
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
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
