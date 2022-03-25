import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> iEnterInTheTextField(
  WidgetTester tester,
  dynamic param1,
  dynamic param2,
) async {
  final input = find.byKey(Key(param2 as String));
  await tester.enterText(input, param1 as String);
  await tester.pump();
}
