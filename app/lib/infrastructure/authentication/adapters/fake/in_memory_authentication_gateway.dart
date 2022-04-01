// coverage:ignore-file
import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_clean_architecture/features/authentication/domain/domain.dart';
import 'package:flutter_bloc_clean_architecture/infrastructure/authentication/port/authentication_gateway.dart';

class InMemoryAuthenticationGateway implements AuthenticationGateway {
  InMemoryAuthenticationGateway({this.isAuthenticated = false});

  bool isAuthenticated;

  final _controller = StreamController<User>.broadcast();

  @override
  User get currentUser => isAuthenticated ? User.fake : User.empty;

  @override
  Stream<User> get user {
    return _controller.stream.asBroadcastStream(
      onListen: (_) {
        _controller.add(isAuthenticated ? User.fake : User.empty);
      },
    );
  }

  @override
  Future<Either<LogInWithEmailAndPasswordException, Unit>>
      logInWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    _controller.add(User.fake);
    isAuthenticated = true;
    return Future.value(const Right(unit));
  }

  @override
  Future<Either<LogInWithGoogleException, Unit>> logInWithGoogle() {
    _controller.add(User.fake);
    isAuthenticated = true;
    return Future.value(const Right(unit));
  }

  @override
  Future<Either<LogOutException, Unit>> logOut() {
    _controller.add(User.empty);
    isAuthenticated = false;
    return Future.value(const Right(unit));
  }

  @override
  Future<Either<SignUpWithEmailAndPasswordException, Unit>> signUp({
    required String email,
    required String password,
  }) {
    _controller.add(User.fake);
    isAuthenticated = true;
    return Future.value(const Right(unit));
  }
}
