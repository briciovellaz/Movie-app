import 'dart:convert';

import 'package:flutter/services.dart';

import 'genre.dart';
import 'genre_data_handler.dart';
import 'repository.dart';

class GenresRepository implements IRepository<Genre> {
  final String genresFilePath = 'assets/data/genres.json';
  static List<Genre> _genres = [];

  @override
  Future<void> fetchData() async {
    final genresFile = await rootBundle.loadString(genresFilePath);
    final genresData = await json.decode(genresFile)['genres'];
    final List<GenreDataHandler> remoteGenres =
        List.from(genresData.map((genre) => GenreDataHandler.fromJson(genre)));
    _genres = remoteGenres.map((genre) => genre.toModel()).toList();
  }

  @override
  Future<List<Genre>> getAll() async {
    if (_genres.isEmpty) {
      await fetchData();
    }
    return _genres;
  }

  Future<List<Genre>> getFromIds(List<int> ids) async {
    if (_genres.isEmpty) {
      fetchData();
    }
    return List<Genre>.from(_genres.where((genre) => ids.contains(genre.id)));
  }
}
