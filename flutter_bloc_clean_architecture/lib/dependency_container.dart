// coverage:ignore-file
import 'dart:io';

import 'package:flutter_bloc_clean_architecture/features/authentication/login/bloc/login_cubit.dart';
import 'package:flutter_bloc_clean_architecture/features/authentication/login/use_cases/login_with_email_and_password_usecase.dart';
import 'package:flutter_bloc_clean_architecture/features/authentication/login/use_cases/login_with_google_usecase.dart';
import 'package:flutter_bloc_clean_architecture/features/authentication/signup/bloc/signup_cubit.dart';
import 'package:flutter_bloc_clean_architecture/features/authentication/signup/use_cases/signup_usecase.dart';
import 'package:flutter_bloc_clean_architecture/infrastructure/authentication/adapters/fake/in_memory_authentication_gateway.dart';
import 'package:flutter_bloc_clean_architecture/infrastructure/authentication/adapters/fake/mock_authentication_gateway.dart';
import 'package:flutter_bloc_clean_architecture/infrastructure/authentication/adapters/real/firebase_authentication_gateway.dart';
import 'package:flutter_bloc_clean_architecture/infrastructure/authentication/port/authentication_gateway.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

resolveDependencies(
    {MockAuthenticationGateway? mockAuthenticationGateway}) async {
  final isTesting = Platform.environment.containsKey('FLUTTER_TEST');

  // Infrastructure
  final authenticationGateway = _resolveDependencie<AuthenticationGateway>(
      isTesting,
      mockAuthenticationGateway,
      InMemoryAuthenticationGateway(),
      isTesting ? null : FirebaseAuthenticationGateway());

  await authenticationGateway.user.first;
  getIt.registerLazySingleton<AuthenticationGateway>(
      () => authenticationGateway);

  // Use-cases
  getIt.registerSingleton<SignUpUseCase>(SignUpUseCase(getIt()));
  getIt.registerSingleton<LoginWithEmailAndPasswordUseCase>(
      LoginWithEmailAndPasswordUseCase(getIt()));
  getIt.registerSingleton<LoginWithGoogleUseCase>(
      LoginWithGoogleUseCase(getIt()));

  // Blocs
  getIt.registerFactory<SignUpCubit>(() => SignUpCubit(getIt()));
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt(), getIt()));
}

T _resolveDependencie<T>(bool isTesting, T? mock, T? fake, T? real) {
  if (isTesting && mock != null) {
    return mock;
  }

  if (isTesting && fake != null) {
    return fake;
  }

  return real!;
}
