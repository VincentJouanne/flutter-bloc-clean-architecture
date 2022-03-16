import 'package:flutter/material.dart';
import 'package:flutter_bloc_clean_architecture/core/routing/router.dart';
import 'package:flutter_bloc_clean_architecture/dependency_container.dart';
import 'package:flutter_bloc_clean_architecture/features/authentication/login/ui/login_page.dart';
import 'package:flutter_bloc_clean_architecture/features/home/ui/home_page.dart';
import 'package:flutter_bloc_clean_architecture/infrastructure/authentication/adapters/fake/mock_authentication_gateway.dart';
import 'package:flutter_bloc_clean_architecture/infrastructure/authentication/adapters/models/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/pump_app.dart';

void main() {
  group('$LoginPage', () {
    group('Success cases', () {
      setUpAll(() {
        getIt.pushNewScope();
        resolveDependencies();
      });
      tearDownAll(() => getIt.popScope());

      testWidgets(
          '\n GIVEN the user is on the login page'
          '\n WHEN he enters a badly formatted email'
          '\n THEN he should see an error message', (tester) async {
        // GIVEN the user is on the login page
        await tester.pumpWidget(const MaterialApp(home: LoginPage()));
        expect(find.byType(LoginPage), findsOneWidget);

        const invalidEmail = 'invalid-email';

        final emailInput =
            find.byKey(const Key('loginForm_emailInput_textField'));

        // WHEN he enters a badly formatted email
        await tester.enterText(emailInput, invalidEmail);
        await tester.pump();

        // THEN he should see an error message
        expect(find.text('invalid email'), findsOneWidget);
      });

      testWidgets(
          '\n GIVEN the user is on the login page and has entered a correct email'
          '\n WHEN he enters a badly formatted password'
          '\n THEN he should see an error message', (tester) async {
        // GIVEN the user is on the login page and has entered a correct email
        await tester.pumpWidget(const MaterialApp(home: LoginPage()));
        expect(find.byType(LoginPage), findsOneWidget);

        const validEmail = 'valid@gmail.com';
        const invalidPassword = 'invalid-password';
        final emailInput =
            find.byKey(const Key('loginForm_emailInput_textField'));

        final passwordInput =
            find.byKey(const Key('loginForm_passwordInput_textField'));
        await tester.enterText(emailInput, validEmail);

        // WHEN he enters a badly formatted password
        await tester.enterText(passwordInput, invalidPassword);
        await tester.pump();

        // THEN he should see an error message
        expect(find.text('invalid password'), findsOneWidget);
      });

      testWidgets(
          '\n GIVEN an existing user on the login page who has entered well formatted email and password'
          '\n WHEN he clicks on login'
          '\n THEN he should be redirected to the home page', (tester) async {
        // GIVEN an existing user on the login page who has entered well formatted email and password
        await tester.pumpApp(initialLocation: Routes.login);
        expect(find.byType(LoginPage), findsOneWidget);

        const validEmail = 'valid@gmail.com';
        const valisPassword = 'Password123';
        final emailInput =
            find.byKey(const Key('loginForm_emailInput_textField'));
        final passwordInput =
            find.byKey(const Key('loginForm_passwordInput_textField'));

        await tester.enterText(emailInput, validEmail);
        await tester.enterText(passwordInput, valisPassword);
        await tester.pump();

        // WHEN he clicks on login
        await tester
            .tap(find.byKey(const Key("loginForm_continue_raisedButton")));

        await tester.pumpAndSettle();

        // THEN he should be redirected to the home page
        expect(find.byType(HomePage), findsOneWidget);
      });
    });
  });

  group('Failing cases', () {
    setUp(() {
      getIt.pushNewScope();

      final _mockAuthenticationGateway = MockAuthenticationGateway();
      when(() => _mockAuthenticationGateway.logInWithEmailAndPassword(
          email: 'valid@gmail.com',
          password: 'Password123')).thenAnswer((_) async => throw Exception());

      when(() => _mockAuthenticationGateway.user)
          .thenAnswer((_) => Stream.value(User.empty));

      when(() => _mockAuthenticationGateway.currentUser)
          .thenAnswer((_) => User.empty);

      resolveDependencies(
          mockAuthenticationGateway: _mockAuthenticationGateway);
    });
    tearDown(() => getIt.popScope());

    testWidgets(
        '\n GIVEN an unknown user on the login page who has entered well formatted email and password'
        '\n WHEN he clicks on login'
        '\n THEN he should not be redirected to the home page and see an error message',
        (tester) async {
      // GIVEN an unknown user on the login page who has entered well formatted email and password
      await tester.pumpApp(initialLocation: Routes.login);
      expect(find.byType(LoginPage), findsOneWidget);

      const validEmail = 'valid@gmail.com';
      const valisPassword = 'Password123';
      final emailInput =
          find.byKey(const Key('loginForm_emailInput_textField'));
      final passwordInput =
          find.byKey(const Key('loginForm_passwordInput_textField'));

      await tester.enterText(emailInput, validEmail);
      await tester.enterText(passwordInput, valisPassword);
      await tester.pump();

      // WHEN he clicks on login
      await tester
          .tap(find.byKey(const Key("loginForm_continue_raisedButton")));

      await tester.pumpAndSettle();

      // THEN he should not be redirected to the home page and see an error message
      expect(find.byType(HomePage), findsNothing);
      expect(find.text("Authentication Failure"), findsOneWidget);
    });
  });
}
