import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc_clean_architecture/features/authentication/domain/entities/user.dart';
import 'package:flutter_bloc_clean_architecture/infrastructure/authentication/port/authentication_gateway.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc(AuthenticationGateway authenticationGateway)
      : _authenticationGateway = authenticationGateway,
        super(
          authenticationGateway.currentUser.isNotEmpty
              ? AppState.authenticated(authenticationGateway.currentUser)
              : const AppState.unauthenticated(),
        ) {
    on<AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
    _userSubscription = _authenticationGateway.user.listen(
      (user) => add(AppUserChanged(user)),
    );
  }

  final AuthenticationGateway _authenticationGateway;
  late final StreamSubscription<User> _userSubscription;

  void _onUserChanged(AppUserChanged event, Emitter<AppState> emit) {
    emit(
      event.user.isNotEmpty
          ? AppState.authenticated(event.user)
          : const AppState.unauthenticated(),
    );
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    unawaited(_authenticationGateway.logOut());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
