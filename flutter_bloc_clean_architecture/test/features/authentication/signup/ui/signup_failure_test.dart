// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/the_dependencies_are_resolved_with_an_error_when_signing_up.dart';
import './step/an_unknown_user_on_the_signup_page.dart';
import './step/the_user_enters_valid_credentials.dart';
import './step/the_user_taps_on_the_create_account_button.dart';
import './step/he_should_see_an_error_message.dart';

void main() {
  Future<void> bddSetUp(WidgetTester tester) async {
    await theDependenciesAreResolvedWithAnErrorWhenSigningUp(tester);
  }
  group('''Sign up fails''', () {
    testWidgets('''An unknown user has entered valid credentials but his address mail has beed disabled''', (tester) async {
      await bddSetUp(tester);
      await anUnknownUserOnTheSignupPage(tester);
      await theUserEntersValidCredentials(tester);
      await theUserTapsOnTheCreateAccountButton(tester);
      await heShouldSeeAnErrorMessage(tester, 'This user has been disabled. Please contact support for help.');
    });
  });
}
