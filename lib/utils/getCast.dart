import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/models/castModel.dart';

class GetCast {
  getCast(int id, String mediaType) async {
    String? url;

    if (mediaType.toLowerCase() == "movie") {
      url = "https://api.themoviedb.org/3/movie/$id/credits?language=en-US";
    } else if (mediaType.toLowerCase() == "show") {
      url = "https://api.themoviedb.org/3/tv/$id/credits?language=en-US";
    }

    Map<String, String> headers = {
      "accept": "application/json",
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4N2Q1NTg1YTU0OTdiMzczNjc5ZThiZGM3ZDZmMGQyMiIsInN1YiI6IjYyMWRlNjY2ZDM4YjU4MDAxYmY0NDM3NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.JQAtkdBkGc2UNLbGZltTqowTCKCRyoGFL1OkwuWTZz8"
    };

    http.Response response = await http.get(Uri.parse(url!), headers: headers);
    List rawData = jsonDecode(response.body)["cast"];

    List<CastModel> castData = [];

    for (var i = 0; i < rawData.length; i++) {
      castData.add(CastModel.fromJson(rawData[i]));
    }

    return castData;
  }
}
