import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> iTapOnTheCreateAccountButton(WidgetTester tester) async {
  await tester.tap(find.byKey(const Key('loginForm_createAccount_flatButton')));

  await tester.pumpAndSettle();
}
