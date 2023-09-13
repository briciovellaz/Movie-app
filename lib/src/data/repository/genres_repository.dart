import 'dart:convert';
import 'dart:io';

import '../../core/util/data_state.dart';
import '../../core/util/enums.dart';
import '../../core/util/strings.dart' as strings;
import '../../domain/entity/genre.dart';
import '../../domain/repository/repository.dart';
import '../datasource/remote/genres_service.dart';
import '../model/genre_data_handler.dart';

class GenresRepository implements IRepository<DataState<List<Genre>>> {
  late final GenreService genreService;
  static DataState<List<Genre>> genres = DataSuccess(<Genre>[]);

  GenresRepository({GenreService? genreService})
      : genreService = genreService ?? GenreService();

  @override
  Future<void> fetchData() async {
    final response = await genreService.getMoviesGenres();

    if (response.statusCode == HttpStatus.ok) {
      final genresData = await json.decode(response.body)['genres'];
      final List<GenreDataHandler> remoteGenres = List.from(
        genresData.map(
          (genre) => GenreDataHandler.fromJson(genre),
        ),
      );
      genres =
          DataSuccess(remoteGenres.map((genre) => genre.toModel()).toList());
    } else {
      genres = DataFailed(strings.apiErrorMessage);
    }
  }

  bool hasGenres() =>
      (genres.state == ElementState.success) ? genres.data!.isNotEmpty : false;

  @override
  Future<DataState<List<Genre>>> getAll() async {
    if (!hasGenres()) {
      await fetchData();
    }
    return genres;
  }

  Future<DataState<List<Genre>>> getFromIds(List<int> ids) async {
    if (genres.state == ElementState.success) {
      if (genres.data!.isEmpty) {
        fetchData();
      }
      return DataSuccess(
        List<Genre>.from(
          genres.data!.where(
            (genre) => ids.contains(genre.id),
          ),
        ),
      );
    }
    return genres;
  }
}
