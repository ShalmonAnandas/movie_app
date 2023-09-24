import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:movie_app/models/castModel.dart';
import 'package:movie_app/models/similarMoviesModel.dart';
import 'package:movie_app/models/similarShowsModel.dart';

class GetSimilar {
  getSimilar(int id, String mediaType) async {
    String? url;

    if (mediaType.toLowerCase() == "movie") {
      url =
          "https://api.themoviedb.org/3/movie/$id/similar?language=en-US&page=1";
    } else if (mediaType.toLowerCase() == "show") {
      url = "https://api.themoviedb.org/3/tv/$id/similar?language=en-US&page=1";
    }

    Map<String, String> headers = {
      "accept": "application/json",
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4N2Q1NTg1YTU0OTdiMzczNjc5ZThiZGM3ZDZmMGQyMiIsInN1YiI6IjYyMWRlNjY2ZDM4YjU4MDAxYmY0NDM3NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.JQAtkdBkGc2UNLbGZltTqowTCKCRyoGFL1OkwuWTZz8"
    };

    http.Response response = await http.get(Uri.parse(url!), headers: headers);
    var model;

    if (mediaType.toLowerCase() == "movie") {
      model = similarMoviesFromJson(response.body);
    } else {
      model = similarShowsFromJson(response.body);
    }

    return model;
  }
}
