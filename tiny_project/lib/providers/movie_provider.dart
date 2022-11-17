import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiny_project/services/movie_services.dart';

final movieDataProvider = FutureProvider((ref) async {
  return await ref.watch(movieProvider).getMovies();
});
