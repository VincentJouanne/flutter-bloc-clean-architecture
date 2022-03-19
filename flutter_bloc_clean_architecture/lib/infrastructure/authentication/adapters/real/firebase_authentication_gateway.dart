// coverage:ignore-file
import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_bloc_clean_architecture/features/authentication/domain/domain.dart';
import 'package:flutter_bloc_clean_architecture/infrastructure/authentication/port/authentication_gateway.dart';
import 'package:flutter_bloc_clean_architecture/infrastructure/cache/cache.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

class FirebaseAuthenticationGateway implements AuthenticationGateway {
  FirebaseAuthenticationGateway({
    CacheClient? cache,
    firebase_auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _cache = cache ?? CacheClient(),
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  final CacheClient _cache;
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  @visibleForTesting
  bool isWeb = kIsWeb;

  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';

  @override
  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      _cache.write(key: userCacheKey, value: user);
      return user;
    });
  }

  @override
  User get currentUser {
    return _cache.read<User>(key: userCacheKey) ?? User.empty;
  }

  @override
  Future<Either<SignUpWithEmailAndPasswordException, Unit>> signUp({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      return Left(SignUpWithEmailAndPasswordException.fromCode(e.code));
    } catch (_) {
      return const Left(SignUpWithEmailAndPasswordException());
    }
    return const Right(unit);
  }

  @override
  Future<Either<LogInWithGoogleException, Unit>> logInWithGoogle() async {
    try {
      late final firebase_auth.AuthCredential credential;
      if (isWeb) {
        final googleProvider = firebase_auth.GoogleAuthProvider();
        final userCredential = await _firebaseAuth.signInWithPopup(
          googleProvider,
        );
        credential = userCredential.credential!;
      } else {
        final googleUser = await _googleSignIn.signIn();
        final googleAuth = await googleUser!.authentication;
        credential = firebase_auth.GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
      }

      await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      return Left(LogInWithGoogleException.fromCode(e.code));
    } catch (_) {
      return const Left(LogInWithGoogleException());
    }
    return const Right(unit);
  }

  @override
  Future<Either<LogInWithEmailAndPasswordException, Unit>>
      logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      return Left(LogInWithEmailAndPasswordException.fromCode(e.code));
    } catch (_) {
      return const Left(LogInWithEmailAndPasswordException());
    }
    return const Right(unit);
  }

  @override
  Future<Either<LogOutException, Unit>> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (_) {
      return Left(LogOutException());
    }
    return const Right(unit);
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(id: uid, email: email, name: displayName, photo: photoURL);
  }
}
