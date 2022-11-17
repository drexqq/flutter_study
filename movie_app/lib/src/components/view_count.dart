import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movie_app/src/providers/count_provider.dart';

class ViewCountWidget extends StatelessWidget {
  const ViewCountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<CountProvider>(
        builder: (context, provider, widget) {
          return Text(
            provider.count.toString(),
            style: const TextStyle(fontSize: 20),
          );
        },
      ),
    );
  }
}
