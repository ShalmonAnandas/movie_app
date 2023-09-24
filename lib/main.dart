import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/screens/HomeScreen.dart';
import 'package:movie_app/screens/trendingMovieScreen.dart';
import 'package:movie_app/screens/trendingShowScreen.dart';
import 'package:movie_app/screens/underConstructionScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Please',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        canvasColor: const Color.fromARGB(255, 232, 234, 222),
      ),
      home: const MainScreen(),
    );
  }
}

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
        bottomNavigationBar: FlashyTabBar(
          showElevation: true,
          animationCurve: Curves.linear,
          selectedIndex: _selectedIndex,
          iconSize: 30,
          onItemSelected: (index) => setState(() {
            _selectedIndex = index;
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
