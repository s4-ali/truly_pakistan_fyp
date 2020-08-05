import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:truly_pakistan_fyp/enums.dart';

class ThemeProvider with ChangeNotifier {

  static final List<ThemeData> themeData = [
    ThemeData(
      fontFamily: "OpenSans",
      brightness: Brightness.light,
      primaryColor: Color(0xFF1BA874),
      accentColor: Colors.red),
    ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFF038052),
        accentColor: Colors.yellowAccent)
  ];

  AppTheme _currentTheme = AppTheme.DARK;
  ThemeData _currentThemeData = themeData[0];

  void switchTheme() => currentTheme == AppTheme.LIGHT
      ? currentTheme = AppTheme.DARK
      : currentTheme = AppTheme.LIGHT;

  set currentTheme(AppTheme theme) {
    if (theme != null) {
      _currentTheme = theme;
      _currentThemeData =
      currentTheme == AppTheme.LIGHT ? themeData[0] : themeData[1];
      notifyListeners();
    }
  }

  get currentTheme => _currentTheme;
  get currentThemeData => _currentThemeData;

}