import 'package:flutter/material.dart';

import '../../config/routes/animated_route.dart';
import '../../core/util/constants.dart' as constants;
import '../../domain/entity/movie_category.dart';
import '../view/expanded_movie_list.dart';
import 'home_page/home_page_movie_tile.dart';
import 'show_all_button.dart';

class MoviesList extends StatefulWidget {
  final MovieCategory category;
  static const int movieListFlex = 3;
  static const double listContainerHeight = 350;

  const MoviesList({
    super.key,
    required this.category,
  });

  @override
  State<MoviesList> createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(constants.mainPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.category.name,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
              Center(
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    Navigator.push(
                      context,
                      animatedRoute(ExpandedList(category: widget.category)),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MoviesList.listContainerHeight,
          child: ListView.builder(
            itemCount:
                constants.homeMaxElementsPerList > widget.category.movies.length
                    ? widget.category.movies.length
                    : constants.homeMaxElementsPerList + 1,
            scrollDirection: Axis.horizontal,
            itemBuilder: (
              BuildContext context,
              int index,
            ) =>
                index == constants.homeMaxElementsPerList
                    ? ShowAllButton(
                        category: widget.category,
                      )
                    : MovieTile(movie: widget.category.movies[index]),
          ),
        ),
      ],
    );
  }
}
