import 'package:flutter/material.dart';
import 'package:movie_app/screens/mainScreen.dart';

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
