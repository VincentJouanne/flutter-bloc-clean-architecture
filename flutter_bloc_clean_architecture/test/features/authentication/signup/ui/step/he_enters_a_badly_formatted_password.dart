import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> heEntersABadlyFormattedPassword(WidgetTester tester) async {
  const invalidPassword = '123';
  final passwordInput =
      find.byKey(const Key('signUpForm_passwordInput_textField'));
  await tester.enterText(passwordInput, invalidPassword);
  await tester.pump();
}
