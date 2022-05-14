import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/features/authentication/login/bloc/login_cubit.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:theme/theme.dart';

class CredentialsLoginFormGroup extends StatelessWidget {
  const CredentialsLoginFormGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = ThemeResolver.of(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(theme.sizes.l),
          topRight: Radius.circular(theme.sizes.l),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: theme.sizes.m),
            child: AppText.p3('Login with email'),
          ),
          Container(
            width: double.infinity,
            color: theme.colors.skin,
            height: 1,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: theme.sizes.l),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: theme.sizes.m),
                const _EmailInput(),
                SizedBox(height: theme.sizes.s),
                const _PasswordInput(),
                const _LoginButton(),
                const _ForgotPasswordText(),
                SizedBox(height: theme.sizes.s),
                const _SignupText(),
                SizedBox(height: theme.sizes.xl + theme.sizes.m),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return AppInput.primary(
          key: const Key('loginForm_emailInput_textField'),
          icon: Icons.email_outlined,
          hintText: 'Email',
          errorText: state.email.invalid ? 'invalid email' : null,
          onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}

class _PasswordInput extends StatefulWidget {
  const _PasswordInput({
    Key? key,
  }) : super(key: key);

  @override
  State<_PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<_PasswordInput> {
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return AppInput.primary(
          key: const Key('loginForm_passwordInput_textField'),
          icon: Icons.lock_outline,
          hintText: 'Password',
          obscureText: _obscureText,
          showHiddenInput: _toggle,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.next,
          onChanged: (password) =>
              context.read<LoginCubit>().passwordChanged(password),
          errorText: state.password.invalid ? 'invalid password' : null,
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = ThemeResolver.of(context);
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: theme.sizes.l),
          child: AppButton.primary(
            key: const Key('loginForm_continue_raisedButton'),
            text: 'Login',
            elevation: 5,
            isLoading: state.status.isSubmissionInProgress,
            backgroundColor: theme.colors.sunrise,
            onPressed: state.status.isValidated
                ? () => context.read<LoginCubit>().logInWithCredentials()
                : () {},
          ),
        );
      },
    );
  }
}

class _ForgotPasswordText extends StatelessWidget {
  const _ForgotPasswordText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppText.p3(
      'Forgot Password?',
      textDecoration: TextDecoration.underline,
    );
  }
}

class _SignupText extends StatelessWidget {
  const _SignupText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: const Key('loginForm_createAccount_flatButton'),
      onTap: () => context.push('/signup'),
      child: RichText(
        text: TextSpan(
          text: "Don't have an account?",
          style: AppText.styleOf(context, StyleEnum.p3),
          children: [
            const TextSpan(text: '  '),
            TextSpan(
              text: 'Signup',
              style: AppText.styleOf(context, StyleEnum.p2),
            )
          ],
        ),
      ),
    );
  }
}
