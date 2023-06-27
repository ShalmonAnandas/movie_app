import 'dart:convert';

CastModel castModelFromJson(String str) => CastModel.fromJson(json.decode(str));

String movieModelToJson(CastModel data) => json.encode(data.toJson());

class CastModel {
  bool adult;
  int gender;
  int id;
  String knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String profilePath;
  int castId;
  String character;
  String creditId;
  int order;

  CastModel({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.castId,
    required this.character,
    required this.creditId,
    required this.order,
  });

  factory CastModel.fromJson(Map<String, dynamic> json) => CastModel(
        adult: json["adult"] ?? false,
        gender: json["gender"] ?? 0,
        id: json["id"] ?? 00,
        knownForDepartment: json["known_for_department"] ?? "",
        name: json["name"] ?? "",
        originalName: json["original_name"] ?? "",
        popularity: json["popularity"]?.toDouble() ?? 0.0,
        profilePath: json["profile_path"] ?? "",
        castId: json["cast_id"] ?? 00,
        character: json["character"] ?? "",
        creditId: json["credit_id"] ?? "",
        order: json["order"] ?? 1,
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "gender": gender,
        "id": id,
        "known_for_department": knownForDepartment,
        "name": name,
        "original_name": originalName,
        "popularity": popularity,
        "profile_path": profilePath,
        "cast_id": castId,
        "character": character,
        "credit_id": creditId,
        "order": order,
      };
}
