import 'dart:convert';

import 'package:flutter/services.dart';

import '../../domain/entity/movie.dart';
import '../../domain/repository/repository.dart';
import '../model/movie_data_handler.dart';

class MovieRepository implements IRepository<Movie> {
  final String moviesFilePath = 'assets/data/movies.json';
  static List<Movie> _movies = [];

  @override
  Future<void> fetchData() async {
    final moviesFile = await rootBundle.loadString(moviesFilePath);
    final moviesData = json.decode(moviesFile);
    final List<MovieDataHandler> remoteMovies =
        List.from(moviesData.map((data) => MovieDataHandler.fromJson(data)));
    final List<Movie> movies =
        remoteMovies.map((movie) => movie.toModel()).toList();
    _movies = movies;
  }

  @override
  Future<List<Movie>> getAll() async {
    if (_movies.isEmpty) {
      await fetchData();
    }
    return _movies;
  }

  Future<Movie> getFromId(int id) async {
    if (_movies.isEmpty) {
      await fetchData();
    }
    return _movies.firstWhere((movie) => id == (movie.id));
  }
}
