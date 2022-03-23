// To parse this JSON data, do
//
//     final detailShow = detailShowFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DetailShow detailShowFromJson(String str) =>
    DetailShow.fromJson(json.decode(str));

String detailShowToJson(DetailShow data) => json.encode(data.toJson());

class DetailShow {
  DetailShow({
     required this.id,
     this.url,
     this.name,
     this.type,
     this.language,
     this.genres,
     this.status,
     this.runtime,
     this.averageRuntime,
     this.premiered,
     this.ended,
     this.officialSite,
     this.schedule,
     this.rating,
     this.weight,
     this.network,
     this.webChannel,
     this.dvdCountry,
     this.externals,
     this.image,
     this.summary,
     this.updated,
     this.links,
  });

  int id;
  String? url;
  String? name;
  String? type;
  String? language;
  List<String>? genres;
  String? status;
  int? runtime;
  int? averageRuntime;
  DateTime? premiered;
  DateTime? ended;
  String? officialSite;
  Schedule? schedule;
  Rating? rating;
  int? weight;
  Network? network;
  dynamic webChannel;
  dynamic dvdCountry;
  Externals? externals;
  Image? image;
  String? summary;
  int? updated;
  Links? links;

  factory DetailShow.fromJson(Map<String, dynamic> json) => DetailShow(
        id: json["id"],
        url: json["url"],
        name: json["name"],
        type: json["type"],
        language: json["language"],
        genres: List<String>.from(json["genres"].map((x) => x)),
        status: json["status"],
        runtime: json["runtime"],
        averageRuntime: json["averageRuntime"],
        premiered: DateTime.parse(json["premiered"]),
        ended: DateTime.parse(json["ended"]),
        officialSite: json["officialSite"],
        schedule: Schedule.fromJson(json["schedule"]),
        rating: Rating.fromJson(json["rating"]),
        weight: json["weight"],
        network: Network.fromJson(json["network"]),
        webChannel: json["webChannel"],
        dvdCountry: json["dvdCountry"],
        externals: Externals.fromJson(json["externals"]),
        image: Image.fromJson(json["image"]),
        summary: json["summary"],
        updated: json["updated"],
        links: Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "name": name,
        "type": type,
        "language": language,
        "genres": List<dynamic>.from(genres?.map((x) => x) ?? []),
        "status": status,
        "runtime": runtime,
        "averageRuntime": averageRuntime,
        "premiered":
            "${premiered?.year.toString().padLeft(4, '0')}-${premiered?.month.toString().padLeft(2, '0')}-${premiered?.day.toString().padLeft(2, '0')}",
        "ended":
            "${ended?.year.toString().padLeft(4, '0')}-${ended?.month.toString().padLeft(2, '0')}-${ended?.day.toString().padLeft(2, '0')}",
        "officialSite": officialSite,
        "schedule": schedule?.toJson() ,
        "rating": rating?.toJson(),
        "weight": weight,
        "network": network?.toJson(),
        "webChannel": webChannel,
        "dvdCountry": dvdCountry,
        "externals": externals?.toJson(),
        "image": image?.toJson(),
        "summary": summary,
        "updated": updated,
        "_links": links?.toJson(),
      };
}

class Externals {
  Externals({
    required this.tvrage,
     required this.thetvdb,
     required this.imdb,
  });

  int tvrage;
  int thetvdb;
  String imdb;

  factory Externals.fromJson(Map<String, dynamic> json) => Externals(
        tvrage: json["tvrage"],
        thetvdb: json["thetvdb"],
        imdb: json["imdb"],
      );

  Map<String, dynamic> toJson() => {
        "tvrage": tvrage,
        "thetvdb": thetvdb,
        "imdb": imdb,
      };
}

class Image {
  Image({
    required  this.medium,
     required this.original,
  });

  String medium;
  String original;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        medium: json["medium"],
        original: json["original"],
      );

  Map<String, dynamic> toJson() => {
        "medium": medium,
        "original": original,
      };
}

class Links {
  Links({
    required  this.self,
    required  this.previousepisode,
  });

  Previousepisode self;
  Previousepisode previousepisode;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: Previousepisode.fromJson(json["self"]),
        previousepisode: Previousepisode.fromJson(json["previousepisode"]),
      );

  Map<String, dynamic> toJson() => {
        "self": self.toJson(),
        "previousepisode": previousepisode.toJson(),
      };
}

class Previousepisode {
  Previousepisode({
     required this.href,
  });

  String href;

  factory Previousepisode.fromJson(Map<String, dynamic> json) =>
      Previousepisode(
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
      };
}

class Network {
  Network({
    required  this.id,
     required this.name,
    required  this.country,
  });

  int id;
  String name;
  Country country;

  factory Network.fromJson(Map<String, dynamic> json) => Network(
        id: json["id"],
        name: json["name"],
        country: Country.fromJson(json["country"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country": country.toJson(),
      };
}

class Country {
  Country({
     required this.name,
     required this.code,
     required this.timezone,
  });

  String name;
  String code;
  String timezone;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        name: json["name"],
        code: json["code"],
        timezone: json["timezone"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "timezone": timezone,
      };
}

class Rating {
  Rating({
     required this.average,
  });

  double average;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        average: json["average"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "average": average,
      };
}

class Schedule {
  Schedule({
    required  this.time,
     required this.days,
  });

  String time;
  List<String> days;

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        time: json["time"],
        days: List<String>.from(json["days"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "days": List<dynamic>.from(days.map((x) => x)),
      };
}
