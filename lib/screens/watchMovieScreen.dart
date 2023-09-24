import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/models/movieModel.dart';
import 'package:movie_app/screens/playMovieScreen.dart';
import 'package:movie_app/utils/getIndividual.dart';
import 'package:movie_app/widgets/similarMediaWidget.dart';

import '../widgets/castWidget.dart';

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
  GetIndividual getMoviesObj = GetIndividual();
  MovieModel? currentMovieModel;
  var movieModel;

  @override
  void initState() {
    movieModel = getCurrentMovieModel();
    super.initState();
  }

  getCurrentMovieModel() async {
    MovieModel tempModel =
        await getMoviesObj.getIndividualDetails(widget.id, "movie");
    setState(() {
      currentMovieModel = tempModel;
    });
    return tempModel;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
                        'https://image.tmdb.org/t/p/w600_and_h900_bestv2${snapshot.data?.posterPath}',
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
                          colors: [
                            Colors.transparent,
                            Colors.white60,
                            Colors.white
                          ],
                        ),
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
                          elevation: 30,
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w600_and_h900_bestv2${snapshot.data?.posterPath}',
                            height: 400,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Center(
                          child: Text(
                            snapshot.data?.title ?? "Movie Name",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.quicksand(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      ExpansionTile(
                        title: Text(
                          "Synopsis",
                          style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.w900),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, bottom: 10, right: 10),
                            child: Text(
                              snapshot.data?.overview ?? "{{overview}}",
                              style: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.w700),
                            ),
                          )
                        ],
                      ),
                      SimilarMoviesWidget(id: widget.id, mediaType: "movie"),
                      CastWidget(
                        id: widget.id,
                        mediaType: "movie",
                      ),
                      const SizedBox(
                        height: 100,
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 15),
                          child: SizedBox(
                            width: 3000,
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MoviePlayer(
                                      id: snapshot.data!.id,
                                      name: snapshot.data!.title,
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                "Watch Now",
                                style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.w700),
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
