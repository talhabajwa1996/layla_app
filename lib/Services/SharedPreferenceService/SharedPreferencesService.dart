import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> setString(String key, String? value) async {
    SharedPreferences prefs = await _prefs;
    if (value != null && value.isNotEmpty) {
      prefs.setString(key, value);
    }
  }

  Future<void> setInt(String key, int value) async {
    SharedPreferences prefs = await _prefs;
    prefs.setInt(key, value);
  }

  Future<void> setJsonString(String key, Map<String, dynamic> value) async {
    SharedPreferences prefs = await _prefs;
    if (value.isNotEmpty) {
      prefs.setString(key, jsonEncode(value));
    }
  }

  Future<String?> getString(String key) async {
    SharedPreferences prefs = await _prefs;
    return prefs.containsKey(key) ? prefs.getString(key) : "";
  }

  Future<int?> getInt(String key) async {
    SharedPreferences prefs = await _prefs;
    return prefs.containsKey(key) ? prefs.getInt(key) : null;
  }

  Future<bool> checkKey(String key) async {
    SharedPreferences prefs = await _prefs;
    return prefs.containsKey(key);
  }

  Future<bool> remove(String key) async {
    SharedPreferences prefs = await _prefs;
    return prefs.remove(key);
  }

  Future<void> clearLocalData() async {
    SharedPreferences prefs = await _prefs;
    await prefs.clear();
    print("Cleared All Data");
  }
}
