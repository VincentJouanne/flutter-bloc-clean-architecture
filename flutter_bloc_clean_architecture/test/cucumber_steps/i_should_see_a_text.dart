import 'package:flutter_test/flutter_test.dart';

Future<void> iShouldSeeAText(WidgetTester tester, dynamic param1) async {
  expect(find.text(param1 as String), findsOneWidget);
}
