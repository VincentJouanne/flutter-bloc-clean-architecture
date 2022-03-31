import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> iTypeInTheEmailTextFieldOfTheLoginPage(
  WidgetTester tester,
  String email,
) async {
  final emailInput = find.byKey(const Key('loginForm_emailInput_textField'));
  await tester.enterText(emailInput, email);
  await tester.pump();
}
