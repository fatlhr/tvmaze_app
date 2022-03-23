// ignore_for_file: file_names

import 'package:tvmaze_app/models/detail_show_model.dart';

import '../models/all_shows_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/search_model.dart';

class AllServices {
  static Future<List<AllShows>> getShows(String categories) async {
    String url = "https://api.tvmaze.com/shows";

    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      var allShows = List<AllShows>.from(data.map(
        (item) => AllShows.fromJson(item),
      ));
      if (categories == "running") {
        allShows = allShows.where((item) => item.status! == "Running").toList();
      } else if (categories == "top") {
        allShows = allShows
            .where((item) => (item.rating!.average ?? 0) >= 8.0)
            .toList();
        allShows
            .sort((a, b) => b.rating!.average!.compareTo(a.rating!.average!));
      }

      return allShows;
    }
    throw Exception('Failed to load posts');
  }

  static Future<List<SearchShows>> getSearch(String searchResult) async {
    String url = "https://api.tvmaze.com/search/shows?q=$searchResult";

    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      var searchShows = List<SearchShows>.from(
          data.map((item) => SearchShows.fromJson(item)));

      return searchShows;
    }
    throw Exception('Failed to load posts');
  }
  static Future<DetailShow> getDetail(String id) async {
    String url = "https://api.tvmaze.com/shows/$id";

    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      
      return DetailShow.fromJson(data);
    }
    throw Exception('Failed to load posts');
  }
}
