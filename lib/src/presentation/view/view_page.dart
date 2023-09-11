import 'package:flutter/material.dart';

import '../../core/util/strings.dart' as strings;
import '../../data/model/movie_data_handler.dart';
import '../../data/repository/movie_repository.dart';
import '../../domain/entity/movie.dart';
import '../../domain/entity/movie_category.dart';
import '../widget/home_page/home_categories_list.dart';
import '../widget/home_page/upcoming_movies_list.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({super.key});

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final Future<List<Movie>> movies = MovieRepository().getAll();

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return FutureBuilder(
      future: movies,
      builder: (
        BuildContext context,
        AsyncSnapshot<List<Movie>> snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasData) {
          var movies = snapshot.data as List<Movie>;
          List<MovieCategory> categories = <MovieCategory>[
            MovieCategory(
              movies: [
                MovieDataHandler.mockMovie(),
                MovieDataHandler.mockMovie(),
                MovieDataHandler.mockMovie(),
              ],
              name: 'Last released',
            ),
            MovieCategory(
              movies: movies,
              name: 'Trending',
            ),
          ];
          return SizedBox(
            child: ListView(
              children: [
                UpcomingMovies(
                  upcomingMovies: movies,
                ),
                CategoriesList(
                  categories: categories,
                ),
              ],
            ),
          );
        }
        return const Text(strings.noDataErrorText);
      },
    );
  }
}
