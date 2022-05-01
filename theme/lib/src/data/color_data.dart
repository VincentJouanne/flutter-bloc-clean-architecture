import 'package:flutter/material.dart';

class ColorData {
  ColorData({
    required this.sunset,
    required this.sunrise,
    required this.twilight,
    required this.morning,
    required this.fog,
    required this.skin,
    required this.lightSkin,
    required this.eclipse,
  });

  final Color sunset;
  final Color sunrise;
  final Color twilight;
  final Color morning;
  final Color fog;
  final Color skin;
  final Color lightSkin;
  final Color eclipse;

  factory ColorData.main() {
    return ColorData(
      sunset: const Color(0xFFF65B4E),
      sunrise: const Color(0xFFFDA758),
      twilight: const Color(0xFF29319F),
      morning: const Color(0xFFFFBA7C),
      fog: const Color(0xFFFFDEEF),
      skin: const Color(0xFFFFF3E9),
      lightSkin: const Color(0xFFFFF6ED),
      eclipse: const Color(0xFF573353),
    );
  }

  static ColorScheme getMainTheme(ColorData colors) {
    return ColorScheme(
      brightness: Brightness.light,
      primary: colors.eclipse,
      onPrimary: colors.eclipse,
      secondary: colors.eclipse,
      onSecondary: colors.eclipse,
      error: colors.eclipse,
      onError: colors.eclipse,
      background: colors.eclipse,
      onBackground: colors.eclipse,
      surface: colors.eclipse,
      onSurface: colors.eclipse,
    );
  }
}
