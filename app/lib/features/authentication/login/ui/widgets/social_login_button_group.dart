import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/features/authentication/login/bloc/login_cubit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme/theme.dart';

class SocialLoginButtonGroup extends StatelessWidget {
  const SocialLoginButtonGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = ThemeResolver.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: theme.sizes.m),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppButton.secondary(
            key: const Key('loginForm_googleLogin_raisedButton'),
            text: 'Continue with Google',
            leadingWidget: SvgPicture.asset(
              'assets/google_logo.svg',
              height: theme.sizes.xl,
            ),
            backgroundColor: Colors.white,
            onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
          ),
          SizedBox(height: theme.sizes.s),
          AppButton.secondary(
            text: 'Continue with Facebook',
            backgroundColor: Colors.white,
            leadingWidget: SvgPicture.asset(
              'assets/facebook_logo.svg',
              height: theme.sizes.xl,
            ),
            // TODO(vincent): handle login with Facebook instead of Google
            onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
          ),
        ],
      ),
    );
  }
}
