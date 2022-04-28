import 'package:cryptotrack/models/local_storage.dart';

import 'package:flutter/material.dart';


class ThemeProvider with ChangeNotifier {
  
  //!  This function create for set theme 
  late ThemeMode themeMode;

  ThemeProvider(String theme) {
    if (theme == "light") {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }
  }



//!   swich and save theme local storage. *5
  void toggleTheme() async {
    if (themeMode == ThemeMode.light) {
      themeMode = ThemeMode.dark;
      await LocalStorage.saveTheme("dark");
    } else {
      themeMode = ThemeMode.light;
      await LocalStorage.saveTheme("light");
    }

    notifyListeners();
  }
}
