import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/dependency_container.dart';
import 'package:flutter_bloc_clean_architecture/features/authentication/login/bloc/login_cubit.dart';
import 'package:flutter_bloc_clean_architecture/features/authentication/login/ui/widgets/login_form.dart';
import 'package:theme/theme.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _TranslatedBackground(),
          const _FadedLayer(),
          BlocProvider(
            create: (_) => getIt<LoginCubit>(),
            child: const LoginForm(),
          )
        ],
      ),
    );
  }
}

class _FadedLayer extends StatelessWidget {
  const _FadedLayer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = ThemeResolver.of(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            theme.colors.skin,
            Colors.white.withOpacity(0),
          ],
          stops: const [
            0.65,
            0.8,
          ],
        ),
      ),
    );
  }
}

class _TranslatedBackground extends StatelessWidget {
  const _TranslatedBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -220),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/splash_screen.png'),
          ),
        ),
      ),
    );
  }
}
