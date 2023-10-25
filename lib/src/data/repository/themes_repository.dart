import 'dart:convert';

import 'package:flutter/material.dart';

import '../../config/themes/themes.dart';
import '../model/theme_model.dart';

class ThemesRepository {
  static Map<String, ThemeData> themes = {};

  Future<void> fetchData() async {
    String encodedJson = jsonEncode(themesJson);
    final themesData = jsonDecode(encodedJson)['themes'];
    final List<ThemeModel> themeModels =
        List.from(themesData.map((data) => ThemeModel.fromJson(data)));
    for (var element in themeModels) {
      themes[element.name] = element.themeData;
    }
  }

  Map<String, ThemeData> getAll() {
    if (themes.isEmpty) {
      fetchData();
    }
    return themes;
  }
}
