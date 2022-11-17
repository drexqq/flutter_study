import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tiny_project/models/movie_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieServices {
  Future<List<Movie>> getMovies() async {
    var params = {'api_key': '327c8e5f67be2a14e86076f34b5f2ae6'};
    var uri = Uri.https("api.themoviedb.org", "/3/movie/popular", params);
    try {
      var res = await http.get(uri);
      Map<String, dynamic> body = json.decode(res.body);
      List<dynamic> result = body["results"];
      return result.map((item) => Movie.fromJson(item)).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

final movieProvider = Provider<MovieServices>((ref) => MovieServices());
