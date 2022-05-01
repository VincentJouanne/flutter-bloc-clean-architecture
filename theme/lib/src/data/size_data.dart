import 'package:flutter/widgets.dart';

/// {@template sizes}
/// Data for the sizes of the theme.
/// {@endtemplate}

class SizeData {
  /// {@macro sizes}
  const SizeData({
    required this.xs,
    required this.s,
    required this.m,
    required this.l,
    required this.xl,
  });

  /// Default theme
  factory SizeData.main() => const SizeData(
        xs: 5,
        s: 10,
        m: 15,
        l: 20,
        xl: 30,
      );

  /// 5
  final double xs;

  /// 10
  final double s;

  /// 15
  final double m;

  /// 20
  final double l;

  /// 30
  final double xl;

  /// Get corresponding insets
  ThemeEdgeInsetsSizeData get insets => ThemeEdgeInsetsSizeData(this);
}

/// {@macro sizes}
class ThemeEdgeInsetsSizeData {
  /// {@macro sizes}
  const ThemeEdgeInsetsSizeData(this._spacing);

  final SizeData _spacing;

  /// 8
  EdgeInsets get xs => EdgeInsets.all(_spacing.xs);

  /// 16
  EdgeInsets get s => EdgeInsets.all(_spacing.s);

  /// 32
  EdgeInsets get m => EdgeInsets.all(_spacing.m);

  /// 48
  EdgeInsets get l => EdgeInsets.all(_spacing.l);

  /// 64
  EdgeInsets get xl => EdgeInsets.all(_spacing.xl);
}
