// ignore_for_file: constant_identifier_names
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPref {
  SharedPreferences? _prefs;

  static const THEME_STATUS = "theme_status";
  static const IS_FIRST = "is_first";
  static const LANGUAGE_CODE = "language_code";
  static const RECENT_SEARCHES = "recent_searches";

  Future _initSharedPref() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future setDarkTheme(bool value) async {
    await _initSharedPref();
    await _prefs?.setBool(THEME_STATUS, value);
  }

  Future<bool> getDarkTheme() async {
    await _initSharedPref();
    return _prefs?.getBool(THEME_STATUS) ?? false;
  }

  Future setIsFirst(bool value) async {
    await _initSharedPref();
    await _prefs?.setBool(IS_FIRST, value);
  }

  Future<bool> getIsFirst() async {
    await _initSharedPref();
    return _prefs?.getBool(IS_FIRST) ?? true;
  }

  Future setLanguageCode(String value) async {
    await _initSharedPref();
    await _prefs?.setString(LANGUAGE_CODE, value);
  }

  Future<String> getLanguageCode() async {
    await _initSharedPref();
    return _prefs?.getString(LANGUAGE_CODE) ?? 'uz';
  }

  Future setRecentSearches(List<String> searchList) async {
    await _initSharedPref();
    await _prefs?.setStringList(RECENT_SEARCHES, searchList);
  }

  Future<List<String>> getRecentSearches() async {
    await _initSharedPref();
    return _prefs?.getStringList(RECENT_SEARCHES) ?? [];
  }
}