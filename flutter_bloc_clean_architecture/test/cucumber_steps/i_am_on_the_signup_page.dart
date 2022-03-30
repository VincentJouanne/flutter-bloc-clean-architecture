import 'package:flutter/foundation.dart';
import 'package:flutter_bloc_clean_architecture/features/app/ui/routing/router.dart';
import 'package:flutter_bloc_clean_architecture/features/authentication/login/ui/login_page.dart';
import 'package:flutter_bloc_clean_architecture/features/authentication/signup/ui/signup_page.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_app.dart';

Future<void> iAmOnTheSignupPage(WidgetTester tester) async {
  await tester.pumpApp(initialLocation: Routes.login);
  expect(find.byType(LoginPage), findsOneWidget);
  await tester.tap(find.byKey(const Key('loginForm_createAccount_flatButton')));
  await tester.pumpAndSettle();
  expect(find.byType(SignUpPage), findsOneWidget);
}
