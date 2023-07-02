import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/models/movieModel.dart';
import 'package:movie_app/models/showModel.dart';

class GetIndividual {
  getIndividualDetails(int id, String mediaType) async {
    String url = "https://api.themoviedb.org/3/$mediaType/$id?language=en-US";
    Map<String, String> headers = {
      "accept": "application/json",
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4N2Q1NTg1YTU0OTdiMzczNjc5ZThiZGM3ZDZmMGQyMiIsInN1YiI6IjYyMWRlNjY2ZDM4YjU4MDAxYmY0NDM3NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.JQAtkdBkGc2UNLbGZltTqowTCKCRyoGFL1OkwuWTZz8"
    };

    http.Response response = await http.get(Uri.parse(url), headers: headers);
    var rawData = jsonDecode(response.body);

    ShowModel? tvModel;
    MovieModel? movieModel;

    if (mediaType.toLowerCase() == "movie") {
      movieModel = MovieModel.fromJson(rawData);
      return movieModel;
    } else if (mediaType.toLowerCase() == "tv") {
      tvModel = ShowModel.fromJson(rawData);
      return tvModel;
    }
  }
}
