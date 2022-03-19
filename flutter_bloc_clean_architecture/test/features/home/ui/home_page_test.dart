import 'package:flutter/widgets.dart';
import 'package:flutter_bloc_clean_architecture/dependency_container.dart';
import 'package:flutter_bloc_clean_architecture/features/app/ui/routing/router.dart';
import 'package:flutter_bloc_clean_architecture/features/authentication/login/ui/login_page.dart';
import 'package:flutter_bloc_clean_architecture/features/home/ui/home_page.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/ignore_network_calls.dart';
import '../../../helpers/pump_app.dart';

void main() {
  group('$HomePage', () {
    setUpAll(() {
      getIt.pushNewScope();
      resolveDependencies(isAuthenticated: true);
      ignoreNetworkCalls();
    });
    tearDownAll(getIt.popScope);

    testUI(
      given: 'an authenticated user on the home page',
      when: 'he clicks on the logout button',
      then: 'he should be redirected to login page',
      callback: (tester) async {
        // GIVEN an authenticated user on the home page
        await tester.pumpApp(initialLocation: Routes.home);
        expect(find.byType(HomePage), findsOneWidget);

        // WHEN he clicks on the logout button
        await tester.tap(find.byKey(const Key('homePage_logout_iconButton')));
        await tester.pumpAndSettle();

        // THEN he should be redirected to the login page
        expect(find.byType(LoginPage), findsOneWidget);
      },
    );
  });
}
