// coverage:ignore-file
import 'package:flutter_clean_architecture/infrastructure/authentication/adapters/models/user.dart';
import 'package:flutter_clean_architecture/infrastructure/authentication/port/authentication_gateway.dart';

class InMemoryAuthenticationGateway implements AuthenticationGateway {
  @override
  User get currentUser => const User(id: 'id1');

  @override
  Future<void> logInWithEmailAndPassword(
      {required String email, required String password}) {
    return Future.value();
  }

  @override
  Future<void> logInWithGoogle() {
    return Future.value();
  }

  @override
  Future<void> logOut() {
    return Future.value();
  }

  @override
  Future<void> signUp({required String email, required String password}) {
    return Future.value();
  }

  @override
  Stream<User> get user => Stream.value(const User(id: 'id1'));
}
