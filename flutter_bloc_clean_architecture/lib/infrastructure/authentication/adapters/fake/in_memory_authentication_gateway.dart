// coverage:ignore-file
import 'dart:async';

import 'package:flutter_bloc_clean_architecture/infrastructure/authentication/adapters/models/user.dart';
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
  Future<void> logInWithEmailAndPassword(
      {required String email, required String password}) {
    _controller.add(User.fake);
    isAuthenticated = true;
    return Future.value();
  }

  @override
  Future<void> logInWithGoogle() {
    _controller.add(User.fake);
    isAuthenticated = true;
    return Future.value();
  }

  @override
  Future<void> logOut() {
    _controller.add(User.empty);
    isAuthenticated = false;
    return Future.value();
  }

  @override
  Future<void> signUp({required String email, required String password}) {
    return Future.value();
  }
}
