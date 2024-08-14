import 'package:flutter/material.dart';
import 'package:habbittacker_app/themes/dark_mode.dart';
import 'package:habbittacker_app/themes/light_mode%20.dart';

class ThemeProvider extends ChangeNotifier {
  // at first it is in light mode
  ThemeData _themeData = lightMode;

  // get current theme
  ThemeData get themeData => _themeData;

  //is current theme is dark  mode
  bool get isDarkMode => _themeData == darkMode;

  // set theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  // toggle
  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
