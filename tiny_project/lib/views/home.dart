import 'package:flutter/material.dart';
import 'package:tiny_project/views/movies/home_app.dart';
import 'package:tiny_project/views/movies/home_movie.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  const Home({super.key});

  Widget _bottonNavBar(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const HomeApp()));
                },
                icon: const Icon(Icons.home)),
            label: "Home"),
        BottomNavigationBarItem(
            icon: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeMovie()));
                },
                icon: const Icon(Icons.movie)),
            label: "Home"),
      ],
      currentIndex: 0,
      selectedItemColor: Colors.red,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottonNavBar(context),
    );
  }
}
