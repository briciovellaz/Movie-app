import 'package:flutter/material.dart';
import '../constants/constants.dart' as constants;
import '../movie.dart';
import 'upcoming_movie_tile.dart';

class UpcomingMovies extends StatelessWidget {
  final List<Movie> upcomingMovies;
  static const int movieListFlex = 3;
  static const double titlePadding = constants.mainPadding;
  static const double listContainerHeight = 200;
  static const String title = 'Upcoming';

  const UpcomingMovies({
    super.key,
    required this.upcomingMovies,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(titlePadding),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
        ),
        SizedBox(
          height: listContainerHeight,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: upcomingMovies.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (
              BuildContext context,
              int index,
            ) {
              return UpcomingMovieTile(
                movie: upcomingMovies[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
