import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> iTypeInThePasswordTextFieldOfTheSignupPage(
  WidgetTester tester,
  String password,
) async {
  final passwordInput =
      find.byKey(const Key('signUpForm_passwordInput_textField'));
  await tester.enterText(passwordInput, password);
  await tester.pump();
}
