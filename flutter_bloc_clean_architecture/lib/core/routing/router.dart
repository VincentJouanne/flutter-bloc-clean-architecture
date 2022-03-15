import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/core/app/application/app_bloc.dart';
import 'package:flutter_bloc_clean_architecture/features/authentication/login/ui/login_page.dart';
import 'package:flutter_bloc_clean_architecture/features/authentication/signup/ui/signup_page.dart';
import 'package:flutter_bloc_clean_architecture/features/home/ui/home_page.dart';
import 'package:go_router/go_router.dart';

GoRouter router(BuildContext context) => GoRouter(
    initialLocation: Routes.login,
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(context.read<AppBloc>().stream),
    routes: [
      GoRoute(
        path: Routes.signup,
        builder: (context, state) {
          return const SignUpPage();
        },
      ),
      GoRoute(
        path: Routes.login,
        builder: (context, state) {
          return const LoginPage();
        },
      ),
      GoRoute(
        path: Routes.home,
        builder: (context, state) {
          return const HomePage();
        },
      ),
    ],
    redirect: (state) {
      final loggedIn = context.read<AppBloc>().state.isAuthenticated;
      final loggingIn = state.subloc == '/login';
      final signingUp = state.subloc == '/signup';

      if (signingUp) {
        return '/signup';
      } else if (!loggedIn) {
        return loggingIn ? null : '/login';
      } else if (loggingIn) {
        return '/home';
      } else {
        return null;
      }
    });

class Routes extends Equatable {
  static const signup = '/signup';
  static const login = '/login';
  static const home = '/home';

  @override
  List<Object?> get props => [signup, login, home];
}
