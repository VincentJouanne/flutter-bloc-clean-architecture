import 'package:flutter/material.dart';
import 'package:flutter_bloc_clean_architecture/dependency_container.dart';
import 'package:flutter_bloc_clean_architecture/features/authentication/login/ui/login_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('$LoginPage', () {
    setUpAll(() {
      resolveDependencies(isTesting: true);
    });
    testWidgets(
        'GIVEN the user is on the login page'
        'WHEN he enters an invalid email'
        'THEN he should see an error message', (tester) async {
      //GIVEN the user is on the login page
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));
      expect(find.byType(LoginPage), findsOneWidget);

      const invalidEmail = 'invalid-email';

      final emailInput =
          find.byKey(const Key('loginForm_emailInput_textField'));

      //WHEN he enters an invalid email
      await tester.enterText(emailInput, invalidEmail);
      await tester.pump();

      //THEN he should see an error message
      expect(find.text('invalid email'), findsOneWidget);
    });

    testWidgets(
        'GIVEN the user is on the login page and has entered a correct email'
        'WHEN he enters an invalid password'
        'THEN he should see an error message', (tester) async {
      //GIVEN the user is on the login page and has entered a correct email'
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));
      expect(find.byType(LoginPage), findsOneWidget);

      const validEmail = 'valid@gmail.com';
      const invalidPassword = 'invalid-password';
      final emailInput =
          find.byKey(const Key('loginForm_emailInput_textField'));

      final passwordInput =
          find.byKey(const Key('loginForm_passwordInput_textField'));
      await tester.enterText(emailInput, validEmail);

      //WHEN he enters an invalid password
      await tester.enterText(passwordInput, invalidPassword);
      await tester.pump();

      //THEN he should see an error message
      expect(find.text('invalid password'), findsOneWidget);
    });
  });
}
