import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/dependency_container.dart';
import 'package:flutter_clean_architecture/features/authentication/login/presenter/login_cubit.dart';
import 'package:flutter_clean_architecture/features/authentication/login/ui/widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: LoginPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocProvider(
          create: (_) => getIt<LoginCubit>(),
          child: const LoginForm(),
        ),
      ),
    );
  }
}
