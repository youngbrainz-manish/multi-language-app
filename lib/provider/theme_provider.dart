import 'package:flutter/material.dart';
import 'package:multi_language_app/core/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  SharedPreferences? prefs;
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      prefs = await SharedPreferences.getInstance();
      getTheme();
    });
  }

  void setTheme(ThemeMode mode) {
    _themeMode = mode;
    prefs?.setString(AppConstants().stringTheme, mode.name.toString());
    notifyListeners();
  }

  void getTheme() async {
    _themeMode = prefs?.getString(AppConstants().stringTheme) == 'light' ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}
