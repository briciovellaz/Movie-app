import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/parameter/movie_parameters.dart';
import '../../core/util/constants.dart' as constants;
import '../../core/util/debouncer.dart';
import '../../core/util/enums.dart';
import '../../core/util/strings.dart' as strings;
import '../../domain/entity/event/implementation/movie_event.dart';
import '../../domain/entity/movie.dart';
import '../bloc/movies_bloc.dart';
import '../widget/search_page/no_match.dart';
import '../widget/vertical_movies_list.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    super.key,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  String toSearch = strings.emptyString;
  final _controller = TextEditingController();
  late MoviesBloc bloc;
  final Debouncer debouncer = Debouncer(
    delay: const Duration(milliseconds: 500),
  );

  void _onSearchChanged(String query) {
    debouncer.call(
      () {
        setState(
          () {
            toSearch = query;
            bloc.fetchMovies(
              endpoint: Endpoint.search,
              params: MovieParameters.search(query: toSearch),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    bloc = Provider.of<MoviesBloc>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.all(constants.mainPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: strings.searchFieldText,
                hintStyle: Theme.of(context).textTheme.bodyMedium,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _controller.clear();
                      toSearch = strings.emptyString;
                    });
                  },
                  icon: const Icon(Icons.clear),
                ),
                suffixIconColor: Theme.of(context).colorScheme.primary,
              ),
              onChanged: (content) {
                _onSearchChanged(content);
              },
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
            ),
            if (toSearch.isEmpty)
              const Expanded(
                child: Column(
                  children: [
                    Center(
                      child: Text(strings.emptySearch),
                    ),
                  ],
                ),
              ),
            if (toSearch.isNotEmpty)
              Expanded(
                child: StreamBuilder<MovieEvent>(
                  initialData: MovieEvent.loading(),
                  stream: bloc.filteredMovies,
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<MovieEvent> snapshot,
                  ) {
                    switch (snapshot.data?.state) {
                      case ElementState.success:
                        var movies = snapshot.data?.data as List<Movie>;
                        return ListView(
                          children: [
                            VerticalMoviesList(
                              movies: movies,
                              physics: const NeverScrollableScrollPhysics(),
                            ),
                          ],
                        );
                      case ElementState.empty:
                        return const Text(strings.noDataErrorText);
                      case ElementState.failure:
                        return Text(snapshot.data!.error!);
                      case ElementState.loading:
                        return const Center(child: CircularProgressIndicator());
                      default:
                    }
                    return const NoMatchAlert();
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
