import 'package:flutter/material.dart';
import 'package:theme/src/theme_resolver.dart';
import 'package:theme/src/widgets/app_text.dart';

class AppButton extends StatelessWidget {
  AppButton.primary(
      {Key? key,
      required String text,
      required Color backgroundColor,
      required VoidCallback onPressed,
      this.isLoading = false,
      this.elevation = 0,
      this.leadingWidget})
      : _text = text,
        _onPressed = onPressed,
        _height = 60,
        _backgroundColor = backgroundColor,
        _borderRadius = BorderRadius.circular(8.0),
        super(key: key);

  AppButton.secondary(
      {Key? key,
      required String text,
      required Color backgroundColor,
      required VoidCallback onPressed,
      this.isLoading = false,
      this.elevation = 0,
      this.leadingWidget})
      : _text = text,
        _onPressed = onPressed,
        _height = 50,
        _backgroundColor = backgroundColor,
        _borderRadius = BorderRadius.circular(12.0),
        super(key: key);

  final String _text;
  final Color _backgroundColor;
  final double _height;
  final BorderRadiusGeometry _borderRadius;
  final VoidCallback _onPressed;

  final double? elevation;
  final Widget? leadingWidget;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeResolver.of(context);
    return ElevatedButton(
      onPressed: _onPressed,
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: isLoading != null && isLoading == true
              ? [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: theme.colors.eclipse,
                    ),
                  )
                ]
              : [
                  if (leadingWidget != null) ...[
                    leadingWidget!,
                    const SizedBox(width: 15),
                  ],
                  AppText.p2(_text),
                ]),
      style: ElevatedButton.styleFrom(
          elevation: elevation,
          primary: _backgroundColor,
          minimumSize: Size.fromHeight(_height),
          shape: RoundedRectangleBorder(
            borderRadius: _borderRadius,
          )),
    );
  }
}
