import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/common/usecase.dart';
import 'package:flutter_clean_architecture/infrastructure/authentication/port/authentication_gateway.dart';

class LoginWithGoogleUseCaseParams {}

class LoginWithGoogleUseCase
    implements UseCase<void, LoginWithGoogleUseCaseParams> {
  final AuthenticationGateway _authenticationGateway;
  LoginWithGoogleUseCase(this._authenticationGateway);

  @override
  Future<Either<Exception, void>> execute(
      {required LoginWithGoogleUseCaseParams params}) async {
    return Task(() => _authenticationGateway.logInWithGoogle())
        .attempt()
        .map((either) => either.leftMap((obj) {
              return obj as Exception;
            }))
        .run()
        .whenComplete(() => right);
  }
}
