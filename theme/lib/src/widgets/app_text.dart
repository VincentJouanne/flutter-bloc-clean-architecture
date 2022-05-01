import 'package:flutter/material.dart';

enum StyleEnum { h0, h1, h2, h3, p1, p2, p3, p4, p5, p6 }

class AppText extends StatelessWidget {
  const AppText._(
    this.text, {
    Key? key,
    this.color,
    this.textDecoration,
    required this.enumStyle,
  }) : super(key: key);

  final String text;
  final StyleEnum enumStyle;
  final Color? color;
  final TextDecoration? textDecoration;

  factory AppText.h0(
    String text, {
    Key? key,
    Color? color,
  }) {
    return AppText._(text, key: key, color: color, enumStyle: StyleEnum.h0);
  }

  factory AppText.h1(
    String text, {
    Key? key,
    Color? color,
  }) {
    return AppText._(text, key: key, color: color, enumStyle: StyleEnum.h1);
  }
  factory AppText.h2(
    String text, {
    Key? key,
    Color? color,
  }) {
    return AppText._(text, key: key, color: color, enumStyle: StyleEnum.h2);
  }
  factory AppText.h3(
    String text, {
    Key? key,
    Color? color,
  }) {
    return AppText._(text, key: key, color: color, enumStyle: StyleEnum.h3);
  }

  factory AppText.p1(
    String text, {
    Key? key,
    Color? color,
  }) {
    return AppText._(text, key: key, color: color, enumStyle: StyleEnum.p1);
  }

  factory AppText.p2(
    String text, {
    Key? key,
    Color? color,
    TextDecoration? textDecoration,
  }) {
    return AppText._(text,
        key: key,
        color: color,
        textDecoration: textDecoration,
        enumStyle: StyleEnum.p2);
  }

  factory AppText.p3(
    String text, {
    Key? key,
    Color? color,
    TextDecoration? textDecoration,
  }) {
    return AppText._(text,
        key: key,
        color: color,
        textDecoration: textDecoration,
        enumStyle: StyleEnum.p3);
  }
  factory AppText.p4(
    String text, {
    Key? key,
    Color? color,
  }) {
    return AppText._(text, key: key, color: color, enumStyle: StyleEnum.p4);
  }
  factory AppText.p5(
    String text, {
    Key? key,
    Color? color,
  }) {
    return AppText._(text, key: key, color: color, enumStyle: StyleEnum.p5);
  }

  factory AppText.p6(
    String text, {
    Key? key,
    Color? color,
  }) {
    return AppText._(text, key: key, color: color, enumStyle: StyleEnum.p6);
  }

  static TextStyle? styleOf(BuildContext context, StyleEnum enumStyle) {
    switch (enumStyle) {
      case StyleEnum.h0:
        return Theme.of(context).textTheme.displayLarge;
      case StyleEnum.h1:
        return Theme.of(context).textTheme.headlineLarge;
      case StyleEnum.h2:
        return Theme.of(context).textTheme.headlineMedium;
      case StyleEnum.h3:
        return Theme.of(context).textTheme.headlineSmall;
      case StyleEnum.p1:
        return Theme.of(context).textTheme.titleLarge;
      case StyleEnum.p2:
        return Theme.of(context).textTheme.titleMedium;
      case StyleEnum.p3:
        return Theme.of(context).textTheme.titleSmall;
      case StyleEnum.p4:
        return Theme.of(context).textTheme.bodyLarge;
      case StyleEnum.p5:
        return Theme.of(context).textTheme.bodyMedium;
      case StyleEnum.p6:
        return Theme.of(context).textTheme.bodySmall;
    }
  }

  @override
  Widget build(BuildContext context) {
    final _style = styleOf(context, enumStyle);
    return Text(text,
        style: _style!.copyWith(color: color, decoration: textDecoration));
  }
}
