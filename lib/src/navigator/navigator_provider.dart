import 'package:flutter/material.dart';

class NavigatorProvider extends ChangeNotifier {
  int _index = 0;
  int get index => _index;

  void setIndex(int index) {
    _index = index;
    notifyListeners();
  }
}
