// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './../../../../test/cucumber_steps/the_dependencies_are_resolved.dart';
import './../../../../test/cucumber_steps/the_dependencies_are_popped.dart';
import './../../../../test/cucumber_steps/i_am_on_the_login_page.dart';
import './../../../../test/cucumber_steps/i_type_in_the_email_text_field_of_the_login_page.dart';
import './../../../../test/cucumber_steps/i_should_see_a_text.dart';
import './../../../../test/cucumber_steps/i_type_in_the_password_text_field_of_the_login_page.dart';
import './../../../../test/cucumber_steps/i_tap_on_the_login_button.dart';
import './../../../../test/cucumber_steps/i_should_be_redirected_to_the_home_page.dart';
import './../../../../test/cucumber_steps/i_tap_on_the_login_with_google_button.dart';
import './../../../../test/cucumber_steps/i_tap_on_the_create_account_button.dart';
import './../../../../test/cucumber_steps/i_should_be_redirected_to_the_signup_page.dart';

void main() {
  Future<void> bddSetUp(WidgetTester tester) async {
    await theDependenciesAreResolved(tester);
  }
  Future<void> bddTearDown(WidgetTester tester) async {
    await theDependenciesArePopped(tester);
  }
  group('''Login form checks and success''', () {
    testWidgets('''email badly formatted''', (tester) async {
      await bddSetUp(tester);
      await iAmOnTheLoginPage(tester);
      await iTypeInTheEmailTextFieldOfTheLoginPage(tester, 'some-invalid-email');
      await iShouldSeeAText(tester, 'invalid email');
      await bddTearDown(tester);
    });
    testWidgets('''password badly formatted''', (tester) async {
      await bddSetUp(tester);
      await iAmOnTheLoginPage(tester);
      await iTypeInTheEmailTextFieldOfTheLoginPage(tester, 'vincent@gmail.com');
      await iTypeInThePasswordTextFieldOfTheLoginPage(tester, 'pass');
      await iShouldSeeAText(tester, 'invalid password');
      await bddTearDown(tester);
    });
    testWidgets('''login with credentials successfull''', (tester) async {
      await bddSetUp(tester);
      await iAmOnTheLoginPage(tester);
      await iTypeInTheEmailTextFieldOfTheLoginPage(tester, 'vincent@gmail.com');
      await iTypeInThePasswordTextFieldOfTheLoginPage(tester, 'Password123');
      await iTapOnTheLoginButton(tester);
      await iShouldBeRedirectedToTheHomePage(tester);
      await bddTearDown(tester);
    });
    testWidgets('''login with google successfull''', (tester) async {
      await bddSetUp(tester);
      await iAmOnTheLoginPage(tester);
      await iTapOnTheLoginWithGoogleButton(tester);
      await iShouldBeRedirectedToTheHomePage(tester);
      await bddTearDown(tester);
    });
    testWidgets('''going to signup page from login''', (tester) async {
      await bddSetUp(tester);
      await iAmOnTheLoginPage(tester);
      await iTapOnTheCreateAccountButton(tester);
      await iShouldBeRedirectedToTheSignupPage(tester);
      await bddTearDown(tester);
    });
  });
}
