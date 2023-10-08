// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/screens/watchMovieScreen.dart';
import 'package:movie_app/utils/getTrending.dart';

import '../utils/DataConstants.dart';

class TrendingMovieScreen extends StatefulWidget {
  const TrendingMovieScreen({super.key});

  @override
  State<TrendingMovieScreen> createState() => _TrendingMovieScreenState();
}

class _TrendingMovieScreenState extends State<TrendingMovieScreen> {
  GetTrending getTrendingMoviesObj = GetTrending();

  @override
  void initState() {
    super.initState();
  }

  getMovies() async {
    return getTrendingMoviesObj.getTrending("movie");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Trending Movies",
          style:
              GoogleFonts.quicksand(fontSize: 30, fontWeight: FontWeight.w500),
        ),
      ),
      body: FutureBuilder(
        future: getMovies(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          Widget children;
          if (snapshot.hasData) {
            children = GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 0.65),
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data.length - 2,
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
            );
          } else {
            children = SizedBox(
              height: MediaQuery.of(context).size.height,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return children;
        },
      ),
    );
  }
}
