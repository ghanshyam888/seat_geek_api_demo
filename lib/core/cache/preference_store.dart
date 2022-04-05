// ignore_for_file: constant_identifier_names
import 'package:pedantic/pedantic.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceStore {
  static const String _IS_LOGGED_IN = 'is_logged_in';
  static const String _IS_APP_THEME_LIGHT = 'is_app_theme_light';

  late SharedPreferences _sharedPreferences;

  PreferenceStore();

  Future<bool> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return true;
  }

  Future<bool> reset() async {
    return true;
  }

  bool isAppThemeLight() {
    return _sharedPreferences.getBool(_IS_APP_THEME_LIGHT) ?? true;
  }

  Future<bool> setAppThemeLight(bool isLight) async {
    return _sharedPreferences.setBool(_IS_APP_THEME_LIGHT, isLight);
  }
}
