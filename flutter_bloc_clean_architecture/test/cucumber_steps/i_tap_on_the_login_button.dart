import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> iTapOnTheLoginButton(WidgetTester tester) async {
  final signUpButton = find.byKey(const Key('loginForm_continue_raisedButton'));

  await tester.tap(signUpButton);
  await tester.pumpAndSettle();
}
