import 'package:flutter_bloc_clean_architecture/dependency_container.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theDependenciesArePopped(WidgetTester tester) async {
  await getIt.popScope();
}
