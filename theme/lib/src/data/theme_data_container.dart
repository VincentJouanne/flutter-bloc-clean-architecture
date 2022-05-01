import 'package:flutter/material.dart';
import 'package:theme/src/data/color_data.dart';
import 'package:theme/src/data/size_data.dart';
import 'package:theme/src/data/typography_data.dart';

class ThemeDataContainer {
  const ThemeDataContainer({
    required this.theme,
    required this.colors,
    required this.sizes,
  });

  factory ThemeDataContainer.main() {
    final colors = ColorData.main();
    final theme = ThemeData().fromColors(colors);
    final sizes = SizeData.main();

    return ThemeDataContainer(theme: theme, colors: colors, sizes: sizes);
  }

  final ThemeData theme;
  final ColorData colors;
  final SizeData sizes;
}

extension on ThemeData {
  ThemeData fromColors(ColorData colors) {
    return ThemeData(
      textTheme: TypographyData.getMainTextTheme(colors),
    );
  }
}
