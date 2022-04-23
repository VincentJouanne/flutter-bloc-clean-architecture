import 'package:app_theme/src/data/color.dart';
import 'package:flutter/material.dart';

class AppThemeData {
  const AppThemeData({
    required this.materialTheme,
    required this.color,
  });

  factory AppThemeData.main() {
    final color = ThemeColorData.main();

    return AppThemeData(materialTheme: ThemeData(), color: color);
  }

  final ThemeData materialTheme;
  final ThemeColorData color;
}
