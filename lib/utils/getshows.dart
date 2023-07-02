import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/models/trendingshowmodel.dart';
import 'package:movie_app/models/showmodel.dart';

class GetShows {
  getTrendingShows() async {
    String url = "https://api.themoviedb.org/3/trending/tv/day?language=en-US";
    Map<String, String> headers = {
      "accept": "application/json",
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4N2Q1NTg1YTU0OTdiMzczNjc5ZThiZGM3ZDZmMGQyMiIsInN1YiI6IjYyMWRlNjY2ZDM4YjU4MDAxYmY0NDM3NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.JQAtkdBkGc2UNLbGZltTqowTCKCRyoGFL1OkwuWTZz8"
    };

    http.Response response = await http.get(Uri.parse(url), headers: headers);
    List rawData = jsonDecode(response.body)["results"];

    List<TrendingShowModel> trendingData = [];

    for (var i = 0; i < rawData.length; i++) {
      trendingData.add(TrendingShowModel.fromJson(rawData[i]));
    }

    return trendingData;
  }

  getShowDetails(int id) async {
    String url = "https://api.themoviedb.org/3/tv/$id?language=en-US";
    Map<String, String> headers = {
      "accept": "application/json",
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4N2Q1NTg1YTU0OTdiMzczNjc5ZThiZGM3ZDZmMGQyMiIsInN1YiI6IjYyMWRlNjY2ZDM4YjU4MDAxYmY0NDM3NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.JQAtkdBkGc2UNLbGZltTqowTCKCRyoGFL1OkwuWTZz8"
    };

    http.Response response = await http.get(Uri.parse(url), headers: headers);
    var rawData = jsonDecode(response.body);

    ShowModel currentShowModel = ShowModel.fromJson(rawData);

    return currentShowModel;
  }
}
