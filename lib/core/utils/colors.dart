// ignore_for_file: constant_identifier_names,avoid_classes_with_only_static_members

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../constants.dart';

abstract class GradientColors {
  static const primary = [
    Color(0xFF822FA3),
    Color(0xFFEF5984),
    Color(0xFFFF3F5C)
  ];

  static const darkGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 1.0],
    colors: [AppColors.primary, Colors.transparent],
  );
}

abstract class AppColors {
  static bool isLightTheme = false;
  static const primary = Color(0xFFFF4552);
  static const accentColor = Color(0xFFFF6600);
  static const scaffoldBackgroundColor = Colors.white;
  static Color get backgroundColor =>
      isLightTheme ? Colors.white : const Color(0xff3A3A3B);

  static const appBarColor = Color(0xFF113146);
  static Color get buttonText => isLightTheme ? Colors.white : primary;
  static Color get buttonBackground => isLightTheme ? primary : Colors.white;
}
