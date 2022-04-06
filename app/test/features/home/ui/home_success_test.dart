// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './../../../../test/cucumber_steps/the_dependencies_are_resolved_and_the_user_is_authenticated.dart';
import './../../../../test/cucumber_steps/the_dependencies_are_popped.dart';
import './../../../../test/cucumber_steps/i_am_on_the_home_page.dart';
import './../../../../test/cucumber_steps/i_tap_on_disconnect_button.dart';
import './../../../../test/cucumber_steps/i_should_be_redirected_to_the_login_page.dart';

void main() {
  Future<void> bddSetUp(WidgetTester tester) async {
    await theDependenciesAreResolvedAndTheUserIsAuthenticated(tester);
  }
  Future<void> bddTearDown(WidgetTester tester) async {
    await theDependenciesArePopped(tester);
  }
  group('''Home page''', () {
    testWidgets('''disconnection''', (tester) async {
      await bddSetUp(tester);
      await iAmOnTheHomePage(tester);
      await iTapOnDisconnectButton(tester);
      await iShouldBeRedirectedToTheLoginPage(tester);
      await bddTearDown(tester);
    });
  });
}
