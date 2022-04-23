import 'package:app_theme/src/data/data.dart';
import 'package:flutter/material.dart';

class AppTheme extends InheritedTheme {
  const AppTheme({Key? key, required Widget child, required this.data})
      : super(child: child, key: key);

  final AppThemeData data;

  static AppThemeData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppTheme>()!.data;
  }

  @override
  bool updateShouldNotify(covariant AppTheme oldWidget) {
    return data != oldWidget.data;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return AppTheme(
      data: data,
      child: child,
    );
  }
}
