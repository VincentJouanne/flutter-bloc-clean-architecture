import 'package:flutter/material.dart';
import 'package:theme/src/data/typography_data.dart';
import 'package:theme/src/theme_resolver.dart';
import 'package:theme/src/widgets/app_text.dart';

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
  String textBeingTyped = '';
  bool showErrorTooltip = false;

  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  bool get inputIsFilled => textBeingTyped.isNotEmpty;
  bool get inputIsInvalid => widget.errorText != null;

  void _remember(String text) {
    setState(() {
      textBeingTyped = text;
    });
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
  }

  void _onFocusChange() {
    setState(() {
      showErrorTooltip = !_focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeResolver.of(context);
    return Stack(clipBehavior: Clip.none, children: [
      TextField(
        focusNode: _focusNode,
        controller: _controller,
        onChanged: (str) {
          if (widget.onChanged != null) {
            widget.onChanged!(str);
          }

          _remember(str);
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
          errorText: inputIsFilled && inputIsInvalid && _focusNode.hasFocus
              ? widget.errorText
              : null,
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
    ]);
  }
}
