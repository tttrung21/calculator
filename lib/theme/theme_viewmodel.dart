import 'package:calculator/theme/theme_helper.dart';
import 'package:flutter/material.dart';

class ThemeViewModel with ChangeNotifier{
  ThemeMode _theme = ThemeMode.light;
  ThemeHelper helper = ThemeHelper();
  ThemeMode get theme => _theme;
  bool get isDark => _theme == ThemeMode.dark;
  void getTheme() async{
    final isDark = await helper.isDark();
    _theme = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
  void toggleTheme() {
    _theme = _theme == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    helper.setTheme(isDark);
    notifyListeners();
  }
}