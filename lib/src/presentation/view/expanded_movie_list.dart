import 'package:flutter/material.dart';

import '../../domain/entity/movie_category.dart';
import '../widget/detailed_list_item.dart';

class ExpandedList extends StatelessWidget {
  final MovieCategory category;
  static const double listHorizontalPadding = 8;

  const ExpandedList({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(category.name),
          leading: BackButton(
            color: Theme.of(context).colorScheme.onPrimary,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: listHorizontalPadding),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: category.movies.length,
            itemBuilder: (
              BuildContext context,
              int index,
            ) {
              return DetailedListItem(
                movie: category.movies[index],
              );
            },
          ),
        ),
      ),
    );
  }
}
