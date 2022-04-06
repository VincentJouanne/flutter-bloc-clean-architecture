// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


import './../../../../test/cucumber_steps/the_dependencies_are_resolved.dart';
import './../../../../test/cucumber_steps/the_dependencies_are_popped.dart';
import './../../../../test/cucumber_steps/i_am_on_the_signup_page.dart';
import './../../../../test/cucumber_steps/i_type_in_the_email_text_field_of_the_signup_page.dart';
import './../../../../test/cucumber_steps/i_should_see_a_text.dart';
import './../../../../test/cucumber_steps/i_type_in_the_password_text_field_of_the_signup_page.dart';
import './../../../../test/cucumber_steps/i_type_in_the_confirmed_password_text_field_of_the_signup_page.dart';
import './../../../../test/cucumber_steps/i_tap_on_the_signup_button.dart';
import './../../../../test/cucumber_steps/i_should_be_redirected_to_the_home_page.dart';

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
      await iAmOnTheSignupPage(tester);
      await iTypeInTheEmailTextFieldOfTheSignupPage(tester, 'invalid-email');
      await iShouldSeeAText(tester, 'invalid email');
      await bddTearDown(tester);
    });
    testWidgets('''email well formatted but password badly formatted''', (tester) async {
      await bddSetUp(tester);
      await iAmOnTheSignupPage(tester);
      await iTypeInTheEmailTextFieldOfTheSignupPage(tester, 'vincent@gmail.com');
      await iTypeInThePasswordTextFieldOfTheSignupPage(tester, 'pass');
      await iShouldSeeAText(tester, 'invalid password');
      await iShouldSeeAText(tester, 'passwords do not match');
      await bddTearDown(tester);
    });
    testWidgets('''confirmed password missing''', (tester) async {
      await bddSetUp(tester);
      await iAmOnTheSignupPage(tester);
      await iTypeInTheEmailTextFieldOfTheSignupPage(tester, 'vincent@gmail.com');
      await iTypeInThePasswordTextFieldOfTheSignupPage(tester, 'Password123');
      await iShouldSeeAText(tester, 'passwords do not match');
      await bddTearDown(tester);
    });
    testWidgets('''An unknown user is able to sign up with valid credentials''', (tester) async {
      await bddSetUp(tester);
      await iAmOnTheSignupPage(tester);
      await iTypeInTheEmailTextFieldOfTheSignupPage(tester, 'vincent@gmail.com');
      await iTypeInThePasswordTextFieldOfTheSignupPage(tester, 'Password123');
      await iTypeInTheConfirmedPasswordTextFieldOfTheSignupPage(tester, 'Password123');
      await iTapOnTheSignupButton(tester);
      await iShouldBeRedirectedToTheHomePage(tester);
      await bddTearDown(tester);
    });
  });
}
