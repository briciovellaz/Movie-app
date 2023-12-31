import 'package:flutter/material.dart';
import '../../../domain/entity/movie_category.dart';
import '../horizontal_movies_list.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({
    super.key,
    required this.categories,
  });

  final List<MovieCategory> categories;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var category in categories)
          MoviesList(
            category: category,
          ),
      ],
    );
  }
}
