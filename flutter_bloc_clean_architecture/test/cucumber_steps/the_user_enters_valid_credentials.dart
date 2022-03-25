import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theUserEntersValidCredentials(WidgetTester tester) async {
  const validEmail = 'valid@gmail.com';
  const validPassword = 'Password123';

  final emailInput = find.byKey(const Key('signUpForm_emailInput_textField'));
  final passwordInput =
      find.byKey(const Key('signUpForm_passwordInput_textField'));
  final confirmPasswordInput =
      find.byKey(const Key('signUpForm_confirmedPasswordInput_textField'));

  await tester.enterText(emailInput, validEmail);
  await tester.enterText(passwordInput, validPassword);
  await tester.enterText(confirmPasswordInput, validPassword);
  await tester.pump();
}
