import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_clean_architecture/core/extensions.dart';
import 'package:flutter_bloc_clean_architecture/core/usecase.dart';
import 'package:flutter_bloc_clean_architecture/infrastructure/authentication/port/authentication_gateway.dart';

class LoginWithGoogleUseCase implements UseCaseNoParams<void> {
  LoginWithGoogleUseCase(this._authenticationGateway);
  final AuthenticationGateway _authenticationGateway;

  @override
  Future<Either<Exception, void>> execute() async {
    return Task(_authenticationGateway.logInWithGoogle)
        .attempt()
        .mapLeftToException()
        .run();
  }
}
