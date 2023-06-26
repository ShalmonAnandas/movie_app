import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/models/moviemodel.dart';

class GetMovies {
  void getTrendingMovies() async {
    String url = "https://api.themoviedb.org/3/trending/all/day?language=en-US";
    Map<String, String> headers = {
      "accept": "application/json",
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4N2Q1NTg1YTU0OTdiMzczNjc5ZThiZGM3ZDZmMGQyMiIsInN1YiI6IjYyMWRlNjY2ZDM4YjU4MDAxYmY0NDM3NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.JQAtkdBkGc2UNLbGZltTqowTCKCRyoGFL1OkwuWTZz8"
    };

    http.Response response = await http.get(Uri.parse(url), headers: headers);
    List rawData = jsonDecode(response.body)["results"];

    List<MovieModel> trendingData = [];

    for (var i = 0; i < rawData.length; i++) {
      trendingData.add(MovieModel.fromJson(rawData[i]));
    }

    print(trendingData);
  }
}
