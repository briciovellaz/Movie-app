import 'package:flutter/material.dart';
import '../../../config/routes/animated_route.dart';
import '../../../core/util/constants.dart' as constants;
import '../../../domain/entity/movie_category.dart';
import '../../view/expanded_movie_list.dart';
import '../show_all_button.dart';
import 'secondary_list_movie_tile.dart';

class SecondaryMoviesList extends StatelessWidget {
  final MovieCategory listInfo;
  static const int movieListFlex = 3;
  static const double titlePadding = constants.mainPadding;
  static const double listContainerHeight = 200;

  const SecondaryMoviesList({
    super.key,
    required this.listInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(titlePadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                listInfo.name,
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
                      animatedRoute(ExpandedList(category: listInfo)),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: listContainerHeight,
          child: ListView.builder(
            itemCount: constants.homeMaxElementsPerList > listInfo.movies.length
                ? listInfo.movies.length
                : constants.homeMaxElementsPerList + 1,
            scrollDirection: Axis.horizontal,
            itemBuilder: (
              BuildContext context,
              int index,
            ) =>
                index == constants.homeMaxElementsPerList
                    ? ShowAllButton(
                        category: listInfo,
                      )
                    : SecondaryListMovieTile(movie: listInfo.movies[index]),
          ),
        ),
      ],
    );
  }
}
