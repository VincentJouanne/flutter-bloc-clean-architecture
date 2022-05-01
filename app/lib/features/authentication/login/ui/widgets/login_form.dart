import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/features/authentication/login/bloc/login_cubit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:theme/theme.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = ThemeResolver.of(context);
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Authentication Failure'),
              ),
            );
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Spacer(),
          const _SocialLoginButtonGroup(),
          SizedBox(height: theme.sizes.m),
          const _CredentialsLoginFormGroup(),
        ],
      ),
    );
  }
}

class _CredentialsLoginFormGroup extends StatelessWidget {
  const _CredentialsLoginFormGroup({Key? key}) : super(key: key);

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
                _EmailInput(),
                _PasswordInput(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: theme.sizes.l),
                  child: AppButton.primary(
                    text: 'Login',
                    elevation: 5,
                    backgroundColor: theme.colors.sunrise,
                  ),
                ),
                _SignUpButton(),
                SizedBox(height: theme.sizes.xl),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _SocialLoginButtonGroup extends StatelessWidget {
  const _SocialLoginButtonGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = ThemeResolver.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: theme.sizes.m),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppButton.secondary(
            text: 'Continue with Google',
            leadingWidget: SvgPicture.asset(
              'assets/google_logo.svg',
              height: theme.sizes.xl,
            ),
            backgroundColor: Colors.white,
          ),
          SizedBox(height: theme.sizes.s),
          AppButton.secondary(
            text: 'Continue with Facebook',
            backgroundColor: Colors.white,
            leadingWidget: SvgPicture.asset(
              'assets/facebook_logo.svg',
              height: theme.sizes.xl,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_emailInput_textField'),
          onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'email',
            helperText: '',
            errorText: state.email.invalid ? 'invalid email' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginCubit>().passwordChanged(password),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'password',
            helperText: '',
            errorText: state.password.invalid ? 'invalid password' : null,
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('loginForm_continue_raisedButton'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  primary: const Color(0xFFFFD600),
                ),
                onPressed: state.status.isValidated
                    ? () => context.read<LoginCubit>().logInWithCredentials()
                    : null,
                child: const Text('LOGIN'),
              );
      },
    );
  }
}

class _GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton.icon(
      key: const Key('loginForm_googleLogin_raisedButton'),
      label: const Text(
        'SIGN IN WITH GOOGLE',
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        primary: theme.colorScheme.secondary,
      ),
      icon: const Icon(FontAwesomeIcons.google, color: Colors.white),
      onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      key: const Key('loginForm_createAccount_flatButton'),
      onPressed: () => context.push('/signup'),
      child: Text(
        'CREATE ACCOUNT',
        style: TextStyle(color: theme.primaryColor),
      ),
    );
  }
}
