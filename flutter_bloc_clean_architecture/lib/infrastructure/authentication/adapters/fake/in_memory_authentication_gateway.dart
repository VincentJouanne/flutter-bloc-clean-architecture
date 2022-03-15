// coverage:ignore-file
import 'dart:async';

import 'package:flutter_bloc_clean_architecture/infrastructure/authentication/adapters/models/user.dart';
import 'package:flutter_bloc_clean_architecture/infrastructure/authentication/port/authentication_gateway.dart';

class InMemoryAuthenticationGateway implements AuthenticationGateway {
  InMemoryAuthenticationGateway({this.isAuthenticated = false});

  bool isAuthenticated;

  final _controller = StreamController<User>.broadcast();

  @override
  User get currentUser => isAuthenticated ? const User(id: 'id1') : User.empty;

  @override
  Stream<User> get user {
    return _controller.stream.asBroadcastStream(onListen: (_) {
      _controller.add(isAuthenticated ? const User(id: 'id1') : User.empty);
    });
  }

  @override
  Future<void> logInWithEmailAndPassword(
      {required String email, required String password}) {
    _controller.add(const User(id: 'id1'));
    isAuthenticated = true;
    return Future.value();
  }

  @override
  Future<void> logInWithGoogle() {
    _controller.add(const User(id: 'id1'));
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
