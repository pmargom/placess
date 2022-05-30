import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserPrefs {
  static Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
  static save(String key, dynamic value) async {
    final p = await prefs;
    await p.setString(key, json.encode(value));
  }

  static remove(String key) async {
    final p = await prefs;
    await p.remove(key);
  }
}
