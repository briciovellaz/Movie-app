import 'package:flutter/material.dart';

import '../../../config/routes/animated_route.dart';
import '../../../core/util/constants.dart' as constants;
import '../../../domain/entity/movie.dart';
import '../../view/similar_movies_list.dart';
import 'movie_like_counter.dart';
import 'movie_play_trailer_button.dart';
import 'movie_secondary_button.dart';

class MovieActions extends StatefulWidget {
  const MovieActions({
    super.key,
    required this.movie,
  });

  final Movie movie;
  static const int counterFlex = 1;
  static const int buttonsBarFlex = 3;
  static const int mainActionFlex = 3;
  static const double avgVotesFontSize = 12;
  static const double releaseDateFontSize = 15;
  static const String averageRatingPrefix = 'Avg. vote: ';

  @override
  State<MovieActions> createState() => _MovieActionsState();
}

class _MovieActionsState extends State<MovieActions> {
  static IconData savedIcon = Icons.bookmark_border;
  static IconData starIcon = Icons.star_border;
  late String snackBarText;
  late SnackBar snackBar;

  void _toggleSaved() {
    setState(() {
      (savedIcon == Icons.bookmark_border)
          ? {savedIcon = Icons.bookmark, snackBarText = 'Saved to watchlist.'}
          : {
              savedIcon = Icons.bookmark_border,
              snackBarText = 'Removed from watchlist.',
            };
    });
    _updateSnackBar();
  }

  void _toggleStar() {
    setState(() {
      (starIcon == Icons.star_border)
          ? {starIcon = Icons.star, snackBarText = 'Saved to favorites.'}
          : {
              starIcon = Icons.star_border,
              snackBarText = 'Removed from favorites.',
            };
    });
    _updateSnackBar();
  }

  void _updateSnackBar() {
    snackBar = SnackBar(
      content: Text(snackBarText),
      duration: const Duration(seconds: 1),
    );
  }

  void _showSnackBar() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final String averageRating = widget.movie.voteAverage.toString();
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              flex: MovieActions.mainActionFlex,
              child: Padding(
                padding: EdgeInsets.all(constants.mainPadding),
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
                    widget.movie.releaseDate,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: MovieActions.releaseDateFontSize,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: MovieActions.buttonsBarFlex,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SecondaryButton(
                    icon: Icons.list,
                    onPressed: () {
                      Navigator.push(
                        context,
                        animatedRoute(SimilarMoviesList(id: widget.movie.id)),
                      );
                    },
                  ),
                  SecondaryButton(
                    icon: savedIcon,
                    onPressed: () {
                      _toggleSaved();
                      _showSnackBar();
                    },
                  ),
                  SecondaryButton(
                    icon: starIcon,
                    onPressed: () {
                      _toggleStar();
                      _showSnackBar();
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              flex: MovieActions.counterFlex,
              child: Column(
                children: [
                  LikeCounter(
                    counter: widget.movie.voteCount,
                  ),
                  Text(
                    '${MovieActions.averageRatingPrefix}$averageRating',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: MovieActions.avgVotesFontSize),
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
