// coverage:ignore-file
import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_clean_architecture/features/authentication/domain/domain.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

abstract class AuthenticationGateway {
  Stream<User> get user;
  User get currentUser;
  Future<Either<SignUpWithEmailAndPasswordException, Unit>> signUp({
    required String email,
    required String password,
  }) async {
    throw UnimplementedError();
  }

  Future<Either<LogInWithGoogleException, Unit>> logInWithGoogle() async {
    throw UnimplementedError();
  }

  Future<Either<LogInWithEmailAndPasswordException, Unit>>
      logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    throw UnimplementedError();
  }

  Future<Either<LogOutException, Unit>> logOut() async {
    throw UnimplementedError();
  }
}
