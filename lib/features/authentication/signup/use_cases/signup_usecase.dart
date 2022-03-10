import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/common/usecase.dart';
import 'package:flutter_clean_architecture/infrastructure/authentication/port/authentication_gateway.dart';

class SignUpUseCaseParams {
  final String email;
  final String password;

  const SignUpUseCaseParams({this.email = '', this.password = ''});
}

class SignUpUseCase implements UseCase<void, SignUpUseCaseParams> {
  final AuthenticationGateway _authenticationGateway;

  SignUpUseCase(this._authenticationGateway);

  @override
  Future<Either<Exception, void>> execute(
      {required SignUpUseCaseParams params}) async {
    return Task(() => _authenticationGateway.signUp(
              email: params.email,
              password: params.password,
            ))
        .attempt()
        .map((either) => either.leftMap((obj) {
              try {
                return obj as Exception;
              } catch (e) {
                throw obj;
              }
            }))
        .run()
        .whenComplete(() => right);
  }
}
