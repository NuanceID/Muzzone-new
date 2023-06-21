import 'dart:developer';

import 'package:flutter/material.dart';

class ThemeModeGenerator {
  static ThemeMode themeModeGenerate(light) {
    if (light) {
      log('light theme');
      return ThemeMode.light;
    } else {
      log('dark theme');

      return ThemeMode.dark;
    }
  }
}
