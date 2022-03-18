// coverage:ignore-file
import 'dart:async';

import 'package:flutter_bloc_clean_architecture/features/authentication/common/domain/entities/user.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

abstract class AuthenticationGateway {
  Stream<User> get user;
  User get currentUser;
  Future<void> signUp({
    required String email,
    required String password,
  }) async {}
  Future<void> logInWithGoogle() async {}
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {}
  Future<void> logOut() async {}
}
