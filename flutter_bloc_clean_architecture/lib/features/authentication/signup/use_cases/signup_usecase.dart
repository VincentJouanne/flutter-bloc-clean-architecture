import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_clean_architecture/core/usecase.dart';
import 'package:flutter_bloc_clean_architecture/features/authentication/domain/exceptions/sign_up_with_email_and_password_exception.dart';
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
  Future<Either<SignUpWithEmailAndPasswordException, void>> execute({
    required SignUpUseCaseParams params,
  }) async {
    return _authenticationGateway.signUp(
      email: params.email,
      password: params.password,
    );
  }
}
