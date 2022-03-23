import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> heEntersAWellFormattedEmail(WidgetTester tester) async {
  const validEmail = 'valid@gmail.com';

  final emailInput = find.byKey(const Key('signUpForm_emailInput_textField'));
  await tester.enterText(emailInput, validEmail);
  await tester.pump();
}
