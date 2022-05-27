// To parse this JSON data, do
//
//     final place = placeFromJson(jsonString);

import 'dart:convert';

Place placeFromJson(String str) => Place.fromJson(json.decode(str));

String placeToJson(Place data) => json.encode(data.toJson());

class Place {
  Place({
    required this.fsqId,
    required this.categories,
    required this.chains,
    required this.distance,
    required this.geocodes,
    required this.link,
    required this.location,
    required this.name,
    required this.relatedPlaces,
    required this.timezone,
  });

  String fsqId;
  List<Category> categories;
  List<dynamic> chains;
  int distance;
  Geocodes geocodes;
  String link;
  Location location;
  String name;
  RelatedPlaces relatedPlaces;
  String timezone;

  factory Place.fromJson(Map<String, dynamic> json) => Place(
        fsqId: json["fsq_id"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        chains: List<dynamic>.from(json["chains"].map((x) => x)),
        distance: json["distance"],
        geocodes: Geocodes.fromJson(json["geocodes"]),
        link: json["link"],
        location: Location.fromJson(json["location"]),
        name: json["name"],
        relatedPlaces: RelatedPlaces.fromJson(json["related_places"]),
        timezone: json["timezone"],
      );

  Map<String, dynamic> toJson() => {
        "fsq_id": fsqId,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "chains": List<dynamic>.from(chains.map((x) => x)),
        "distance": distance,
        "geocodes": geocodes.toJson(),
        "link": link,
        "location": location.toJson(),
        "name": name,
        "related_places": relatedPlaces.toJson(),
        "timezone": timezone,
      };
}

class Category {
  Category({
    required this.id,
    required this.name,
    required this.icon,
  });

  int id;
  String name;
  Icon icon;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        icon: Icon.fromJson(json["icon"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon": icon.toJson(),
      };
}

class Icon {
  Icon({
    required this.prefix,
    required this.suffix,
  });

  String prefix;
  String suffix;

  factory Icon.fromJson(Map<String, dynamic> json) => Icon(
        prefix: json["prefix"],
        suffix: json["suffix"],
      );

  Map<String, dynamic> toJson() => {
        "prefix": prefix,
        "suffix": suffix,
      };
}

class Geocodes {
  Geocodes({
    required this.main,
  });

  Main main;

  factory Geocodes.fromJson(Map<String, dynamic> json) => Geocodes(
        main: Main.fromJson(json["main"]),
      );

  Map<String, dynamic> toJson() => {
        "main": main.toJson(),
      };
}

class Main {
  Main({
    required this.latitude,
    required this.longitude,
  });

  double latitude;
  double longitude;

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

class Location {
  Location({
    required this.address,
    required this.adminRegion,
    required this.country,
    required this.crossStreet,
    required this.formattedAddress,
    required this.locality,
    required this.postcode,
    required this.region,
  });

  String address;
  String adminRegion;
  String country;
  String crossStreet;
  String formattedAddress;
  String locality;
  String postcode;
  String region;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        address: json["address"],
        adminRegion: json["admin_region"],
        country: json["country"],
        crossStreet: json["cross_street"],
        formattedAddress: json["formatted_address"],
        locality: json["locality"],
        postcode: json["postcode"],
        region: json["region"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "admin_region": adminRegion,
        "country": country,
        "cross_street": crossStreet,
        "formatted_address": formattedAddress,
        "locality": locality,
        "postcode": postcode,
        "region": region,
      };
}

class RelatedPlaces {
  RelatedPlaces();

  factory RelatedPlaces.fromJson(Map<String, dynamic> json) => RelatedPlaces();

  Map<String, dynamic> toJson() => {};
}
