import 'package:flutter/material.dart';
import '../movie.dart';
import 'movie_play_trailer_button.dart';
import 'movie_like_counter.dart';
import 'movie_secondary_button.dart';

class MovieActions extends StatelessWidget {
  const MovieActions({
    super.key,
    required this.movie,
    required this.counter,
  });

  final Movie movie;
  final int counter;
  static const int counterFlex = 1;
  static const int buttonsBarFlex = 3;
  static const int mainActionFlex = 3;
  static const double mainActionPadding = 10;
  static const double avgVotesFontSize = 12;
  static const double releaseDateFontSize=15;
  static const String averageRatingPrefix = 'Avg. vote: ';

  @override
  Widget build(BuildContext context) {
    final String averageRating = movie.voteAverage;
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              flex: mainActionFlex,
              child: Padding(
                padding: EdgeInsets.all(mainActionPadding),
                child: PlayTrailerButton(),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calendar_month,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  Text(
                    movie.releaseDate,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: releaseDateFontSize,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Expanded(
              flex: buttonsBarFlex,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SecondaryButton(icon: Icons.list),
                  SecondaryButton(icon: Icons.bookmark_border),
                  SecondaryButton(icon: Icons.star_border),
                ],
              ),
            ),
            Expanded(
              flex: counterFlex,
              child: Column(
                children: [
                  LikeCounter(
                    counter: counter,
                  ),
                  Text(
                    '$averageRatingPrefix$averageRating',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: avgVotesFontSize),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
