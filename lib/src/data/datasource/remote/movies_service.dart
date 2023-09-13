import 'package:http/http.dart';

import '../../../core/util/enums.dart';
import '../../../core/util/strings.dart';

class MovieService {
  Future<Response> getMoviesList(
    String params, {
    required Endpoint category,
  }) =>
      get(
        Uri.parse(
          '$apiBaseUrl/$apiVersion/$moviePath${category.endpoint}$params&$apiKey',
        ),
      );

  Future<Response> getRelatedMovies({
    required int id,
    required Endpoint category,
  }) =>
      get(
        Uri.parse(
          '$apiBaseUrl/$apiVersion/$moviePath/$id${category.endpoint}?$apiKey',
        ),
      );

  Future<Response> getMatchingSearch(String params) => get(
        Uri.parse(
          '$apiBaseUrl/$apiVersion${Endpoint.search.endpoint}/$moviePath$params&$apiKey',
        ),
      );

  Future<Response> discover(String params) => get(
        Uri.parse(
          '$apiBaseUrl/$apiVersion${Endpoint.discover.endpoint}/$moviePath$params&$apiSortByPop&$apiKey',
        ),
      );
}
