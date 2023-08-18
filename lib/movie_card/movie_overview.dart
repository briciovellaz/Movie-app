import 'package:flutter/material.dart';

class MovieOverview extends StatelessWidget {
  final String overview;
  static const String title = 'Overview';
  static const double titlePadding = 10;
  static const double bodyVerticalPadding = 10;
  static const double bodyHorizontalPadding = 20;
  static const int mainOverviewContainerFlex = 3;
  static const int overviewBodyFlex = 3;

  const MovieOverview({
    super.key,
    required this.overview,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: mainOverviewContainerFlex,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(titlePadding),
            alignment: Alignment.bottomLeft,
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          Expanded(
            flex: overviewBodyFlex,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: bodyVerticalPadding,
                horizontal: bodyHorizontalPadding,
              ),
              child: SingleChildScrollView(
                child: Text(
                  overview,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
