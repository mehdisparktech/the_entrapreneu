import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/route/app_routes.dart';
import '../../utils/log/app_log.dart';
import 'storage_keys.dart';

class LocalStorage {
  static String token = "";
  static String refreshToken = "";
  static bool isLogIn = false;
  static String userId = "";
  static String myImage = "";
  static String myName = "";
  static String myEmail = "";
  static String myRole = "";
  static String mobile = "";
  static String dateOfBirth = "";
  static String gender = "";
  static String experience = "";
  static double balance = 0.0;
  static bool verified = false;
  static String bio = "";
  static double lat = 0.0;
  static double log = 0.0;
  static bool accountInfoStatus = false;
  static String createdAt = "";
  static String updatedAt = "";

  // Create Local Storage Instance
  static SharedPreferences? preferences;

  /// Get SharedPreferences Instance
  static Future<SharedPreferences> _getStorage() async {
    preferences ??= await SharedPreferences.getInstance();
    return preferences!;
  }

  /// Get All Data From SharedPreferences
  static Future<void> getAllPrefData() async {
    final localStorage = await _getStorage();

    token = localStorage.getString(LocalStorageKeys.token) ?? "";
    refreshToken = localStorage.getString(LocalStorageKeys.refreshToken) ?? "";
    isLogIn = localStorage.getBool(LocalStorageKeys.isLogIn) ?? false;
    userId = localStorage.getString(LocalStorageKeys.userId) ?? "";
    myImage = localStorage.getString(LocalStorageKeys.myImage) ?? "";
    myName = localStorage.getString(LocalStorageKeys.myName) ?? "";
    myEmail = localStorage.getString(LocalStorageKeys.myEmail) ?? "";
    myRole = localStorage.getString(LocalStorageKeys.myRole) ?? "";
    mobile = localStorage.getString(LocalStorageKeys.mobile) ?? "";
    dateOfBirth = localStorage.getString(LocalStorageKeys.dateOfBirth) ?? "";
    gender = localStorage.getString(LocalStorageKeys.gender) ?? "";
    experience = localStorage.getString(LocalStorageKeys.experience) ?? "";
    balance = localStorage.getDouble(LocalStorageKeys.balance) ?? 0.0;
    verified = localStorage.getBool(LocalStorageKeys.verified) ?? false;
    bio = localStorage.getString(LocalStorageKeys.bio) ?? "";
    lat = localStorage.getDouble(LocalStorageKeys.lat) ?? 0.0;
    log = localStorage.getDouble(LocalStorageKeys.log) ?? 0.0;
    accountInfoStatus = localStorage.getBool(LocalStorageKeys.accountInfoStatus) ?? false;
    createdAt = localStorage.getString(LocalStorageKeys.createdAt) ?? "";
    updatedAt = localStorage.getString(LocalStorageKeys.updatedAt) ?? "";
    appLog(userId, source: "Local Storage");
  }

  /// Remove All Data From SharedPreferences
  static Future<void> removeAllPrefData() async {
    final localStorage = await _getStorage();
    await localStorage.clear();
    _resetLocalStorageData();
    Get.offAllNamed(AppRoutes.signIn);
    await getAllPrefData();
  }

  // Reset LocalStorage Data
  static void _resetLocalStorageData() {
    final localStorage = preferences!;
    localStorage.setString(LocalStorageKeys.token, "");
    localStorage.setString(LocalStorageKeys.refreshToken, "");
    localStorage.setString(LocalStorageKeys.userId, "");
    localStorage.setString(LocalStorageKeys.myImage, "");
    localStorage.setString(LocalStorageKeys.myName, "");
    localStorage.setString(LocalStorageKeys.myEmail, "");
    localStorage.setString(LocalStorageKeys.myRole, "");
    localStorage.setString(LocalStorageKeys.mobile, "");
    localStorage.setString(LocalStorageKeys.dateOfBirth, "");
    localStorage.setString(LocalStorageKeys.gender, "");
    localStorage.setString(LocalStorageKeys.experience, "");
    localStorage.setDouble(LocalStorageKeys.balance, 0.0);
    localStorage.setBool(LocalStorageKeys.verified, false);
    localStorage.setString(LocalStorageKeys.bio, "");
    localStorage.setDouble(LocalStorageKeys.lat, 0.0);
    localStorage.setDouble(LocalStorageKeys.log, 0.0);
    localStorage.setBool(LocalStorageKeys.accountInfoStatus, false);
    localStorage.setString(LocalStorageKeys.createdAt, "");
    localStorage.setString(LocalStorageKeys.updatedAt, "");
    localStorage.setBool(LocalStorageKeys.isLogIn, false);
  }

  // Save Data To SharedPreferences
  static Future<void> setString(String key, String value) async {
    final localStorage = await _getStorage();
    await localStorage.setString(key, value);
  }

  static Future<void> setBool(String key, bool value) async {
    final localStorage = await _getStorage();
    await localStorage.setBool(key, value);
  }

  static Future<void> setInt(String key, int value) async {
    final localStorage = await _getStorage();
    await localStorage.setInt(key, value);
  }

  static Future<void> setDouble(String key, double value) async {
    final localStorage = await _getStorage();
    await localStorage.setDouble(key, value);
  }
}
