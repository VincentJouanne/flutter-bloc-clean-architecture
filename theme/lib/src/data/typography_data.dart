import 'package:flutter/material.dart';
import 'package:theme/src/data/color_data.dart';

const _basePath = 'packages/theme/';
const _klasik = _basePath + 'Klasik';
const _manrope = _basePath + 'Manrope';

class TypographyData {
  const TypographyData({
    required this.displayLarge,
    required this.headlineLarge,
    required this.headlineMedium,
    required this.headlineSmall,
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
  });

  final TextStyle displayLarge;
  final TextStyle headlineLarge;
  final TextStyle headlineMedium;
  final TextStyle headlineSmall;

  final TextStyle titleLarge;
  final TextStyle titleMedium;
  final TextStyle titleSmall;

  final TextStyle bodyMedium;
  final TextStyle bodyLarge;
  final TextStyle bodySmall;

  factory TypographyData.main(ColorData colors) => TypographyData(
      displayLarge:
          TextStyle(fontFamily: _klasik, fontSize: 40, color: colors.eclipse),
      headlineLarge:
          TextStyle(fontFamily: _klasik, fontSize: 32, color: colors.eclipse),
      headlineMedium:
          TextStyle(fontFamily: _klasik, fontSize: 24, color: colors.eclipse),
      headlineSmall:
          TextStyle(fontFamily: _klasik, fontSize: 18, color: colors.eclipse),
      titleLarge: TextStyle(
          fontFamily: _manrope,
          fontWeight: FontWeight.w700,
          fontSize: 18,
          color: colors.eclipse),
      titleMedium: TextStyle(
          fontFamily: _manrope,
          fontWeight: FontWeight.w700,
          fontSize: 16,
          color: colors.eclipse),
      titleSmall: TextStyle(
          fontFamily: _manrope,
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: colors.eclipse),
      bodyLarge: TextStyle(
          fontFamily: _manrope,
          fontWeight: FontWeight.w700,
          fontSize: 12,
          color: colors.eclipse),
      bodyMedium: TextStyle(
          fontFamily: _manrope,
          fontWeight: FontWeight.w500,
          fontSize: 12,
          color: colors.eclipse),
      bodySmall: TextStyle(
          fontFamily: _manrope,
          fontWeight: FontWeight.w700,
          fontSize: 10,
          color: colors.eclipse));

  static TextTheme getMainTextTheme(ColorData colors) {
    return const TextTheme().copyWith(
      displayLarge: TypographyData.main(colors).displayLarge,
      headlineLarge: TypographyData.main(colors).headlineLarge,
      headlineMedium: TypographyData.main(colors).headlineMedium,
      headlineSmall: TypographyData.main(colors).headlineSmall,
      titleLarge: TypographyData.main(colors).titleLarge,
      titleMedium: TypographyData.main(colors).titleMedium,
      titleSmall: TypographyData.main(colors).titleSmall,
      bodyLarge: TypographyData.main(colors).bodyLarge,
      bodyMedium: TypographyData.main(colors).bodyMedium,
      bodySmall: TypographyData.main(colors).bodySmall,
    );
  }
}
