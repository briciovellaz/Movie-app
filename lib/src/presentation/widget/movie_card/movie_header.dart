import 'package:flutter/material.dart';

import '../../../core/util/constants.dart' as constants;

class MovieHeader extends StatelessWidget {
  final String title;
  final String originalTitle;
  static const double titleTopPadding = 15;

  const MovieHeader({
    super.key,
    required this.title,
    required this.originalTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: constants.mainGradientColors,
        ),
      ),
      padding: const EdgeInsets.only(
        top: titleTopPadding,
        right: constants.mainPadding,
        left: constants.mainPadding,
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
