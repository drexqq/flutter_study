import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiny_project/models/movie_model.dart';
import 'package:tiny_project/providers/movie_provider.dart';

class HomeMovie extends ConsumerWidget {
  const HomeMovie({super.key});
  Widget commonLoadingWidget() {
    return const Center(child: CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = ref.watch(movieDataProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("riverpod test"),
      ),
      body: movies.when(
          data: (data) {
            List<Movie> movieList = data.map((e) => e).toList();
            return Column(
              children: [
                Expanded(
                    child: ListView.separated(
                        itemBuilder: (_, index) => Text(movieList[index].title),
                        separatorBuilder: (_, index) => const Divider(
                              height: 50,
                            ),
                        itemCount: movieList.length))
              ],
            );
          },
          error: (err, s) => Text(err.toString()),
          loading: () {
            print("Loadgin");
            return commonLoadingWidget();
          }),
    );
  }
}
