import 'package:flutter_bloc_clean_architecture/features/authentication/login/ui/login_page.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_app.dart';

Future<void> iAmOnThePage(WidgetTester tester, dynamic param1) async {
  await tester.pumpApp(initialLocation: param1 as String);
  expect(find.byType(LoginPage), findsOneWidget);
}
