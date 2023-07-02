import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_app/models/moviemodel.dart';
import 'package:movie_app/utils/getcast.dart';
import 'package:movie_app/utils/getmovies.dart';

class WatchMovieScreen extends StatefulWidget {
  final int id;

  const WatchMovieScreen({
    super.key,
    required this.id,
  });

  @override
  State<WatchMovieScreen> createState() => _WatchMovieScreenState();
}

class _WatchMovieScreenState extends State<WatchMovieScreen> {
  GetCast getCastObj = GetCast();
  GetMovies getMoviesObj = GetMovies();
  MovieModel? currentMovieModel;

  @override
  void initState() {
    super.initState();
    getCastModels();
    getCurrentMovieModel();
  }

  getCastModels() async {
    return getCastObj.getCast(widget.id, "movie");
  }

  getCurrentMovieModel() async {
    MovieModel tempModel = await getMoviesObj.getMovieDetails(widget.id);
    setState(() {
      currentMovieModel = tempModel;
    });
    return tempModel;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: getCurrentMovieModel(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://image.tmdb.org/t/p/w600_and_h900_bestv2${snapshot.data.posterPath}',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black87]),
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 90,
                      ),
                      Center(
                        child: Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 50,
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w600_and_h900_bestv2${snapshot.data.posterPath}',
                            height: 400,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Center(
                          child: Text(
                            snapshot.data.title ?? "Movie Name",
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      ExpansionTile(
                        title: const Text("Synopsis"),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, bottom: 10, right: 10),
                            child:
                                Text(snapshot.data.overview ?? "{{overview}}"),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: FutureBuilder(
                          future: getCastModels(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            Widget children;
                            if (snapshot.hasData) {
                              children = SizedBox(
                                height: 180,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () {},
                                      child: SizedBox(
                                        width: 100,
                                        child: Card(
                                          elevation: 0,
                                          color: Colors.transparent,
                                          semanticContainer: true,
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          child: Column(
                                            children: [
                                              Image.network(
                                                'https://image.tmdb.org/t/p/w600_and_h900_bestv2${snapshot.data[index].profilePath}',
                                                fit: BoxFit.cover,
                                                height: 136,
                                              ),
                                              Text(
                                                snapshot.data[index].name
                                                    .split(" ")[0],
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                snapshot.data[index].name
                                                            .split(" ")
                                                            .length ==
                                                        1
                                                    ? ""
                                                    : snapshot.data[index].name
                                                        .split(" ")[1],
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
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
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 37),
                  child: BackButton(),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 120,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black87,
                                  Colors.black
                                ]),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 15),
                          child: SizedBox(
                            width: 3000,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                "Watch Now",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}