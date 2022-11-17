import 'package:flutter/material.dart';

class BottomNavProvider extends ChangeNotifier {
  late int _index = 0;

  int get index => _index;

  void updateCurrPage(int index) {
    _index = index;
    notifyListeners();
  }
}
