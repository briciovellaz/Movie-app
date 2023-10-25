import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/util/strings.dart' as strings;
import '../../data/repository/themes_repository.dart';

LinearGradient customGradient({
  AlignmentGeometry begin = Alignment.topCenter,
  AlignmentGeometry end = Alignment.bottomCenter,
}) {

  Map<String, ThemeData> themes = ThemesRepository().getAll();

  List<Color> darkColors = [
    themes[strings.darkThemeName]!.colorScheme.primary,
    themes[strings.darkThemeName]!.colorScheme.background,
    themes[strings.darkThemeName]!.colorScheme.background.withOpacity(0.5),
    themes[strings.darkThemeName]!.colorScheme.background.withOpacity(0.05),
    Colors.transparent,
  ];

  List<Color> lightColors = [
    themes[strings.lightThemeName]!.colorScheme.primary,
    themes[strings.lightThemeName]!.colorScheme.background,
    themes[strings.lightThemeName]!.colorScheme.background.withOpacity(0.5),
    themes[strings.lightThemeName]!.colorScheme.background.withOpacity(0.05),
    Colors.transparent,
  ];

  return LinearGradient(
    begin: begin,
    end: end,
    colors: (Get.isDarkMode) ? darkColors : lightColors,
  );
}
