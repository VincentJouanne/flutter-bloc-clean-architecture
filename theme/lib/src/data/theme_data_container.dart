import 'package:flutter/material.dart';
import 'package:theme/src/data/color_data.dart';
import 'package:theme/src/data/typography_data.dart';

class ThemeDataContainer {
  const ThemeDataContainer({
    required this.theme,
    required this.colors,
  });

  factory ThemeDataContainer.main() {
    final colors = ColorData.main();
    final theme = ThemeData().fromColors(colors);

    return ThemeDataContainer(theme: theme, colors: colors);
  }

  final ThemeData theme;
  final ColorData colors;
}

extension on ThemeData {
  ThemeData fromColors(ColorData colors) {
    return ThemeData(
      textTheme: TypographyData.getMainTextTheme(colors),
    );
  }
}
