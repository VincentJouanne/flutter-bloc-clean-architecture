import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/config/firebase_options.dart';
import 'package:flutter_bloc_clean_architecture/dependency_container.dart';
import 'package:flutter_bloc_clean_architecture/features/app/ui/app.dart';

Future<void> main() {
  return BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      await resolveDependencies();

      runApp(const App());
    },
  );
}
