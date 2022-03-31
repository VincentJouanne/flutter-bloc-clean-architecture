import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/features/app/bloc/app_bloc.dart';
import 'package:flutter_bloc_clean_architecture/features/authentication/login/ui/login_page.dart';
import 'package:flutter_bloc_clean_architecture/features/authentication/signup/ui/signup_page.dart';
import 'package:flutter_bloc_clean_architecture/features/home/ui/home_page.dart';
import 'package:go_router/go_router.dart';

GoRouter router(BuildContext context, String? initialLocation) => GoRouter(
      initialLocation: initialLocation ?? Routes.login,
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
        final loggingIn = state.subloc == Routes.login;
        final signingUp = state.subloc == Routes.signup;

        if (signingUp) {
          return null;
        }

        if (!loggedIn) {
          return loggingIn ? null : Routes.login;
        }
        if (loggingIn) {
          return Routes.home;
        }

        return null;
      },
    );

class Routes {
  static const signup = '/signup';
  static const login = '/login';
  static const home = '/home';
}
