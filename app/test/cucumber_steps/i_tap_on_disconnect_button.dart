import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> iTapOnDisconnectButton(WidgetTester tester) async {
  await tester.tap(find.byKey(const Key('homePage_logout_iconButton')));
  await tester.pumpAndSettle();
}
