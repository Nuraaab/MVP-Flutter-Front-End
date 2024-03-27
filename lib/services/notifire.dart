import 'package:flutter/foundation.dart';

class FilterDataState with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setCurrentIndex(int newIndex) {
    _currentIndex = newIndex;
    notifyListeners();
  }
}