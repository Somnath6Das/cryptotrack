import 'package:shared_preferences/shared_preferences.dart';

//! save and get theme data for app restart *4
class LocalStorage {
  static Future<bool> saveTheme(String theme) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool result = await sharedPreferences.setString("theme", theme);
    return result;
  }

  static Future<String?> getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? currentTheme = sharedPreferences.getString("theme");
    return currentTheme;
  }

  //todo: save remove fetch favorite data to local storage.
  static Future<bool> addFavorite(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> favorites = sharedPreferences.getStringList("favorites") ?? [];
    favorites.add(id);
    return await sharedPreferences.setStringList("favorites", favorites);
  }

  static Future<bool> removeFavorite(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> favorites = sharedPreferences.getStringList("favorites") ?? [];
    favorites.remove(id);
    return await sharedPreferences.setStringList("favorites", favorites);
  }

  static Future<List<String>> fetchFavorites() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getStringList("favorites") ?? [];
  }
}
