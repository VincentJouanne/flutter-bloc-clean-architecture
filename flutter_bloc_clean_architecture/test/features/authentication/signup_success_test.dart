// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


import './../../cucumber_steps/the_dependencies_are_resolved.dart';
import './../../cucumber_steps/the_dependencies_are_popped.dart';
import './../../cucumber_steps/an_unknown_user_on_the_signup_page.dart';
import './../../cucumber_steps/he_enters_a_badly_formatted_email.dart';
import './../../cucumber_steps/he_should_see_an_error_message.dart';
import './../../cucumber_steps/he_enters_a_well_formatted_email.dart';
import './../../cucumber_steps/he_enters_a_badly_formatted_password.dart';
import './../../cucumber_steps/he_should_see_two_error_messages.dart';
import './../../cucumber_steps/he_enters_a_well_formatted_password.dart';
import './../../cucumber_steps/the_user_enters_valid_credentials.dart';
import './../../cucumber_steps/the_user_taps_on_the_create_account_button.dart';
import './../../cucumber_steps/the_user_see_the_login_page.dart';

void main() {
  Future<void> bddSetUp(WidgetTester tester) async {
    await theDependenciesAreResolved(tester);
  }
  Future<void> bddTearDown(WidgetTester tester) async {
    await theDependenciesArePopped(tester);
  }
  group('''Sign up form checks and success''', () {
    testWidgets('''email badly formatted''', (tester) async {
      await bddSetUp(tester);
      await anUnknownUserOnTheSignupPage(tester);
      await heEntersABadlyFormattedEmail(tester);
      await heShouldSeeAnErrorMessage(tester, 'invalid email');
      await bddTearDown(tester);
    });
    testWidgets('''email well formatted but password badly formatted''', (tester) async {
      await bddSetUp(tester);
      await anUnknownUserOnTheSignupPage(tester);
      await heEntersAWellFormattedEmail(tester);
      await heEntersABadlyFormattedPassword(tester);
      await heShouldSeeTwoErrorMessages(tester, 'invalid password', 'passwords do not match');
      await bddTearDown(tester);
    });
    testWidgets('''confirmed password missing''', (tester) async {
      await bddSetUp(tester);
      await anUnknownUserOnTheSignupPage(tester);
      await heEntersAWellFormattedEmail(tester);
      await heEntersAWellFormattedPassword(tester);
      await heShouldSeeAnErrorMessage(tester, 'passwords do not match');
      await bddTearDown(tester);
    });
    testWidgets('''An unknown user is able to sign up with valid credentials''', (tester) async {
      await bddSetUp(tester);
      await anUnknownUserOnTheSignupPage(tester);
      await theUserEntersValidCredentials(tester);
      await theUserTapsOnTheCreateAccountButton(tester);
      await theUserSeeTheLoginPage(tester);
      await bddTearDown(tester);
    });
  });
}
