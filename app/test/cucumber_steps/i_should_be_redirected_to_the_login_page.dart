import 'package:flutter_bloc_clean_architecture/features/authentication/login/ui/login_page.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> iShouldBeRedirectedToTheLoginPage(WidgetTester tester) async {
  expect(find.byType(LoginPage), findsOneWidget);
}
