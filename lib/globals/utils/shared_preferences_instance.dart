import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:template_flutter/globals/models/globals.dart';

class SharedPreferencesInstance {
  Future<SharedPreferences>? prefs;

  SharedPreferencesInstance() {
    prefs = SharedPreferences.getInstance();
  }

  Future<T?> readModel<T extends BaseModel>(
    String key,
    FromJsonFactory<T> fromJson,
  ) async {
    final currentPrefs = await prefs;
    final jsonStr = currentPrefs?.getString(key);
    if (jsonStr == null) return null;

    final Map<String, dynamic> jsonMap = jsonDecode(jsonStr);
    return fromJson(jsonMap);
  }
}
