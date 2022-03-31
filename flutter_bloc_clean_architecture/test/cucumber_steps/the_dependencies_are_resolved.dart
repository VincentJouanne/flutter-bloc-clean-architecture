import 'package:flutter_bloc_clean_architecture/dependency_container.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/ignore_network_calls.dart';

Future<void> theDependenciesAreResolved(WidgetTester tester) async {
  getIt.pushNewScope();
  ignoreNetworkCalls();
  await resolveDependencies();
}
