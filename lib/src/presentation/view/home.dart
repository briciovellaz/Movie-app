import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/util/constants.dart' as constants;
import '../../core/util/strings.dart' as strings;
import '../../data/repository/themes_repository.dart';
import '../widget/custom_gradient.dart';
import '../widget/exit_alert.dart';
import 'saved_page.dart';
import 'search_page.dart';
import 'view_page.dart';

//TODO Make home button scroll to top if already in this view

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const int initialIndex = 0;
  static const double drawerOpacity = 0.5;
  static const double drawerHeaderHeight = 100;
  late int _selectedIndex;
  late List<Widget> _pages;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _selectedIndex = initialIndex;
    _pages = [
      ViewPage(),
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
            title: Text(
              strings.appName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            centerTitle: true,
            elevation: constants.appBarElevation,
            backgroundColor: Colors.transparent,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: customGradient(),
              ),
            ),
          ),
          drawer: Drawer(
            backgroundColor:
                Theme.of(context).colorScheme.background.withOpacity(drawerOpacity),
            child: Column(
              children: [
                SizedBox(
                  height: drawerHeaderHeight,
                  width: double.maxFinite,
                  child: DrawerHeader(
                    padding: EdgeInsets.zero,
                    child: Container(
                      color: Theme.of(context).colorScheme.background,
                      child: Center(
                        child: Text(
                          strings.appName,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                const Divider(),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: constants.mainPadding),
                  alignment: Alignment.bottomCenter,
                  color: Theme.of(context).colorScheme.background,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(constants.mainPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(strings.switchThemeText, style: Theme.of(context).textTheme.titleMedium,),
                          Switch.adaptive(
                            activeColor: ThemesRepository.themes[strings.darkThemeName]!.colorScheme.primary,
                            inactiveThumbColor: ThemesRepository.themes[strings.lightThemeName]!.colorScheme.primary,
                            value: Get.isDarkMode,
                            onChanged: (value) {
                              Get.changeThemeMode(
                                Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
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
