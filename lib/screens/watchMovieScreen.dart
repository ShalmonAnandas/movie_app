import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/models/movieModel.dart';
import 'package:movie_app/utils/VidSrcExtractor.dart';
import 'package:movie_app/utils/getIndividual.dart';
import 'package:movie_app/widgets/similarMediaWidget.dart';
import 'package:url_launcher/url_launcher.dart';

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
    MovieModel tempModel = await getMoviesObj.getIndividualDetails(widget.id, "movie");
    setState(() {
      currentMovieModel = tempModel;
    });
    return tempModel;
  }

  Future<void> _launchInBrowser(String url) async {
    print(url);
    if (!await launchUrl(
      Uri.parse('vlc://$url'),
      mode: LaunchMode.externalNonBrowserApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.popUntil(context, (route) => route.isFirst);
        return true;
      },
      child: FutureBuilder(
        future: getCurrentMovieModel(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
              ),
              floatingActionButton: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.white10, Colors.white60, Colors.white],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 10, top: 10),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: () {
                        VidSrcExtractor.extract('https://vidsrc.me/embed/movie?tmdb=${snapshot.data!.id}').then(
                          (value) {
                            if (value != null) {
                              // Fluttertoast.showToast(msg: "link found");
                              _launchInBrowser(value);
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => VideoPlayer(
                              //       name: snapshot.data!.title,
                              //       url: value,
                              //     ),
                              //   ),
                              // );
                            } else {
                              Fluttertoast.showToast(msg: "NOT FOUND");
                            }
                          },
                        );
                      },
                      child: Text(
                        "Watch Now",
                        style: GoogleFonts.quicksand(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              body: Container(
                height: MediaQuery.of(context).size.height,
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
                        colors: [Colors.transparent, Colors.white60, Colors.white],
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
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
                                style: GoogleFonts.quicksand(fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          ExpansionTile(
                            initiallyExpanded: true,
                            title: Text(
                              "Synopsis",
                              style: GoogleFonts.quicksand(fontWeight: FontWeight.w900),
                            ),
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0, bottom: 10, right: 10),
                                child: Text(
                                  snapshot.data?.overview ?? "{{overview}}",
                                  style: GoogleFonts.quicksand(fontWeight: FontWeight.w700),
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
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
