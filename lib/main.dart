import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'src/core/util/dependencies.dart';
import 'src/core/util/strings.dart' as strings;
import 'src/data/repository/themes_repository.dart';
import 'src/presentation/view/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Dependencies dependencies = Dependencies();
  await dependencies.load();
  await dependencies.initialize();
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => dependencies.moviesBloc),
        Provider(create: (_) => dependencies.genresByIdBloc),
      ],
      child: MyApp(),
    ),
  );
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
  }

  @override
  void dispose() {
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
