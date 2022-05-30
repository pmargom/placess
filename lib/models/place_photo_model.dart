// To parse this JSON data, do
//
//     final placePhoto = placePhotoFromJson(jsonString);

import 'dart:convert';

String placePhotoToJson(List<PlacePhoto> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<PlacePhoto> placePhotoFromJson(dynamic jsonList) => List.from(jsonList)
    .map((placePhoto) => PlacePhoto.fromJson(placePhoto))
    .toList();

class PlacePhoto {
  PlacePhoto({
    required this.id,
    required this.createdAt,
    required this.prefix,
    required this.suffix,
    required this.width,
    required this.height,
    // required this.classifications,
  });

  String id;
  DateTime createdAt;
  String prefix;
  String suffix;
  int width;
  int height;
  // List<String> classifications;

  factory PlacePhoto.fromJson(Map<String, dynamic> json) => PlacePhoto(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        prefix: json["prefix"],
        suffix: json["suffix"],
        width: json["width"],
        height: json["height"],
        // classifications: json['classifications'] == null ? null : List<String>.from(json["classifications"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "prefix": prefix,
        "suffix": suffix,
        "width": width,
        "height": height,
        // "classifications": classifications == null ? null : List<dynamic>.from(classifications.map((x) => x)),
      };
}
