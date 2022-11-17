import 'package:flutter/widgets.dart';
import 'package:movie_app/src/models/movie_model.dart';
import 'package:movie_app/src/repos/movie_repo.dart';

class MovieProvider extends ChangeNotifier {
  late final MovieRepo _movieRepo = MovieRepo();
  late List<Movie> _movies = [];

  List<Movie> get getMovies => _movies;

  laodMovies() async {
    List<Movie> movieList = await _movieRepo.loadMovies() ?? [];
    _movies = movieList;
    notifyListeners();
  }
}
