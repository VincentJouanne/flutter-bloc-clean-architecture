import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/core/app/app.dart';
import 'package:flutter_bloc_clean_architecture/core/app/application/app_bloc_observer.dart';
import 'package:flutter_bloc_clean_architecture/core/config/firebase_options.dart';
import 'package:flutter_bloc_clean_architecture/dependency_container.dart';

Future<void> main() {
  return BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);
      await resolveDependencies();

      runApp(const App());
    },
    blocObserver: AppBlocObserver(),
  );
}
