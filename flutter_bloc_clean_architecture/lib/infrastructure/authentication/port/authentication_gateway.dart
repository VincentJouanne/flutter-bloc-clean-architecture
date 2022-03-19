// coverage:ignore-file
import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_clean_architecture/features/authentication/domain/domain.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

abstract class AuthenticationGateway {
  Stream<User> get user;
  User get currentUser;
  Future<Either<SignUpWithEmailAndPasswordException, void>> signUp({
    required String email,
    required String password,
  }) async {
    throw UnimplementedError();
  }

  Future<Either<LogInWithGoogleException, void>> logInWithGoogle() async {
    throw UnimplementedError();
  }

  Future<Either<LogInWithEmailAndPasswordException, void>>
      logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    throw UnimplementedError();
  }

  Future<Either<LogOutException, void>> logOut() async {
    throw UnimplementedError();
  }
}
