import 'package:flutter/material.dart';
import 'package:movie_app/utils/getmovies.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GetMovies getMoviesObj = GetMovies();

  @override
  void initState() {
    super.initState();
    getMoviesObj.getTrendingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
