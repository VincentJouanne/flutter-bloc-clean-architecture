import 'package:flutter_bloc_clean_architecture/features/home/ui/home_page.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> iShouldBeRedirectedToTheHomePage(WidgetTester tester) async {
  expect(find.byType(HomePage), findsOneWidget);
}
