import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/utils/getSimilar.dart';
import '../models/similarMoviesModel.dart';
import '../utils/getCast.dart';

class SimilarMoviesWidget extends StatelessWidget {
  final int id;
  final String mediaType;
  final GetSimilar getSimilarObj = GetSimilar();

  SimilarMoviesWidget({
    super.key,
    required this.id,
    required this.mediaType,
  });

  getSimilarModels() async {
    return getSimilarObj.getSimilar(id, mediaType);
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        title: Text(
          "Similar Movies",
          style: GoogleFonts.quicksand(fontWeight: FontWeight.w900),
        ),
        children: [
          FutureBuilder(
            future: getSimilarModels(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              Widget children;
              if (snapshot.hasData) {
                children = SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data?.results?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {},
                        child: SizedBox(
                          // width: MediaQuery.of(context).size.height * 0.3,
                          child: Card(
                            elevation: 0,
                            color: Colors.transparent,
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Stack(
                              children: [
                                Image.network(
                                  (snapshot.data?.results?[index].posterPath !=
                                          null)
                                      ? 'https://image.tmdb.org/t/p/w600_and_h900_bestv2${snapshot.data?.results?[index].posterPath}'
                                      : "https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg",
                                  fit: BoxFit.cover,
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  width: MediaQuery.of(context).size.height *
                                      0.195,
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    width: MediaQuery.of(context).size.width *
                                        0.435,
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Colors.black54,
                                          Colors.black
                                        ],
                                      ),
                                    ),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        (snapshot.data.results[index]
                                                    .mediaType ==
                                                "movie")
                                            ? snapshot.data?.results![index]
                                                    .title ??
                                                ""
                                            : snapshot.data?.results![index]
                                                    .originalName ??
                                                "",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.quicksand(
                                            fontWeight: FontWeight.w900,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
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
                children = SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return children;
            },
          ),
        ]);
  }
}
