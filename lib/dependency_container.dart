import 'package:flutter_clean_architecture/features/authentication/login/presenter/login_cubit.dart';
import 'package:flutter_clean_architecture/features/authentication/login/use_cases/login_with_email_and_password_usecase.dart';
import 'package:flutter_clean_architecture/features/authentication/login/use_cases/login_with_google_usecase.dart';
import 'package:flutter_clean_architecture/features/authentication/signup/presenter/signup_cubit.dart';
import 'package:flutter_clean_architecture/features/authentication/signup/use_cases/signup_usecase.dart';
import 'package:flutter_clean_architecture/infrastructure/authentication/adapters/real/firebase_authentication_gateway.dart';
import 'package:flutter_clean_architecture/infrastructure/authentication/port/authentication_gateway.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

resolveDependencies() async {
  // Infrastructure
  final authenticationGateway = FirebaseAuthenticationGateway();
  await authenticationGateway.user.first;
  getIt.registerSingleton<AuthenticationGateway>(authenticationGateway);

  // Use-cases
  getIt.registerSingleton<SignUpUseCase>(SignUpUseCase(getIt()));
  getIt.registerSingleton<LoginWithEmailAndPasswordUseCase>(
      LoginWithEmailAndPasswordUseCase(getIt()));
  getIt.registerSingleton<LoginWithGoogleUseCase>(
      LoginWithGoogleUseCase(getIt()));

  // Presenters
  getIt.registerFactory<SignUpCubit>(() => SignUpCubit(getIt()));
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt(), getIt()));
}
