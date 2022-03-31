import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_clean_architecture/features/authentication/domain/exceptions/login_with_email_and_password_exception.dart';
import 'package:flutter_bloc_clean_architecture/infrastructure/authentication/port/authentication_gateway.dart';
import 'package:flutter_bloc_clean_architecture/shared/usecase.dart';

class LoginWithEmailAndPasswordUseCaseParams extends Equatable {
  const LoginWithEmailAndPasswordUseCaseParams({
    this.email = '',
    this.password = '',
  });

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

class LoginWithEmailAndPasswordUseCase
    implements UseCase<Unit, LoginWithEmailAndPasswordUseCaseParams> {
  LoginWithEmailAndPasswordUseCase(this._authenticationGateway);
  final AuthenticationGateway _authenticationGateway;

  @override
  Future<Either<LogInWithEmailAndPasswordException, Unit>> execute({
    required LoginWithEmailAndPasswordUseCaseParams params,
  }) async {
    return _authenticationGateway.logInWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}
