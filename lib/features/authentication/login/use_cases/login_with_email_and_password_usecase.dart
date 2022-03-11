import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/core/common/usecase.dart';
import 'package:flutter_clean_architecture/infrastructure/authentication/port/authentication_gateway.dart';

class LoginWithEmailAndPasswordUseCaseParams extends Equatable {
  final String email;
  final String password;

  const LoginWithEmailAndPasswordUseCaseParams(
      {this.email = '', this.password = ''});

  @override
  // TODO: implement props
  List<Object?> get props => [email, password];
}

class LoginWithEmailAndPasswordUseCase
    implements UseCase<void, LoginWithEmailAndPasswordUseCaseParams> {
  final AuthenticationGateway _authenticationGateway;
  LoginWithEmailAndPasswordUseCase(this._authenticationGateway);

  @override
  Future<Either<Exception, void>> execute(
      {required LoginWithEmailAndPasswordUseCaseParams params}) async {
    return Task(() => _authenticationGateway.logInWithEmailAndPassword(
            email: params.email, password: params.password))
        .attempt()
        .map((either) => either.leftMap((obj) {
              return obj as Exception;
            }))
        .run()
        .whenComplete(() => right);
  }
}
