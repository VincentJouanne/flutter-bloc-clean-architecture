import 'package:flutter_clean_architecture/features/authentication/signup/presenter/signup_cubit.dart';
import 'package:flutter_clean_architecture/features/authentication/signup/use-cases/signup_usecase.dart';
import 'package:flutter_clean_architecture/infrastructure/authentication/adapters/real/firebase_authentication_gateway.dart';
import 'package:flutter_clean_architecture/infrastructure/authentication/port/authentication_gateway.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

resolveDependencies() async {
  //Infrastructure
  final authenticationGateway = FirebaseAuthenticationGateway();
  await authenticationGateway.user.first;
  getIt.registerSingleton<AuthenticationGateway>(authenticationGateway);

  //Use-cases
  getIt.registerSingleton<SignUpUseCase>(SignUpUseCase(getIt()));

  //Presenters
  getIt.registerFactory<SignUpCubit>(() => SignUpCubit(getIt()));
}
