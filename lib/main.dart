import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'screens/homeScreen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
      home: const HomeNavigationBar(),
    );
  }
}

class HomeNavigationBar extends StatefulWidget {
  const HomeNavigationBar({super.key});

  @override
  State<HomeNavigationBar> createState() => _HomeNavigationBarState();
}

class _HomeNavigationBarState extends State<HomeNavigationBar> {
  final _controller = NotchBottomBarController(index: 0);
  final _pageController = PageController(initialPage: 0);
  final List<String> appBarTitle = ["Trending", "Movies", "Shows", "Search"];

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    Text(
      'Movie',
      style: optionStyle,
    ),
    Text(
      'TV',
      style: optionStyle,
    ),
    Text(
      'Search',
      style: optionStyle,
    )
  ];

  @override
  Widget build(BuildContext context) {
    var theme = ThemeData();
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(appBarTitle[_selectedIndex]),
      //   centerTitle: true,
      // ),
      body: PageView(
        controller: _pageController,
        children: _widgetOptions,
        onPageChanged: (context) => setState(() {
          _controller.index = context;
        }),
      ),
      extendBody: true,
      bottomNavigationBar: AnimatedNotchBottomBar(
        bottomBarItems: const [
          BottomBarItem(
            inActiveItem: Icon(
              Icons.home,
              color: Colors.deepPurple,
            ),
            activeItem: Icon(
              Icons.home_filled,
              color: Colors.deepPurpleAccent,
            ),
            itemLabel: 'Home',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.movie_outlined,
              color: Colors.deepPurple,
            ),
            activeItem: Icon(
              Icons.movie,
              color: Colors.deepPurpleAccent,
            ),
            itemLabel: 'Movie',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.tv_outlined,
              color: Colors.deepPurple,
            ),
            activeItem: Icon(
              Icons.tv,
              color: Colors.deepPurpleAccent,
            ),
            itemLabel: 'TV',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.search_outlined,
              color: Colors.deepPurple,
            ),
            activeItem: Icon(
              Icons.search,
              color: Colors.deepPurpleAccent,
            ),
            itemLabel: 'Search',
          ),
        ],
        onTap: (index) {
          _pageController.jumpToPage(_controller.index);
        },
        notchBottomBarController: _controller,
        durationInMilliSeconds: 200,
        notchColor: Colors.black,
        color: Colors.black87,
      ),
    );
  }
}
