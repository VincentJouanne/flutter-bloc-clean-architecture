import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> heEntersABadlyFormattedEmail(WidgetTester tester) async {
  const invalidEmail = 'invalid-email';

  final emailInput = find.byKey(const Key('signUpForm_emailInput_textField'));

  await tester.enterText(emailInput, invalidEmail);
  await tester.pump();
}
