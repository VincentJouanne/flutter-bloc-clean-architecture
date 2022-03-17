import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_clean_architecture/core/common/extensions.dart';
import 'package:flutter_bloc_clean_architecture/core/common/usecase.dart';
import 'package:flutter_bloc_clean_architecture/infrastructure/authentication/port/authentication_gateway.dart';

class SignUpUseCaseParams extends Equatable {
  const SignUpUseCaseParams({this.email = '', this.password = ''});

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

class SignUpUseCase implements UseCase<void, SignUpUseCaseParams> {
  SignUpUseCase(this._authenticationGateway);

  final AuthenticationGateway _authenticationGateway;

  @override
  Future<Either<Exception, void>> execute({
    required SignUpUseCaseParams params,
  }) async {
    return Task(
      () => _authenticationGateway.signUp(
        email: params.email,
        password: params.password,
      ),
    ).attempt().mapLeftToException().run();
  }
}
