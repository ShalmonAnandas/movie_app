// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

ShowModel welcomeFromJson(String str) => ShowModel.fromJson(json.decode(str));

String welcomeToJson(ShowModel data) => json.encode(data.toJson());

class ShowModel {
  bool adult;
  String backdropPath;
  List<CreatedBy> createdBy;
  List<dynamic> episodeRunTime;
  DateTime firstAirDate;
  List<Genre> genres;
  String homepage;
  int id;
  bool inProduction;
  List<String> languages;
  DateTime lastAirDate;
  TEpisodeToAir lastEpisodeToAir;
  String name;
  TEpisodeToAir nextEpisodeToAir;
  List<Network> networks;
  int numberOfEpisodes;
  int numberOfSeasons;
  List<String> originCountry;
  String originalLanguage;
  String originalName;
  String overview;
  double popularity;
  String posterPath;
  List<Network> productionCompanies;
  List<ProductionCountry> productionCountries;
  List<Season> seasons;
  List<SpokenLanguage> spokenLanguages;
  String status;
  String tagline;
  String type;
  double voteAverage;
  int voteCount;

  ShowModel({
    required this.adult,
    required this.backdropPath,
    required this.createdBy,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    required this.lastAirDate,
    required this.lastEpisodeToAir,
    required this.name,
    required this.nextEpisodeToAir,
    required this.networks,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.seasons,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  factory ShowModel.fromJson(Map<String, dynamic> json) => ShowModel(
        adult: json["adult"] ?? false,
        backdropPath: json["backdrop_path"] ?? "",
        createdBy: List<CreatedBy>.from(
            json["created_by"].map((x) => CreatedBy.fromJson(x))),
        episodeRunTime:
            List<dynamic>.from(json["episode_run_time"].map((x) => x)),
        firstAirDate: DateTime.parse(json["first_air_date"]),
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
        homepage: json["homepage"] ?? "",
        id: json["id"] ?? 000000,
        inProduction: json["in_production"] ?? "",
        languages: List<String>.from(json["languages"].map((x) => x)),
        lastAirDate: DateTime.parse(json["last_air_date"]),
        lastEpisodeToAir: TEpisodeToAir.fromJson(json["last_episode_to_air"]),
        name: json["name"] ?? "",
        nextEpisodeToAir: (json["next_episode_to_air"] != null)
            ? TEpisodeToAir.fromJson(json["next_episode_to_air"])
            : TEpisodeToAir.fromJson(jsonDecode('''{	
"id": 4415911,
"name": "Draw a Blank",
"overview": "As the UK’s counterterrorism unit learns of Flight KA29, Sam gets involved in a risky plan to take on the hijackers.",
"vote_average": 0.0,
"vote_count": 0,
"air_date": "2023-07-04",
"episode_number": 3,
"production_code": "",
"runtime": 48,
"season_number": 1,
"show_id": 198102,
"still_path": "/nfvs5t9ZhNdqGzM9xy1x690qQCu.jpg"
}''')),
        networks: List<Network>.from(
            json["networks"].map((x) => Network.fromJson(x))),
        numberOfEpisodes: json["number_of_episodes"] ?? 0,
        numberOfSeasons: json["number_of_seasons"] ?? 0,
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        originalLanguage: json["original_language"] ?? "",
        originalName: json["original_name"] ?? "",
        overview: json["overview"] ?? "",
        popularity: json["popularity"]?.toDouble() ?? 0.0,
        posterPath: json["poster_path"] ?? "",
        productionCompanies: List<Network>.from(
            json["production_companies"].map((x) => Network.fromJson(x))),
        productionCountries: List<ProductionCountry>.from(
            json["production_countries"]
                .map((x) => ProductionCountry.fromJson(x))),
        seasons:
            List<Season>.from(json["seasons"].map((x) => Season.fromJson(x))),
        spokenLanguages: List<SpokenLanguage>.from(
            json["spoken_languages"].map((x) => SpokenLanguage.fromJson(x))),
        status: json["status"] ?? "",
        tagline: json["tagline"] ?? "",
        type: json["type"] ?? "",
        voteAverage: json["vote_average"]?.toDouble() ?? 0.0,
        voteCount: json["vote_count"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "created_by": List<dynamic>.from(createdBy.map((x) => x.toJson())),
        "episode_run_time": List<dynamic>.from(episodeRunTime.map((x) => x)),
        "first_air_date":
            "${firstAirDate.year.toString().padLeft(4, '0')}-${firstAirDate.month.toString().padLeft(2, '0')}-${firstAirDate.day.toString().padLeft(2, '0')}",
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "homepage": homepage,
        "id": id,
        "in_production": inProduction,
        "languages": List<dynamic>.from(languages.map((x) => x)),
        "last_air_date":
            "${lastAirDate.year.toString().padLeft(4, '0')}-${lastAirDate.month.toString().padLeft(2, '0')}-${lastAirDate.day.toString().padLeft(2, '0')}",
        "last_episode_to_air": lastEpisodeToAir.toJson(),
        "name": name,
        "next_episode_to_air": nextEpisodeToAir.toJson(),
        "networks": List<dynamic>.from(networks.map((x) => x.toJson())),
        "number_of_episodes": numberOfEpisodes,
        "number_of_seasons": numberOfSeasons,
        "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "production_companies":
            List<dynamic>.from(productionCompanies.map((x) => x.toJson())),
        "production_countries":
            List<dynamic>.from(productionCountries.map((x) => x.toJson())),
        "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
        "spoken_languages":
            List<dynamic>.from(spokenLanguages.map((x) => x.toJson())),
        "status": status,
        "tagline": tagline,
        "type": type,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}

class CreatedBy {
  int id;
  String creditId;
  String name;
  int gender;
  String? profilePath;

  CreatedBy({
    required this.id,
    required this.creditId,
    required this.name,
    required this.gender,
    this.profilePath,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        id: json["id"] ?? 0,
        creditId: json["credit_id"] ?? "",
        name: json["name"] ?? "",
        gender: json["gender"] ?? 0,
        profilePath: json["profile_path"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "credit_id": creditId,
        "name": name,
        "gender": gender,
        "profile_path": profilePath,
      };
}

class Genre {
  int id;
  String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class TEpisodeToAir {
  int id;
  String name;
  String overview;
  double voteAverage;
  int voteCount;
  DateTime airDate;
  int episodeNumber;
  String productionCode;
  int runtime;
  int seasonNumber;
  int showId;
  String stillPath;

  TEpisodeToAir({
    required this.id,
    required this.name,
    required this.overview,
    required this.voteAverage,
    required this.voteCount,
    required this.airDate,
    required this.episodeNumber,
    required this.productionCode,
    required this.runtime,
    required this.seasonNumber,
    required this.showId,
    required this.stillPath,
  });

  factory TEpisodeToAir.fromJson(Map<String, dynamic> json) => TEpisodeToAir(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        overview: json["overview"] ?? "",
        voteAverage: json["vote_average"] ?? 0.0,
        voteCount: json["vote_count"] ?? 0,
        airDate: DateTime.parse(json["air_date"]),
        episodeNumber: json["episode_number"] ?? 0,
        productionCode: json["production_code"] ?? 0,
        runtime: json["runtime"] ?? 0,
        seasonNumber: json["season_number"] ?? 0,
        showId: json["show_id"] ?? 0,
        stillPath: json["still_path"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "overview": overview,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "air_date":
            "${airDate.year.toString().padLeft(4, '0')}-${airDate.month.toString().padLeft(2, '0')}-${airDate.day.toString().padLeft(2, '0')}",
        "episode_number": episodeNumber,
        "production_code": productionCode,
        "runtime": runtime,
        "season_number": seasonNumber,
        "show_id": showId,
        "still_path": stillPath,
      };
}

class Network {
  int id;
  String? logoPath;
  String name;
  String originCountry;

  Network({
    required this.id,
    this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory Network.fromJson(Map<String, dynamic> json) => Network(
        id: json["id"] ?? 00,
        logoPath: json["logo_path"] ?? "",
        name: json["name"] ?? "",
        originCountry: json["origin_country"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "logo_path": logoPath,
        "name": name,
        "origin_country": originCountry,
      };
}

class ProductionCountry {
  String iso31661;
  String name;

  ProductionCountry({
    required this.iso31661,
    required this.name,
  });

  factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
      ProductionCountry(
        iso31661: json["iso_3166_1"] ?? "",
        name: json["name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "iso_3166_1": iso31661,
        "name": name,
      };
}

class Season {
  DateTime airDate;
  int episodeCount;
  int id;
  String name;
  String overview;
  String posterPath;
  int seasonNumber;
  double voteAverage;

  Season({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
  });

  factory Season.fromJson(Map<String, dynamic> json) => Season(
        airDate: (json["air_data"] != null)
            ? DateTime.parse(json["air_date"])
            : DateTime.now(),
        episodeCount: json["episode_count"] ?? 0,
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        overview: json["overview"] ?? "",
        posterPath: json["poster_path"] ?? "",
        seasonNumber: json["season_number"] ?? 0,
        voteAverage: json["vote_average"]?.toDouble() ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "air_date":
            "${airDate.year.toString().padLeft(4, '0')}-${airDate.month.toString().padLeft(2, '0')}-${airDate.day.toString().padLeft(2, '0')}",
        "episode_count": episodeCount,
        "id": id,
        "name": name,
        "overview": overview,
        "poster_path": posterPath,
        "season_number": seasonNumber,
        "vote_average": voteAverage,
      };
}

class SpokenLanguage {
  String englishName;
  String iso6391;
  String name;

  SpokenLanguage({
    required this.englishName,
    required this.iso6391,
    required this.name,
  });

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) => SpokenLanguage(
        englishName: json["english_name"] ?? "",
        iso6391: json["iso_639_1"] ?? "",
        name: json["name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "english_name": englishName,
        "iso_639_1": iso6391,
        "name": name,
      };
}
