// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:movie_app/screens/watchmoviescreen.dart';
import 'package:movie_app/screens/watchshowscreen.dart';
import 'package:movie_app/utils/getmovies.dart';
import 'package:movie_app/utils/getshows.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GetMovies getTrendingMoviesObj = GetMovies();
  GetShows getTrendingShowsObj = GetShows();

  @override
  void initState() {
    super.initState();
  }

  getMovies() async {
    return getTrendingMoviesObj.getTrendingMovies();
  }

  getShows() async {
    return getTrendingShowsObj.getTrendingShows();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding:
                EdgeInsets.only(left: 10.0, right: 10, top: 55, bottom: 10),
            child: Center(
                child: Text(
              "Trending Today",
              style: TextStyle(fontSize: 30),
            )),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Movies",
              style: TextStyle(fontSize: 20),
            ),
          ),
          TrendingMovies(),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Shows",
              style: TextStyle(fontSize: 20),
            ),
          ),
          TrendingShows(),
          const SizedBox(height: 100)
        ],
      ),
    );
  }

  FutureBuilder<dynamic> TrendingMovies() {
    return FutureBuilder(
      future: getMovies(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        Widget children;
        if (snapshot.hasData) {
          children = SizedBox(
            height: 305,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WatchMovieScreen(
                          id: snapshot.data[index].id,
                        ),
                      ),
                    );
                  },
                  child: SizedBox(
                    width: 200,
                    child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w600_and_h900_bestv2${snapshot.data[index].posterPath}',
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          children = SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return children;
      },
    );
  }

  FutureBuilder<dynamic> TrendingShows() {
    return FutureBuilder(
      future: getShows(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        Widget children;
        if (snapshot.hasData) {
          children = SizedBox(
            height: 305,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WatchShowScreen(
                          id: snapshot.data[index].id,
                        ),
                      ),
                    );
                  },
                  child: SizedBox(
                    width: 200,
                    child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w600_and_h900_bestv2${snapshot.data[index].posterPath}',
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          children = SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return children;
      },
    );
  }
}
