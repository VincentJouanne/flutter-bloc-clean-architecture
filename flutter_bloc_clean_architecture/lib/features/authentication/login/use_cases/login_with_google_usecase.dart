import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_clean_architecture/core/usecase.dart';
import 'package:flutter_bloc_clean_architecture/infrastructure/authentication/port/authentication_gateway.dart';

class LoginWithGoogleUseCase implements UseCaseNoParams<Unit> {
  LoginWithGoogleUseCase(this._authenticationGateway);
  final AuthenticationGateway _authenticationGateway;

  @override
  Future<Either<Exception, Unit>> execute() async {
    return _authenticationGateway.logInWithGoogle();
  }
}
