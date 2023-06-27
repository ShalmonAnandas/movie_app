import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'screens/homescreen.dart';

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
  int _selectedIndex = 0;
  final _controller = NotchBottomBarController(index: 0);
  final _pageController = PageController(initialPage: 0);

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

  void _onItemtapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Player"),
        centerTitle: true,
      ),
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
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              Icons.home_filled,
              color: Colors.white,
            ),
            itemLabel: 'Home',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.movie_outlined,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              Icons.movie,
              color: Colors.white,
            ),
            itemLabel: 'Movie',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.tv_outlined,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              Icons.tv,
              color: Colors.white,
            ),
            itemLabel: 'TV',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.search_outlined,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              Icons.search,
              color: Colors.white,
            ),
            itemLabel: 'Search',
          ),
        ],
        onTap: (index) {
          _pageController.jumpToPage(_controller.index);
        },
        notchBottomBarController: _controller,
        durationInMilliSeconds: 200,
        showBlurBottomBar: true,
        blurOpacity: 0.2,
        notchColor: Colors.black,
        color: Colors.black87,
      ),
    );
  }
}
