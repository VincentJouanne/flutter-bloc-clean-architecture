import 'package:flutter_bloc_clean_architecture/features/app/ui/routing/router.dart';
import 'package:flutter_bloc_clean_architecture/features/authentication/login/ui/login_page.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_app.dart';

Future<void> iAmOnTheLoginPage(WidgetTester tester) async {
  await tester.pumpApp(initialLocation: Routes.login);
  expect(find.byType(LoginPage), findsOneWidget);
}
