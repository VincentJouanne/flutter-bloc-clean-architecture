import 'package:flutter/material.dart';
import 'package:theme/src/data/theme_data_container.dart';

class ThemeResolver extends InheritedTheme {
  const ThemeResolver({Key? key, required Widget child, required this.data})
      : super(child: child, key: key);

  final ThemeDataContainer data;

  static ThemeDataContainer of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeResolver>()!.data;
  }

  @override
  bool updateShouldNotify(covariant ThemeResolver oldWidget) {
    return data != oldWidget.data;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return ThemeResolver(
      data: data,
      child: child,
    );
  }
}
