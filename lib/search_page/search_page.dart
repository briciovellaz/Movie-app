import 'package:flutter/material.dart';

import '../constants/constants.dart' as constants;
import '../constants/strings.dart' as strings;
import '../movie.dart';
import '../movie_repository.dart';
import '../search_page/searched_list.dart';

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
  late final movies = MovieRepository().getAll();

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                setState(() {
                  toSearch = content;
                });
              },
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
            ),
            Expanded(
              child: FutureBuilder(
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
                    return ListView(
                      children: [
                        SearchedList(
                          movies: movies,
                          toSearch: toSearch,
                        ),
                      ],
                    );
                  }
                  return const Text(strings.noDataErrorText);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
