import 'dart:convert';

import 'package:ez_navy_app/model/user_model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static final SharedPrefsHelper _instance = SharedPrefsHelper._internal();

  factory SharedPrefsHelper() {
    return _instance;
  }

  SharedPrefsHelper._internal();

  static const String _jwtTokenJsonKey = 'ezNavyAuthToken';

  static const String _userDataKey = 'ezNavyuserData';

  // Save, Get, Remove JWT token
  Future<void> setJwtJsonToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_jwtTokenJsonKey, token);
  }

  Future<String?> getJwtJsonToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_jwtTokenJsonKey);
  }

  Future<void> removeJwtJsonToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_jwtTokenJsonKey);
  }

  // Save, Get, Remove user Data
  Future<void> setUserProfile({required String profile}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userDataKey, profile);
  }

  Future<UserModel?> getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userDataKey) == null
        ? null
        : UserModel.fromJson(
            jsonDecode(prefs.getString(_userDataKey)!),
          );
  }

  Future<void> removeUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userDataKey);
  }
}
