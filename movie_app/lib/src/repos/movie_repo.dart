// API request
import 'dart:convert';

import 'package:movie_app/src/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MovieRepo {
  Future<List<Movie>?> loadMovies() async {
    var params = {'api_key': '327c8e5f67be2a14e86076f34b5f2ae6'};
    var uri = Uri.https("api.themoviedb.org", "/3/movie/popular", params);
    var res = await http.get(uri);

    Map<String, dynamic> body = json.decode(res.body);
    if (body["results"] == null) return null;

    List<dynamic> results = body["results"];
    return results.map((item) => Movie.fromJson(item)).toList();
  }
}
