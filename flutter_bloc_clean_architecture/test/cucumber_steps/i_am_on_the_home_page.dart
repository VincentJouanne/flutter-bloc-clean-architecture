import 'package:flutter_bloc_clean_architecture/features/app/ui/routing/router.dart';
import 'package:flutter_bloc_clean_architecture/features/home/ui/home_page.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_app.dart';

Future<void> iAmOnTheHomePage(WidgetTester tester) async {
  await tester.pumpApp(initialLocation: Routes.home);
  expect(find.byType(HomePage), findsOneWidget);
}
