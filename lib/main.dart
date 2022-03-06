import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/core/app/app.dart';
import 'package:flutter_clean_architecture/core/app/application/app_bloc_observer.dart';
import 'package:flutter_clean_architecture/infrastructure/authentication/adapters/real/firebase_authentication_gateway.dart';

Future<void> main() {
  return BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      final authenticationGateway = FirebaseAuthenticationGateway();
      await authenticationGateway.user.first;
      runApp(App(authenticationGateway: authenticationGateway));
    },
    blocObserver: AppBlocObserver(),
  );
}
