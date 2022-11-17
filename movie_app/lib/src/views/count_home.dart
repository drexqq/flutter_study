import 'package:flutter/material.dart';
import 'package:movie_app/src/components/view_count.dart';
import 'package:movie_app/src/providers/count_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CountHome extends StatelessWidget {
  CountHome({super.key});
  late CountProvider _counterProvider;

  @override
  Widget build(BuildContext context) {
    _counterProvider = Provider.of<CountProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text("Count Provider")),
      body: const ViewCountWidget(),
      floatingActionButton:
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        IconButton(
            onPressed: () {
              _counterProvider.add();
            },
            icon: const Icon(Icons.add)),
        IconButton(
            onPressed: () {
              _counterProvider.remove();
            },
            icon: const Icon(Icons.remove))
      ]),
    );
  }
}
