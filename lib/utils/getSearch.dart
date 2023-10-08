import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:movie_app/models/SearchModel.dart';
import 'package:movie_app/models/castModel.dart';
import 'package:movie_app/models/similarMoviesModel.dart';
import 'package:movie_app/models/similarShowsModel.dart';

class GetSearch {
  Future<SearchResults> getSearch(String searchTerm) async {
    String url =
        "https://api.themoviedb.org/3/search/multi?query=$searchTerm&include_adult=false&language=en-US&page=1";

    Map<String, String> headers = {
      "accept": "application/json",
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4N2Q1NTg1YTU0OTdiMzczNjc5ZThiZGM3ZDZmMGQyMiIsInN1YiI6IjYyMWRlNjY2ZDM4YjU4MDAxYmY0NDM3NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.JQAtkdBkGc2UNLbGZltTqowTCKCRyoGFL1OkwuWTZz8"
    };

    http.Response response = await http.get(Uri.parse(url), headers: headers);
    // print(response.body);
    SearchResults searchResults = searchResultsFromJson(response.body);

    return searchResults;
  }
}
