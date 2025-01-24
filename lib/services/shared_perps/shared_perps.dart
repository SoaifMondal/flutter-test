import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static final SharedPrefsHelper _instance = SharedPrefsHelper._internal();

  factory SharedPrefsHelper() {
    return _instance;
  }

  SharedPrefsHelper._internal();

  static const String _jwtTokenJsonKey = 'jwtTokenForJson';

  // static const String _userDataKey = 'userData';

  // Save JWT token
  Future<void> setJwtJsonToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_jwtTokenJsonKey, token);
  }

  // Retrieve JWT token
  Future<String?> getJwtJsonToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_jwtTokenJsonKey);
  }

  Future<void> removeJwtJsonToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_jwtTokenJsonKey);
  }

  // User Profile
  // Future<void> setUserProfile({required String profile}) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString(_userDataKey, profile);
  // }

  // Future<EmployeeProfileModel?> getUserProfile() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(_userDataKey) == null
  //       ? null
  //       : EmployeeProfileModel.fromJson(
  //           jsonDecode(prefs.getString(_userDataKey)!),
  //         );
  // }

  // Future<void> removeUserProfile() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.remove(_userDataKey);
  // }

}
