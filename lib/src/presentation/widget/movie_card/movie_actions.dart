import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/routes/animated_route.dart';
import '../../../core/util/constants.dart' as constants;
import '../../../core/util/enums.dart';
import '../../../domain/entity/movie.dart';
import '../../bloc/saved_movies_bloc.dart';
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
  IconData savedIcon = Icons.bookmark_border;
  IconData starIcon = Icons.star_border;
  late SavedMoviesBloc bloc;
  late String snackBarText;
  late SnackBar snackBar;
  late bool inFavorites;
  late bool inWatchlist;

  void _toggleIcons(Endpoint endpoint) async {
    bloc.updateSaved(
      widget.movie.id,
      endpoint.title,
    );

    if (endpoint == Endpoint.watchlist) {
      inWatchlist = await bloc.isSaved(
        widget.movie.id,
        Endpoint.watchlist.title,
      );
      (inWatchlist)
          ? snackBarText = 'Removed from Watchlist'
          : snackBarText = 'Saved to Watchlist.';
    } else {
      inFavorites = await bloc.isSaved(
        widget.movie.id,
        Endpoint.favorites.title,
      );
      (inFavorites)
          ? snackBarText = 'Removed from Favorites'
          : snackBarText = 'Saved in Favorites.';
    }

    _setIcons();
    _updateSnackBar();
    _showSnackBar();
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

  void _setIcons() async {
    inFavorites = await bloc.isSaved(
      widget.movie.id,
      Endpoint.favorites.title,
    );
    inWatchlist = await bloc.isSaved(
      widget.movie.id,
      Endpoint.watchlist.title,
    );

    setState(() {
      (inFavorites) ? starIcon = Icons.star : starIcon = Icons.star_border;
      (inWatchlist)
          ? savedIcon = Icons.bookmark
          : savedIcon = Icons.bookmark_border;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of<SavedMoviesBloc>(context);
    _setIcons();
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
                      _toggleIcons(Endpoint.watchlist);
                    },
                  ),
                  SecondaryButton(
                    icon: starIcon,
                    onPressed: () {
                      _toggleIcons(Endpoint.favorites);
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
