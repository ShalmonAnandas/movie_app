// ignore: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:movie_app/screens/watchmoviescreen.dart';
import 'package:movie_app/utils/getmovies.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GetTrending getTrendingObj = GetTrending();

  @override
  void initState() {
    super.initState();
  }

  getMovies() async {
    return getTrendingObj.getTrendingMovies();
  }

  getShows() async {
    return getTrendingObj.getTrendingShows();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Trending Movies",
              style: TextStyle(fontSize: 30),
            ),
          ),
          TrendingMovies(),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Trending Shows",
              style: TextStyle(fontSize: 30),
            ),
          ),
          TrendingShows()
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WatchMovieScreen(
                          movieModel: snapshot.data[index],
                        ),
                      ),
                    );
                  },
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w600_and_h900_bestv2${snapshot.data[index].posterPath}',
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          children = const CircularProgressIndicator();
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
                return Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w600_and_h900_bestv2${snapshot.data[index].posterPath}',
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                );
              },
            ),
          );
        } else {
          children = const CircularProgressIndicator();
        }
        return children;
      },
    );
  }
}
