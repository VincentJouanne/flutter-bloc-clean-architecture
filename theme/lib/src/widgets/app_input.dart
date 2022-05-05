import 'dart:async';

import 'package:flutter/material.dart';
import 'package:theme/src/data/typography_data.dart';
import 'package:theme/src/theme_resolver.dart';
import 'package:theme/src/widgets/app_text.dart';
import 'package:theme/src/widgets/tooltip_shape_border.dart';

class AppInput extends StatefulWidget {
  const AppInput.primary({
    Key? key,
    required this.hintText,
    required this.onChanged,
    this.errorText,
    this.icon,
    this.obscureText = false,
    this.showHiddenInput,
    this.keyboardType,
    this.textInputAction,
  }) : super(key: key);

  final IconData? icon;
  final String hintText;
  final bool obscureText;
  final String? errorText;
  final VoidCallback? showHiddenInput;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  Timer? _debounce;
  bool showErrorTooltip = false;
  String textBeingTyped = '';

  bool get inputIsFilled => textBeingTyped.isNotEmpty;
  bool get inputIsInvalid => widget.errorText != null;

  void _remember(String text) {
    setState(() {
      textBeingTyped = text;
    });
  }

  final _debounceDuration = const Duration(milliseconds: 1500);
  _debounceErrorEvaluation() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    setState(() {
      showErrorTooltip = false;
    });
    _debounce = Timer(_debounceDuration, () {
      if (inputIsInvalid) {
        setState(() {
          showErrorTooltip = true;
        });
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeResolver.of(context);
    return Stack(clipBehavior: Clip.none, children: [
      TextField(
        onChanged: (str) {
          if (widget.onChanged != null) {
            widget.onChanged!(str);
          }

          _remember(str);
          _debounceErrorEvaluation();
        },
        keyboardType: widget.keyboardType,
        autofillHints: const [AutofillHints.email],
        obscureText: widget.obscureText,
        textInputAction: widget.textInputAction,
        style: TypographyData.main(theme.colors)
            .titleLarge
            .copyWith(color: theme.colors.sunrise),
        cursorColor: theme.colors.eclipse,
        decoration: InputDecoration(
          fillColor: theme.colors.lightSkin,
          filled: true,
          hintText: widget.hintText,
          hintStyle: TypographyData.main(theme.colors)
              .titleSmall
              .copyWith(color: theme.colors.eclipse.withOpacity(0.5)),
          prefixIcon: widget.icon != null
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: theme.sizes.m),
                  child: Icon(
                    widget.icon,
                    color: inputIsFilled
                        ? theme.colors.sunrise
                        : theme.colors.eclipse.withOpacity(0.5),
                  ),
                )
              : null,
          suffix: (widget.showHiddenInput != null)
              ? GestureDetector(
                  onTap: widget.showHiddenInput,
                  child: AppText.p3("Show",
                      textDecoration: TextDecoration.underline),
                )
              : null,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(theme.sizes.s),
          ),
        ),
      ),
      if (showErrorTooltip && inputIsFilled) _ErrorTooltip(widget: widget),
    ]);
  }
}

class _ErrorTooltip extends StatelessWidget {
  const _ErrorTooltip({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final AppInput widget;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeResolver.of(context);
    return Positioned(
      top: -40,
      left: 20,
      child: Container(
        decoration: ShapeDecoration(
          color: Colors.red,
          shape: TooltipShapeBorder(arrowArc: 0.3, radius: theme.sizes.xs),
          shadows: const [
            BoxShadow(
                color: Colors.black26, blurRadius: 4.0, offset: Offset(2, 2))
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(theme.sizes.m),
          child: AppText.p4(widget.errorText!, color: Colors.white),
        ),
      ),
    );
  }
}
