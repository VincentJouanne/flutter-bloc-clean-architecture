import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/core/common/extensions.dart';
import 'package:flutter_clean_architecture/core/common/usecase.dart';
import 'package:flutter_clean_architecture/infrastructure/authentication/port/authentication_gateway.dart';

class LoginWithGoogleUseCaseParams extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginWithGoogleUseCase implements UseCaseNoParams<void> {
  final AuthenticationGateway _authenticationGateway;
  LoginWithGoogleUseCase(this._authenticationGateway);

  @override
  Future<Either<Exception, void>> execute() async {
    return Task(() => _authenticationGateway.logInWithGoogle())
        .attempt()
        .mapLeftToException()
        .run()
        .whenComplete(() => right);
  }
}
