import 'package:flutter/material.dart';
import 'package:muzzone/config/theme/theme.dart';

class ThemeGenerator {
  static ThemeData themeGenerate(light) {
    if (light) {
      return MuzzoneTheme.lightTheme;
    } else {
      return MuzzoneTheme.darkTheme;
    }
  }
}
