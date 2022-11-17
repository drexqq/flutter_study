import 'package:flutter/material.dart';
import 'package:movie_app/src/providers/bottom_nav_provider.dart';
import 'package:movie_app/src/views/count_home.dart';
import 'package:movie_app/src/views/movie_list.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  Home({super.key});
  late BottomNavProvider _bottomNavProvider;

  Widget _navBody() {
    switch (_bottomNavProvider.index) {
      case 0:
        return CountHome();
      case 1:
        return MovieList();
      default:
        return Container();
    }
  }

  Widget _bottonNavBar() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.movie), label: "Movie")
      ],
      currentIndex: _bottomNavProvider.index,
      selectedItemColor: Colors.red,
      onTap: (index) {
        _bottomNavProvider.updateCurrPage(index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _bottomNavProvider = Provider.of<BottomNavProvider>(context);

    return Scaffold(
      body: _navBody(),
      bottomNavigationBar: _bottonNavBar(),
    );
  }
}
