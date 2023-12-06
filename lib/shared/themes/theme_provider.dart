import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void setTheme(bool isDarkMode) {
    _isDarkMode = isDarkMode;
    notifyListeners();
  }
}
