import 'package:shared_preferences/shared_preferences.dart';

Future<void> localStorageSave(String key, String value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

Future<String?> localStorageRead(String key) async {
  final prefs = await SharedPreferences.getInstance();

  return prefs.getString(key);
}

Future<void> localStorageRemove(String key) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove(key);
}