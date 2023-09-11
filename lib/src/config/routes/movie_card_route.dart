import 'package:flutter/material.dart';

import '../../core/util/constants.dart' as constants;
import '../../domain/entity/movie.dart';
import '../../presentation/view/movie_card.dart';

Route movieCardRoute(Movie movie) {
  return PageRouteBuilder(
    transitionDuration: const Duration(
      milliseconds: constants.transitionDurationMs,
    ),
    reverseTransitionDuration: const Duration(
      milliseconds: constants.transitionDurationMs,
    ),
    pageBuilder: (
      context,
      animation,
      secondaryAnimation,
    ) =>
        MovieCard(movie: movie),
    transitionsBuilder: (
      context,
      animation,
      secondaryAnimation,
      child,
    ) {
      const begin = Offset(
        constants.transitionXOffset,
        constants.transitionYOffset,
      );
      const end = Offset.zero;
      const curve = Curves.linear;

      var tween = Tween(
        begin: begin,
        end: end,
      ).chain(
        CurveTween(curve: curve),
      );

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
