import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/parameter/movie_parameters.dart';
import '../../core/util/enums.dart';
import '../../core/util/strings.dart' as strings;
import '../../domain/entity/event/implementation/movie_event.dart';
import '../../domain/entity/genre.dart';
import '../../domain/entity/movie.dart';
import '../bloc/movies_bloc.dart';
import '../widget/detailed_list_item.dart';

class GenreList extends StatefulWidget {
  final Genre genre;
  static const double listHorizontalPadding = 8;

  const GenreList({
    super.key,
    required this.genre,
  });

  @override
  State<GenreList> createState() => _GenreListState();
}

class _GenreListState extends State<GenreList> {
  final MoviesBloc bloc = Get.find();

  @override
  void initState() {
    super.initState();
    bloc.fetchMovies(
      params: MovieParameters.discover(genre: widget.genre.id.toString()),
      endpoint: Endpoint.discover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.genre.name),
          leading: BackButton(
            color: Theme.of(context).colorScheme.onPrimary,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: StreamBuilder<MovieEvent>(
          stream: bloc.moviesByGenre,
          builder: (
            BuildContext context,
            AsyncSnapshot<MovieEvent> snapshot,
          ) {
            switch (snapshot.data?.state) {
              case ElementState.success:
                var movies = snapshot.data?.data as List<Movie>;
                return Scaffold(
                  body: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: GenreList.listHorizontalPadding,
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: movies.length,
                      itemBuilder: (
                        BuildContext context,
                        int index,
                      ) {
                        return DetailedListItem(
                          movie: movies[index],
                        );
                      },
                    ),
                  ),
                );
              case ElementState.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ElementState.empty:
                return const Text(strings.noDataErrorText);
              case ElementState.failure:
                return const Text(strings.apiErrorMessage);
              default:
                break;
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
