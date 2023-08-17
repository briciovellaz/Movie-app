import 'package:flutter/material.dart';

class MovieHeader extends StatelessWidget {
  final String title;
  final String originalTitle;
  static const double titleTopPadding = 15;
  static const double titleSidePadding = 10;

  const MovieHeader({
    super.key,
    required this.title,
    required this.originalTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: titleTopPadding,
        right: titleSidePadding,
        left: titleSidePadding,
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          Text(
            originalTitle,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
