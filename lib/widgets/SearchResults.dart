// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/models/SearchModel.dart';
import 'package:movie_app/screens/watchMovieScreen.dart';
import 'package:movie_app/screens/watchShowScreen.dart';
import 'package:movie_app/utils/getSearch.dart';
import 'package:movie_app/utils/getTrending.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({super.key, required this.searchTerm});

  final String searchTerm;

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  GetSearch getSearchObj = GetSearch();

  @override
  void initState() {
    super.initState();
    getSearchResults();
  }

  Future<SearchResults> getSearchResults() async {
    return getSearchObj.getSearch(widget.searchTerm);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Text(
                  "Search Results",
                  style: GoogleFonts.quicksand(
                      fontSize: 30, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          TrendingMovies(),
        ],
      ),
    );
  }

  FutureBuilder<dynamic> TrendingMovies() {
    return FutureBuilder<SearchResults>(
      future: getSearchResults(),
      builder: (BuildContext context, AsyncSnapshot<SearchResults> snapshot) {
        Widget children;
        if (snapshot.hasData) {
          children = SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.707,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, childAspectRatio: 0.65),
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data!.results.length - 2,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      print(
                          "${snapshot.data?.results[index].mediaType.toString().toLowerCase()}");
                      if (snapshot.data?.results[index].mediaType
                              .toString()
                              .toLowerCase() ==
                          "mediatype.movie") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WatchMovieScreen(
                              id: snapshot.data!.results[index].id,
                            ),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WatchShowScreen(
                              id: snapshot.data!.results[index].id,
                            ),
                          ),
                        );
                      }
                    },
                    child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w600_and_h900_bestv2${snapshot.data?.results[index].posterPath}',
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  );
                },
              ),
            ),
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
    );
  }
}
