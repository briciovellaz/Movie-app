import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'src/core/util/strings.dart' as strings;
import 'src/data/datasource/local/movie_database.dart';
import 'src/data/repository/database_movie_repository.dart';
import 'src/data/repository/movie_repository.dart';
import 'src/data/repository/themes_repository.dart';
import 'src/domain/usecase/implementation/get_movies_usecase.dart';
import 'src/presentation/bloc/genres_bloc.dart';
import 'src/presentation/bloc/movies_bloc.dart';
import 'src/presentation/view/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  final ThemesRepository themesRepository = ThemesRepository();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Map<String, ThemeData> themes = widget.themesRepository.getAll();

  @override
  void initState() {
    super.initState();
    widget.themesRepository.fetchData();
    _loadDependencies();
    _initializeBLoCs();
  }

  void _loadDependencies() async {
    final MovieRepository movieRepository = MovieRepository();
    final MovieDatabase database= await $FloorMovieDatabase.databaseBuilder(strings.databaseName).build();
    MovieDatabaseRepository databaseRepository =
        MovieDatabaseRepository(database);
    Get.put<MoviesBloc>(
      MoviesBloc(
        usecase: GetMoviesUseCase(
          remoteRepository: movieRepository,
          databaseRepository: databaseRepository,
        ),
      ),
    );
  }

  void _initializeBLoCs() {
    GenresBloc().initialize();
    Get.find<MoviesBloc>().initialize();
  }

  @override
  void dispose() {
    Get.find<MoviesBloc>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: themes[strings.lightThemeName],
      darkTheme: themes[strings.darkThemeName],
      themeMode: ThemeMode.system,
      home: const Home(),
    );
  }
}
