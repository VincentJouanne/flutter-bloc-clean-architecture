import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/dependency_container.dart';
import 'package:flutter_clean_architecture/features/authentication/signup/presenter/signup_cubit.dart';
import 'package:flutter_clean_architecture/features/authentication/signup/ui/widgets/signup_form.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SignUpPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocProvider<SignUpCubit>(
          create: (_) => getIt<SignUpCubit>(),
          child: const SignUpForm(),
        ),
      ),
    );
  }
}
