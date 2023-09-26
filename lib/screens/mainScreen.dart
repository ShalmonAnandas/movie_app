import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/screens/trendingMovieScreen.dart';
import 'package:movie_app/screens/trendingShowScreen.dart';
import 'package:movie_app/screens/underConstructionScreen.dart';

import '../utils/DataConstants.dart';
import 'WelcomeScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  List<Widget> tabItems = [
    const HomeScreen(),
    const TrendingMovieScreen(),
    const TrendingShowScreen(),
    const UnderConstructionScreen(
      title: "Settings",
    )
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            DataConstants.appBarTitle,
            style: GoogleFonts.quicksand(fontSize: 30, fontWeight: FontWeight.w500),
          ),
        ),
        bottomNavigationBar: FlashyTabBar(
          showElevation: true,
          animationCurve: Curves.linear,
          selectedIndex: _selectedIndex,
          iconSize: 30,
          onItemSelected: (index) => setState(() {
            _selectedIndex = index;
            if (index == 0) {
              DataConstants.appBarTitle = "Welcome Back";
            } else if (index == 1) {
              DataConstants.appBarTitle = "Trending Movies";
            } else if (index == 2) {
              DataConstants.appBarTitle = "Trending Shows";
            } else if (index == 3) {
              DataConstants.appBarTitle = "Settings";
            }
          }),
          items: [
            FlashyTabBarItem(
              icon: const Icon(Icons.home_outlined),
              title: const Text('Home'),
            ),
            FlashyTabBarItem(
              icon: const Icon(Icons.movie_outlined),
              title: const Text('Movies'),
            ),
            FlashyTabBarItem(
              icon: const Icon(Icons.tv),
              title: const Text('Shows'),
            ),
            FlashyTabBarItem(
              icon: const Icon(Icons.settings_outlined),
              title: const Text('Settings'),
            ),
          ],
        ),
        body: Center(
          child: tabItems[_selectedIndex],
        ),
      ),
    );
  }
}
