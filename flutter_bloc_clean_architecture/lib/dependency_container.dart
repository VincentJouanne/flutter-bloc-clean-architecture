// coverage:ignore-file
import 'dart:io';

import 'package:flutter_bloc_clean_architecture/features/app/bloc/app_bloc.dart';
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

Future<void> resolveDependencies({
  MockAuthenticationGateway? mockAuthenticationGateway,
  bool? isAuthenticated,
}) async {
  final isTesting = Platform.environment.containsKey('FLUTTER_TEST');

  // Infrastructure
  final authenticationGateway = _resolveDependencie<AuthenticationGateway>(
    isTesting: isTesting,
    mock: mockAuthenticationGateway,
    inMemory: InMemoryAuthenticationGateway(
      isAuthenticated: isAuthenticated ?? false,
    ),
    real: isTesting ? null : FirebaseAuthenticationGateway(),
  );

  await authenticationGateway.user.first;

  getIt
    ..registerLazySingleton<AuthenticationGateway>(
      () => authenticationGateway,
    )

    // Use-cases
    ..registerSingleton<SignUpUseCase>(SignUpUseCase(getIt()))
    ..registerSingleton<LoginWithEmailAndPasswordUseCase>(
      LoginWithEmailAndPasswordUseCase(getIt()),
    )
    ..registerSingleton<LoginWithGoogleUseCase>(
      LoginWithGoogleUseCase(getIt()),
    )

    // Blocs
    ..registerSingleton<AppBloc>(AppBloc(getIt()))
    ..registerFactory<SignUpCubit>(() => SignUpCubit(getIt()))
    ..registerFactory<LoginCubit>(() => LoginCubit(getIt(), getIt()));
}

T _resolveDependencie<T>({
  bool isTesting = false,
  T? mock,
  T? inMemory,
  T? real,
}) {
  if (isTesting && mock != null) {
    return mock;
  }

  if (isTesting && inMemory != null) {
    return inMemory;
  }

  // ignore: null_check_on_nullable_type_parameter
  return real!;
}
