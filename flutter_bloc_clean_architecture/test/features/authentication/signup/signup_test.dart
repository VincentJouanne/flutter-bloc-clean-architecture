// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/the_dependencies_are_resolved.dart';
import './step/an_unkown_user_on_the_signup_page.dart';
import './step/the_user_enters_valid_credentials.dart';
import './step/the_user_taps_on_the_create_account_button.dart';
import './step/the_user_see_the_login_page.dart';

void main() {
  Future<void> bddSetUp(WidgetTester tester) async {
    await theDependenciesAreResolved(tester);
  }
  group('''Sign up''', () {
    testWidgets('''An unknown user is able to sign up with valid credentials''', (tester) async {
      await bddSetUp(tester);
      await anUnkownUserOnTheSignupPage(tester);
      await theUserEntersValidCredentials(tester);
      await theUserTapsOnTheCreateAccountButton(tester);
      await theUserSeeTheLoginPage(tester);
    });
  });
}
