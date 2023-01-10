import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex {
    return _currentIndex;
  }

  void changeTab(int index) {
    _currentIndex = index;
    notifyListeners();
  }

}
