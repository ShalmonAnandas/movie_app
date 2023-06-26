// ignore:

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'screens/homescreen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
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

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
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
        title: const Text("Movie App"),
        centerTitle: true,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: 'Home',
            backgroundColor: HexColor("#c47f68"),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.movie),
            label: 'Movie',
            backgroundColor: HexColor("#9e5555"),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.tv),
            label: 'TV',
            backgroundColor: HexColor("#B04759"),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.search),
            label: 'Search',
            backgroundColor: HexColor("#8BACAA"),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[100],
        onTap: _onItemtapped,
      ),
    );
  }
}
