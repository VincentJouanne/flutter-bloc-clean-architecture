// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import './../../../../test/cucumber_steps/the_dependencies_are_resolved_and_the_app_is_running_on_a_device.dart';
import './../../../../test/cucumber_steps/the_dependencies_are_popped.dart';
import './../../../../test/cucumber_steps/i_am_on_the_signup_page.dart';
import './../../../../test/cucumber_steps/i_type_in_the_email_text_field_of_the_signup_page.dart';
import './../../../../test/cucumber_steps/i_type_in_the_password_text_field_of_the_signup_page.dart';
import './../../../../test/cucumber_steps/i_type_in_the_confirmed_password_text_field_of_the_signup_page.dart';
import './../../../../test/cucumber_steps/i_tap_on_the_signup_button.dart';
import './../../../../test/cucumber_steps/i_should_be_redirected_to_the_home_page.dart';
import './../../../../test/cucumber_steps/i_tap_on_disconnect_button.dart';
import './../../../../test/cucumber_steps/i_should_be_redirected_to_the_login_page.dart';
import './../../../../test/cucumber_steps/i_type_in_the_email_text_field_of_the_login_page.dart';
import './../../../../test/cucumber_steps/i_type_in_the_password_text_field_of_the_login_page.dart';
import './../../../../test/cucumber_steps/i_tap_on_the_login_button.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Future<void> bddSetUp(WidgetTester tester) async {
    await theDependenciesAreResolvedAndTheAppIsRunningOnADevice(tester);
  }
  Future<void> bddTearDown(WidgetTester tester) async {
    await theDependenciesArePopped(tester);
  }
  group('''Authentication''', () {
    testWidgets('''signup''', (tester) async {
      await bddSetUp(tester);
      await iAmOnTheSignupPage(tester);
      await iTypeInTheEmailTextFieldOfTheSignupPage(tester, 'vincent@gmail.com');
      await iTypeInThePasswordTextFieldOfTheSignupPage(tester, 'Password123');
      await iTypeInTheConfirmedPasswordTextFieldOfTheSignupPage(tester, 'Password123');
      await iTapOnTheSignupButton(tester);
      await iShouldBeRedirectedToTheHomePage(tester);
      await iTapOnDisconnectButton(tester);
      await iShouldBeRedirectedToTheLoginPage(tester);
      await iTypeInTheEmailTextFieldOfTheLoginPage(tester, 'vincent@gmail.com');
      await iTypeInThePasswordTextFieldOfTheLoginPage(tester, 'Password123');
      await iTapOnTheLoginButton(tester);
      await iShouldBeRedirectedToTheHomePage(tester);
      await bddTearDown(tester);
    });
  });
}
