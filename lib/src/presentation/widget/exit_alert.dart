import 'package:flutter/material.dart';

import '../../core/util/strings.dart' as strings;

class ExitAlert extends StatelessWidget {
  const ExitAlert({super.key});

  static const String alertTitle = 'Exit';

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: const Text(alertTitle),
      backgroundColor: Theme.of(context).colorScheme.background,
      content: Text(
        strings.exitAppText,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: const Text(strings.yesString),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: const Text(strings.negationString),
        ),
      ],
    );
  }
}
