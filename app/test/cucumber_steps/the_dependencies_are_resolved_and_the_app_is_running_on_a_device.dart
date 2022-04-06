import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc_clean_architecture/config/firebase_options.dart';
import 'package:flutter_bloc_clean_architecture/dependency_container.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../helpers/ignore_network_calls.dart';

Future<void> theDependenciesAreResolvedAndTheAppIsRunningOnADevice(
  WidgetTester tester,
) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  getIt.pushNewScope();
  ignoreNetworkCalls();
  await resolveDependencies();
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
}
