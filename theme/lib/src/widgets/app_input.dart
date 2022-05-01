import 'package:flutter/material.dart';
import 'package:theme/src/data/typography_data.dart';
import 'package:theme/src/theme_resolver.dart';

class AppInput extends StatelessWidget {
  const AppInput.primary(
      {Key? key,
      required this.hintText,
      this.icon,
      this.obscureText = false,
      this.showHiddenInput})
      : super(key: key);

  final IconData? icon;
  final String hintText;
  final bool obscureText;
  final VoidCallback? showHiddenInput;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeResolver.of(context);
    return TextField(
      obscureText: obscureText,
      style: TypographyData.main(theme.colors)
          .titleLarge
          .copyWith(color: theme.colors.sunrise),
      cursorColor: theme.colors.eclipse,
      decoration: InputDecoration(
          fillColor: theme.colors.lightSkin,
          filled: true,
          hintText: hintText,
          hintStyle: TypographyData.main(theme.colors)
              .titleMedium
              .copyWith(color: theme.colors.eclipse.withOpacity(0.5)),
          prefixIcon: icon != null
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: theme.sizes.m),
                  child: Icon(
                    icon,
                    color: theme.colors.sunrise,
                  ),
                )
              : null,
          suffix: (showHiddenInput != null)
              ? GestureDetector(
                  onTap: showHiddenInput,
                  child: Text(
                    'Show',
                    style: TypographyData.main(theme.colors)
                        .titleSmall
                        .copyWith(
                            color: theme.colors.eclipse,
                            decoration: TextDecoration.underline),
                  ),
                )
              : null,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(theme.sizes.s),
          )),
    );
  }
}
