import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> iTypeInTheConfirmedPasswordTextFieldOfTheSignupPage(
  WidgetTester tester,
  String confirmedPassword,
) async {
  final passwordInput =
      find.byKey(const Key('signUpForm_confirmedPasswordInput_textField'));
  await tester.enterText(passwordInput, confirmedPassword);
  await tester.pump();
}
