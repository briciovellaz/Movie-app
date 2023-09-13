import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart';

import '../../core/parameter/i_api_parameter.dart';
import '../../core/util/data_state.dart';
import '../../core/util/enums.dart';
import '../../core/util/strings.dart' as strings;
import '../../domain/entity/movie.dart';
import '../../domain/repository/repository.dart';
import '../datasource/remote/movies_service.dart';
import '../model/movie_data_handler.dart';

class MovieRepository implements IRepository<DataState<List<Movie>>> {
  late final MovieService movieService;
  final String moviesFilePath = 'assets/data/movies.json';
  late DataState<List<Movie>> _movies;

  MovieRepository({MovieService? movieService})
      : movieService = movieService ?? MovieService();

  @override
  Future<void> fetchData() async {
    final moviesFile = await rootBundle.loadString(moviesFilePath);
    final moviesData = json.decode(moviesFile);
    final List<MovieDataHandler> remoteMovies =
        List.from(moviesData.map((data) => MovieDataHandler.fromJson(data)));
    final DataState<List<Movie>> movies =
        DataSuccess(remoteMovies.map((movie) => movie.toModel()).toList());
    _movies = movies;
  }

  @override
  Future<DataState<List<Movie>>> getAll() async {
    if (_movies.state == ElementState.success) {
      if (_movies.data!.isEmpty) {
        await fetchData();
      }
    }
    return _movies;
  }

  Future<DataState<List<Movie>>> getMovies({
    IApiParameters? params,
    required Endpoint endpoint,
    int? id,
  }) async {
    late final Response response;
    switch (endpoint) {
      case Endpoint.discover:
        response = await movieService.discover(params!.discoverParams);
        break;
      case Endpoint.search:
        response = await movieService.getMatchingSearch(
          params!.searchParams,
        );
        break;
      case Endpoint.recommended:
        response = await movieService.getRelatedMovies(
          id: id!,
          category: endpoint,
        );
        break;
      case Endpoint.similar:
        response = await movieService.getRelatedMovies(
          id: id!,
          category: endpoint,
        );
        break;
      default:
        response = await movieService.getMoviesList(
          params!.listParams,
          category: endpoint,
        );
        break;
    }
    return handleResponse(response);
  }

  Future<DataState<List<Movie>>> handleResponse(Response response) async {
    if (response.statusCode == HttpStatus.ok) {
      final moviesData = jsonDecode(response.body)['results'];
      final moviesDataFiltered = _filterNulls(moviesData);
      final List<MovieDataHandler> movies = List.from(
        moviesDataFiltered.map((data) => MovieDataHandler.fromJson(data)),
      );
      return DataSuccess(movies.map((movie) => movie.toModel()).toList());
    } else {
      return DataFailed(strings.apiErrorMessage);
    }
  }

  dynamic _filterNulls(dynamic json) => List.from(
        json.where((data) => !data.containsValue(null)),
      );
}
