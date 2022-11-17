import 'package:flutter/material.dart';

class HomeApp extends StatelessWidget {
  const HomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("home app ")),
        body: const Center(
          child: Text("NORMAL PAGE"),
        ));
  }
}
