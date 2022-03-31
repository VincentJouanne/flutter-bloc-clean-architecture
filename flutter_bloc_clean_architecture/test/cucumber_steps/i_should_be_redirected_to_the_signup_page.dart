import 'package:flutter_bloc_clean_architecture/features/authentication/signup/ui/signup_page.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> iShouldBeRedirectedToTheSignupPage(WidgetTester tester) async {
  expect(find.byType(SignUpPage), findsOneWidget);
}
