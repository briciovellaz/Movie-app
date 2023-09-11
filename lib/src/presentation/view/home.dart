import 'package:flutter/material.dart';

import '../../core/util/constants.dart' as constants;
import '../../core/util/strings.dart' as strings;
import '../widget/exit_alert.dart';
import 'saved_page.dart';
import 'search_page.dart';
import 'view_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const int initialIndex = 0;
  late int _selectedIndex;
  late List<Widget> _pages;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _selectedIndex = initialIndex;
    _pages = [
      const ViewPage(),
      const SearchPage(),
      const SavedPage(),
    ];
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  Future<bool> _checkExit() async {
    if (_selectedIndex != initialIndex) {
      setState(() {
        _selectedIndex = initialIndex;
        _pageController.jumpToPage(_selectedIndex);
      });
      return false;
    } else {
      final shouldPop = await showDialog<bool>(
        context: context,
        builder: (context) {
          return const ExitAlert();
        },
      );
      return shouldPop ?? false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return _checkExit();
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          extendBodyBehindAppBar: _selectedIndex == initialIndex,
          appBar: AppBar(
            title: const Text(
              strings.appName,
            ),
            centerTitle: true,
            elevation: constants.appBarElevation,
            backgroundColor: Colors.transparent,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: constants.mainGradientColors,
                ),
              ),
            ),
          ),
          body: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: _pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Theme.of(context).colorScheme.background,
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
                _pageController.jumpToPage(index);
              });
            },
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_border),
                label: 'Saved',
              ),
            ],
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
