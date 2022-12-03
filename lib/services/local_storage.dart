import 'dart:convert';

import 'package:loomus_app/models/auth/token_data.dart';
import 'package:loomus_app/models/user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  final User? user;

  UserData(this.user);
}

class LocalStorage {
  Future<TokenData?> getTokenData() async {
    final map = await _get("io.loomus.token-data");

    return map != null ? TokenData.fromJson(map) : null;
  }

  Future<void> setTokenData(TokenData? value) async {
    if (value == null) {
      final prefs = await SharedPreferences.getInstance();
      prefs.remove("io.loomus.token-data");
    } else {
      await _set("io.loomus.token-data", json.encode(value.toJson()));
    }
  }

  Future<int?> getTokenRefreshedAt() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getInt("io.loomus.token-refreshed-at");
  }

  Future<void> setTokenRefreshedAt(int? value) async {
    final prefs = await SharedPreferences.getInstance();

    if (value == null) {
      prefs.remove("io.loomus.token-refreshed-at");
    } else {
      prefs.setInt("io.loomus.token-refreshed-at", value);
    }
  }

  Future<User?> getCurrentUser() async {
    final map = await _get("io.loomus.current-user");

    return map != null ? User.fromJson(map) : null;
  }

  Future<UserData> getCurrentUserData() async {
    final map = await _get("io.loomus.current-user");

    return UserData(map != null ? User.fromJson(map) : null);
  }

  Future<void> setCurrentUser(User? value) async {
    if (value == null) {
      final prefs = await SharedPreferences.getInstance();
      prefs.remove("io.loomus.current-user");
    } else {
      await _set("io.loomus.current-user", json.encode(value.toJson()));
    }
  }

  Future<Map<String, dynamic>?> _get(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final str = prefs.getString(key);
    if (str == null) return null;
    return json.decode(str);
  }

  Future<void> _set(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }
}
