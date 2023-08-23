import 'package:flutter/material.dart';

class InfoDetail extends StatelessWidget {
  final String info;
  final IconData icon;

  const InfoDetail({
    super.key,
    required this.icon,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.tertiary,
        ),
        Text(info),
      ],
    );
  }
}
