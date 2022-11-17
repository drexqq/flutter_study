class Movie {
  String title;
  String posterPath;
  String overview;

  Movie(
      {required this.title, required this.posterPath, required this.overview});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json["title"] as String,
      posterPath: json["poster_path"] as String,
      overview: json["overview"] as String,
    );
  }

  String get posterUrl => 'http://image.tmdb.org/t/p/w500/$posterPath';
}
