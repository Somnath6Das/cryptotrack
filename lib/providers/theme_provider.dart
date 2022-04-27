import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  // ThemeProvider(String theme) {
  //   if (themeMode == "light") {
  //     themeMode = ThemeMode.light;
  //   } else {
  //     themeMode = ThemeMode.dark;
  //   }
  // }

  void toggleTheme() {
    if (themeMode == ThemeMode.light) {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }

    notifyListeners();
  }
}
