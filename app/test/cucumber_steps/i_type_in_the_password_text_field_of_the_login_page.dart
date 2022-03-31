import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> iTypeInThePasswordTextFieldOfTheLoginPage(
  WidgetTester tester,
  String password,
) async {
  final passwordInput =
      find.byKey(const Key('loginForm_passwordInput_textField'));
  await tester.enterText(passwordInput, password);
  await tester.pump();
}
