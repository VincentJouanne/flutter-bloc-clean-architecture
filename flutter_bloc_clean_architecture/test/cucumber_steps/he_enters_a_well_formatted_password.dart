import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> heEntersAWellFormattedPassword(WidgetTester tester) async {
  const validPassword = 'Password123';
  final passwordInput =
      find.byKey(const Key('signUpForm_passwordInput_textField'));
  await tester.enterText(passwordInput, validPassword);
  await tester.pump();
}
