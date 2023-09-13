import 'package:flutter/material.dart';

import '../../core/util/constants.dart' as constants;

Route animatedRoute(Widget widget) {
  return PageRouteBuilder(
    transitionDuration: const Duration(
      milliseconds: constants.transitionDurationMs,
    ),
    reverseTransitionDuration: const Duration(
      milliseconds: constants.transitionDurationMs,
    ),
    pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) =>
        widget,
    transitionsBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
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
