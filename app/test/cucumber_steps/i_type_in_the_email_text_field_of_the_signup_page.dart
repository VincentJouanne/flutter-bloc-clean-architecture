import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> iTypeInTheEmailTextFieldOfTheSignupPage(
  WidgetTester tester,
  String text,
) async {
  final emailInput = find.byKey(const Key('signUpForm_emailInput_textField'));
  await tester.enterText(emailInput, text);
  await tester.pump();
}
