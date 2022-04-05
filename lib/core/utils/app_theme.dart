import 'package:flutter/material.dart';

import '../cache/preference_store.dart';
import 'colors.dart';

class AppTheme {
  AppTheme(this._preferenceStore);

  final PreferenceStore _preferenceStore;

  late Brightness brightness;

  ThemeData get lightTheme {
    return ThemeData.light().copyWith(
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      primaryColorDark: AppColors.primary,
      primaryColorLight: AppColors.primary,
      highlightColor: AppColors.primary,
      appBarTheme: const AppBarTheme(
        color: AppColors.appBarColor,
      ),
      backgroundColor: AppColors.scaffoldBackgroundColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      primaryColorDark: AppColors.primary,
      primaryColorLight: AppColors.primary,
      appBarTheme: const AppBarTheme(
        color: AppColors.appBarColor,
      ),
      highlightColor: AppColors.primary,
      backgroundColor: AppColors.scaffoldBackgroundColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  ThemeData get theme {
    AppColors.isLightTheme = _preferenceStore.isAppThemeLight();
    return AppColors.isLightTheme ? lightTheme : darkTheme;
  }

  bool get isLight {
    AppColors.isLightTheme = _preferenceStore.isAppThemeLight();
    return AppColors.isLightTheme;
  }

  bool changeTheme() {
    _preferenceStore.setAppThemeLight(!isLight);
    AppColors.isLightTheme = isLight;
    return AppColors.isLightTheme;
  }
}
