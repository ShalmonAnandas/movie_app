import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_app/models/moviemodel.dart';
import 'package:movie_app/utils/getcast.dart';

class WatchMovieScreen extends StatefulWidget {
  final MovieModel? movieModel;
  const WatchMovieScreen({
    super.key,
    required this.movieModel,
  });

  @override
  State<WatchMovieScreen> createState() => _WatchMovieScreenState();
}

class _WatchMovieScreenState extends State<WatchMovieScreen> {
  GetCast getCastObj = GetCast();

  @override
  void initState() {
    super.initState();
    getCastModels();
  }

  getCastModels() async {
    return getCastObj.getCast(widget.movieModel?.id ?? 00000);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://image.tmdb.org/t/p/w600_and_h900_bestv2${widget.movieModel?.posterPath}',
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
                      colors: [Colors.transparent, Colors.black]),
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
                      'https://image.tmdb.org/t/p/w600_and_h900_bestv2${widget.movieModel?.posterPath}',
                      height: 400,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Center(
                    child: Text(
                      widget.movieModel?.title ?? "Movie Name",
                      style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                ExpansionTile(
                  title: const Text("Synopsis"),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, bottom: 10, right: 10),
                      child: Text(widget.movieModel?.overview ?? "{{overview}}"),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: FutureBuilder(
                    future: getCastModels(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      Widget children;
                      if (snapshot.hasData) {
                        children = SizedBox(
                          height: 180,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {},
                                child: SizedBox(
                                  child: Card(
                                    semanticContainer: true,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: Column(
                                      children: [
                                        Image.network(
                                          'https://image.tmdb.org/t/p/w600_and_h900_bestv2${snapshot.data[index].profilePath}',
                                          fit: BoxFit.cover,
                                          height: 150,
                                        ),
                                        Text(
                                          snapshot.data[index].name.split(" ")[0],
                                          style: const TextStyle(color: Colors.white),
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
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 37),
            child: BackButton(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "Watch Now",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
