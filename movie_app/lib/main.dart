import 'package:flutter/material.dart';
import 'package:movie_app/src/home.dart';
import 'package:movie_app/src/providers/bottom_nav_provider.dart';
import 'package:movie_app/src/providers/count_provider.dart';
import 'package:movie_app/src/providers/movie_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider(
                create: (BuildContext context) => CountProvider()),
            ChangeNotifierProvider(
                create: (BuildContext context) => BottomNavProvider()),
            ChangeNotifierProvider(
                create: (BuildContext context) => MovieProvider())
          ],
          child: Home(),
        ));
  }
}
