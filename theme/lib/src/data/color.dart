import 'package:flutter/painting.dart';

class ThemeColorData {
  ThemeColorData({
    required this.sunset,
    required this.twilight,
    required this.morning,
    required this.fog,
    required this.eclipse,
  });

  factory ThemeColorData.main() {
    return ThemeColorData(
      sunset: const Color(0xFFF65B4E),
      twilight: const Color(0xFF29319F),
      morning: const Color(0xFFFFBA7C),
      fog: const Color(0xFFFFDEEF),
      eclipse: const Color(0xFF573353),
    );
  }

  final Color sunset;
  final Color twilight;
  final Color morning;
  final Color fog;
  final Color eclipse;
}
