import 'package:flutter_test/flutter_test.dart';

Future<void> heShouldSeeTwoErrorMessages(
  WidgetTester tester,
  dynamic param1,
  dynamic param2,
) async {
  expect(find.text(param1 as String), findsOneWidget);
  expect(find.text(param2 as String), findsOneWidget);
}
