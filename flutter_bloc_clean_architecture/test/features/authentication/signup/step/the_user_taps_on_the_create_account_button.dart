import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theUserTapsOnTheCreateAccountButton(WidgetTester tester) async {
  final signUpButton =
      find.byKey(const Key('signUpForm_continue_raisedButton'));

  await tester.tap(signUpButton);
  await tester.pumpAndSettle();
}
