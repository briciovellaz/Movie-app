import 'package:flutter/material.dart';
import '../genres_repository.dart';
import '../home_page/home.dart';
import 'movie_repository.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({
    super.key,
  });

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Widget _body = const SafeArea(
    child: Center(
      child: SizedBox(
        child: CircularProgressIndicator(),
      ),
    ),
  );

  @override
  void initState(){
    super.initState();
    _loadHomeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return _body;
  }

  void _loadHomeScreen() async {
    await GenresRepository().fetchData();
    await MovieRepository().fetchData();
    setState(
          () {
            _body = const Home();
      },
    );
  }
}
