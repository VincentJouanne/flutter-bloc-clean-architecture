import 'package:flutter/material.dart';
import 'package:flutter_bloc_clean_architecture/core/routing/router.dart';
import 'package:flutter_bloc_clean_architecture/dependency_container.dart';
import 'package:flutter_bloc_clean_architecture/features/authentication/common/domain/entities/user.dart';
import 'package:flutter_bloc_clean_architecture/features/authentication/login/ui/login_page.dart';
import 'package:flutter_bloc_clean_architecture/features/authentication/signup/ui/signup_page.dart';
import 'package:flutter_bloc_clean_architecture/infrastructure/authentication/adapters/fake/mock_authentication_gateway.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/pump_app.dart';

void main() {
  group('$SignUpPage', () {
    group('Success cases', () {
      setUp(() {
        getIt.pushNewScope();
        resolveDependencies();
      });
      tearDown(getIt.popScope);

      testUI(
        given: 'an unknown user on the signup page',
        when: 'he enters a badly formatted email',
        then: 'he should see an error message',
        callback: (tester) async {
          // GIVEN an unknown user on the signup page
          await tester.pumpApp(initialLocation: Routes.signup);
          expect(find.byType(SignUpPage), findsOneWidget);

          const invalidEmail = 'invalid-email';

          final emailInput =
              find.byKey(const Key('signUpForm_emailInput_textField'));

          // WHEN he enters a badly formatted email and try to signup
          await tester.enterText(emailInput, invalidEmail);
          await tester.pump();

          // THEN he should see an error message
          expect(find.text('invalid email'), findsOneWidget);
        },
      );

      testUI(
        given: 'an unknown user on the signup page',
        when: 'he enters a well formatted email but a badly formatted password',
        then: 'he should see two error messages',
        callback: (tester) async {
          // GIVEN an unknown user on the signup page
          await tester.pumpApp(initialLocation: Routes.signup);
          expect(find.byType(SignUpPage), findsOneWidget);

          const validEmail = 'valid@gmail.com';
          const invalisPassword = '123';

          final emailInput =
              find.byKey(const Key('signUpForm_emailInput_textField'));
          final passwordInput =
              find.byKey(const Key('signUpForm_passwordInput_textField'));
          // WHEN he enters a badly formatted email and try to signup
          await tester.enterText(emailInput, validEmail);
          await tester.enterText(passwordInput, invalisPassword);
          await tester.pump();

          // THEN he should see two error messages
          expect(find.text('invalid password'), findsOneWidget);
          expect(find.text('passwords do not match'), findsOneWidget);
        },
      );

      testUI(
        given: 'an unknown user on the signup page',
        when:
            '''he enters a well formatted email and password but no confirm password''',
        then: 'he should see one error message saying passwords do not match',
        callback: (tester) async {
          // GIVEN an unknown user on the signup page
          await tester.pumpApp(initialLocation: Routes.signup);
          expect(find.byType(SignUpPage), findsOneWidget);

          const validEmail = 'valid@gmail.com';
          const validPassword = 'Password123';

          final emailInput =
              find.byKey(const Key('signUpForm_emailInput_textField'));
          final passwordInput =
              find.byKey(const Key('signUpForm_passwordInput_textField'));

          // WHEN he enters a well formatted email
          // and password but no confirm password
          await tester.enterText(emailInput, validEmail);
          await tester.enterText(passwordInput, validPassword);

          await tester.pump();

          // THEN he should see one error message saying passwords do not match
          expect(find.text('invalid password'), findsNothing);
          expect(find.text('passwords do not match'), findsOneWidget);
        },
      );

      testUI(
        given: 'an unknown user on the signup page',
        when:
            '''he enters a well formatted email and a badly formatted password in the two passwords input''',
        then: 'he should see only one error message saying password is invalid',
        callback: (tester) async {
          // GIVEN an unknown user on the signup page
          await tester.pumpApp(initialLocation: Routes.signup);
          expect(find.byType(SignUpPage), findsOneWidget);

          const validEmail = 'valid@gmail.com';
          const invalidPassword = '123';

          final emailInput =
              find.byKey(const Key('signUpForm_emailInput_textField'));
          final passwordInput =
              find.byKey(const Key('signUpForm_passwordInput_textField'));
          final confirmPasswordInput = find
              .byKey(const Key('signUpForm_confirmedPasswordInput_textField'));
          // WHEN he enters a badly formatted email and try to signup
          await tester.enterText(emailInput, validEmail);
          await tester.enterText(passwordInput, invalidPassword);
          await tester.enterText(confirmPasswordInput, invalidPassword);

          await tester.pump();

          // THEN he should see only one error message
          expect(find.text('invalid password'), findsOneWidget);
          expect(find.text('passwords do not match'), findsNothing);
        },
      );

      testUI(
        given: 'an unknown user on the signup page who has filled the form',
        when: '''he clicks on signup button''',
        then: 'he should be redirected to the login page',
        callback: (tester) async {
          // to have an initial location with a prefilled stack.
          // GIVEN an unknown user on the signup page who has filled the form
          await tester.pumpApp(initialLocation: Routes.login);
          expect(find.byType(LoginPage), findsOneWidget);
          await tester
              .tap(find.byKey(const Key('loginForm_createAccount_flatButton')));
          await tester.pumpAndSettle();
          expect(find.byType(SignUpPage), findsOneWidget);

          const validEmail = 'valid@gmail.com';
          const validPassword = 'Password123';

          final emailInput =
              find.byKey(const Key('signUpForm_emailInput_textField'));
          final passwordInput =
              find.byKey(const Key('signUpForm_passwordInput_textField'));
          final confirmPasswordInput = find
              .byKey(const Key('signUpForm_confirmedPasswordInput_textField'));

          final signUpButton =
              find.byKey(const Key('signUpForm_continue_raisedButton'));
          await tester.enterText(emailInput, validEmail);
          await tester.enterText(passwordInput, validPassword);
          await tester.enterText(confirmPasswordInput, validPassword);
          await tester.pump();

          // WHENhe clicks on signup button
          await tester.tap(signUpButton);
          await tester.pumpAndSettle();

          // THEN he should be redirected to the login page
          expect(find.byType(LoginPage), findsOneWidget);
        },
      );
    });

    group('Failing cases', () {
      setUp(() {
        getIt.pushNewScope();

        final _mockAuthenticationGateway = MockAuthenticationGateway();
        when(
          () => _mockAuthenticationGateway.signUp(
            email: 'valid@gmail.com',
            password: 'Password123',
          ),
        ).thenAnswer((_) async => throw Exception());

        when(() => _mockAuthenticationGateway.user)
            .thenAnswer((_) => Stream.value(User.empty));

        when(() => _mockAuthenticationGateway.currentUser)
            .thenAnswer((_) => User.empty);

        resolveDependencies(
          mockAuthenticationGateway: _mockAuthenticationGateway,
        );
      });
      tearDown(getIt.popScope);

      testUI(
        given:
            '''an unknown user on the signup page who has filled the form and clicked on signup button''',
        when: 'somehting wrong happens during the request',
        then: 'he should see a snackbar with an error message',
        callback: (tester) async {
          // GIVEN: an unknown user on the signup page who has filled
          // the form and clicked on signup button
          await tester.pumpApp(initialLocation: Routes.signup);
          expect(find.byType(SignUpPage), findsOneWidget);

          const validEmail = 'valid@gmail.com';
          const validPassword = 'Password123';

          final emailInput =
              find.byKey(const Key('signUpForm_emailInput_textField'));
          final passwordInput =
              find.byKey(const Key('signUpForm_passwordInput_textField'));
          final confirmPasswordInput = find
              .byKey(const Key('signUpForm_confirmedPasswordInput_textField'));

          final signUpButton =
              find.byKey(const Key('signUpForm_continue_raisedButton'));
          await tester.enterText(emailInput, validEmail);
          await tester.enterText(passwordInput, validPassword);
          await tester.enterText(confirmPasswordInput, validPassword);
          await tester.pump();

          // WHEN: somehting wrong happens during the request
          await tester.tap(signUpButton);
          await tester.pumpAndSettle();

          // THEN: he should see a snackbar with an error message
          expect(find.byType(SignUpPage), findsOneWidget);
          expect(find.byType(SnackBar), findsOneWidget);
          expect(find.text('Sign Up Failure'), findsOneWidget);
        },
      );
    });
  });
}
