// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './../../../../test/cucumber_steps/the_dependencies_are_resolved_with_an_error_when_logging_in.dart';
import './../../../../test/cucumber_steps/the_dependencies_are_popped.dart';
import './../../../../test/cucumber_steps/i_am_on_the_login_page.dart';
import './../../../../test/cucumber_steps/i_type_in_the_email_text_field_of_the_login_page.dart';
import './../../../../test/cucumber_steps/i_type_in_the_password_text_field_of_the_login_page.dart';
import './../../../../test/cucumber_steps/i_tap_on_the_login_button.dart';
import './../../../../test/cucumber_steps/i_should_see_a_text.dart';

void main() {
  Future<void> bddSetUp(WidgetTester tester) async {
    await theDependenciesAreResolvedWithAnErrorWhenLoggingIn(tester);
  }
  Future<void> bddTearDown(WidgetTester tester) async {
    await theDependenciesArePopped(tester);
  }
  group('''Login failure''', () {
    testWidgets('''account disabled''', (tester) async {
      await bddSetUp(tester);
      await iAmOnTheLoginPage(tester);
      await iTypeInTheEmailTextFieldOfTheLoginPage(tester, 'vincent@gmail.com');
      await iTypeInThePasswordTextFieldOfTheLoginPage(tester, 'Password123');
      await iTapOnTheLoginButton(tester);
      await iShouldSeeAText(tester, 'This user has been disabled. Please contact support for help.');
      await bddTearDown(tester);
    });
  });
}
