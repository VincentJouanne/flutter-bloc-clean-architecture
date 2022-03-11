import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/features/authentication/common/domain/value-objects/confirmed_password.dart';
import 'package:flutter_clean_architecture/features/authentication/common/domain/value-objects/email.dart';
import 'package:flutter_clean_architecture/features/authentication/common/domain/value-objects/password.dart';
import 'package:flutter_clean_architecture/features/authentication/signup/presenter/signup_cubit.dart';
import 'package:flutter_clean_architecture/features/authentication/signup/presenter/signup_state.dart';
import 'package:flutter_clean_architecture/features/authentication/signup/use_cases/signup_usecase.dart';
import 'package:flutter_clean_architecture/infrastructure/authentication/adapters/exceptions/sign_up_with_email_and_password_exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';

class MockSignUpUseCase extends Mock implements SignUpUseCase {}

void main() {
  late final signUpUseCase = MockSignUpUseCase();
  group('$SignUpCubit', () {
    blocTest<SignUpCubit, SignUpState>(
      'should be in invalid status and prevent from sending form if email is badly formatted',
      build: () => SignUpCubit(signUpUseCase),
      act: (cubit) {
        cubit.emailChanged('foo');
        cubit.signUpFormSubmitted();
      },
      expect: () => [
        const SignUpState(
            email: Email.dirty('foo'),
            password: Password.pure(),
            confirmedPassword: ConfirmedPassword.pure(),
            status: FormzStatus.invalid),
      ],
    );
    blocTest<SignUpCubit, SignUpState>(
      'should be in invalid status and prevent from sending form if password is too simple',
      build: () => SignUpCubit(signUpUseCase),
      act: (cubit) {
        cubit.emailChanged('me@gmail.com');
        cubit.passwordChanged('123');
        cubit.signUpFormSubmitted();
      },
      expect: () => [
        const SignUpState(
            email: Email.dirty('me@gmail.com'),
            password: Password.pure(),
            confirmedPassword: ConfirmedPassword.pure(),
            status: FormzStatus.invalid),
        const SignUpState(
            email: Email.dirty('me@gmail.com'),
            password: Password.dirty('123'),
            confirmedPassword: ConfirmedPassword.dirty(password: ''),
            status: FormzStatus.invalid)
      ],
    );

    blocTest<SignUpCubit, SignUpState>(
      'should be in invalid status and prevent from sending form if password and confirmed password do not match',
      build: () => SignUpCubit(signUpUseCase),
      act: (cubit) {
        cubit.emailChanged('me@gmail.com');
        cubit.passwordChanged('Password123');
        cubit.confirmedPasswordChanged('Password456');
        cubit.signUpFormSubmitted();
      },
      expect: () => [
        const SignUpState(
            email: Email.dirty('me@gmail.com'),
            password: Password.pure(),
            confirmedPassword: ConfirmedPassword.pure(),
            status: FormzStatus.invalid),
        const SignUpState(
            email: Email.dirty('me@gmail.com'),
            password: Password.dirty('Password123'),
            confirmedPassword: ConfirmedPassword.dirty(password: ''),
            status: FormzStatus.invalid),
        const SignUpState(
            email: Email.dirty('me@gmail.com'),
            password: Password.dirty('Password123'),
            confirmedPassword: ConfirmedPassword.dirty(
                password: 'Password123', value: 'Password456'),
            status: FormzStatus.invalid)
      ],
    );

    blocTest<SignUpCubit, SignUpState>(
      'should be in error status with a custom error message if signup failed',
      setUp: () {
        when(() => signUpUseCase.execute(
            params: const SignUpUseCaseParams(
                email: 'me@gmail.com',
                password: 'Password123'))).thenAnswer((_) async => left(
            SignUpWithEmailAndPasswordException.fromCode('invalid-email')));
      },
      build: () => SignUpCubit(signUpUseCase),
      act: (cubit) {
        cubit.emailChanged('me@gmail.com');
        cubit.passwordChanged('Password123');
        cubit.confirmedPasswordChanged('Password123');
        cubit.signUpFormSubmitted();
      },
      expect: () => [
        const SignUpState(
            email: Email.dirty('me@gmail.com'),
            password: Password.pure(),
            confirmedPassword: ConfirmedPassword.pure(),
            status: FormzStatus.invalid),
        const SignUpState(
            email: Email.dirty('me@gmail.com'),
            password: Password.dirty('Password123'),
            confirmedPassword: ConfirmedPassword.dirty(password: ''),
            status: FormzStatus.invalid),
        const SignUpState(
            email: Email.dirty('me@gmail.com'),
            password: Password.dirty('Password123'),
            confirmedPassword: ConfirmedPassword.dirty(
                password: 'Password123', value: 'Password123'),
            status: FormzStatus.valid),
        const SignUpState(
            email: Email.dirty('me@gmail.com'),
            password: Password.dirty('Password123'),
            confirmedPassword: ConfirmedPassword.dirty(
                password: 'Password123', value: 'Password123'),
            status: FormzStatus.submissionInProgress),
        const SignUpState(
            email: Email.dirty('me@gmail.com'),
            password: Password.dirty('Password123'),
            confirmedPassword: ConfirmedPassword.dirty(
                password: 'Password123', value: 'Password123'),
            errorMessage: 'Email is not valid or badly formatted.',
            status: FormzStatus.submissionFailure)
      ],
    );
    blocTest<SignUpCubit, SignUpState>(
      'should be in success status if signup succeed',
      setUp: () {
        when(() => signUpUseCase.execute(
                params: const SignUpUseCaseParams(
                    email: 'me@gmail.com', password: 'Password123')))
            .thenAnswer((_) async => const Right(null));
      },
      build: () => SignUpCubit(signUpUseCase),
      act: (cubit) {
        cubit.emailChanged('me@gmail.com');
        cubit.passwordChanged('Password123');
        cubit.confirmedPasswordChanged('Password123');
        cubit.signUpFormSubmitted();
      },
      expect: () => [
        const SignUpState(
            email: Email.dirty('me@gmail.com'),
            password: Password.pure(),
            confirmedPassword: ConfirmedPassword.pure(),
            status: FormzStatus.invalid),
        const SignUpState(
            email: Email.dirty('me@gmail.com'),
            password: Password.dirty('Password123'),
            confirmedPassword: ConfirmedPassword.dirty(password: ''),
            status: FormzStatus.invalid),
        const SignUpState(
            email: Email.dirty('me@gmail.com'),
            password: Password.dirty('Password123'),
            confirmedPassword: ConfirmedPassword.dirty(
                password: 'Password123', value: 'Password123'),
            status: FormzStatus.valid),
        const SignUpState(
            email: Email.dirty('me@gmail.com'),
            password: Password.dirty('Password123'),
            confirmedPassword: ConfirmedPassword.dirty(
                password: 'Password123', value: 'Password123'),
            status: FormzStatus.submissionInProgress),
        const SignUpState(
            email: Email.dirty('me@gmail.com'),
            password: Password.dirty('Password123'),
            confirmedPassword: ConfirmedPassword.dirty(
                password: 'Password123', value: 'Password123'),
            status: FormzStatus.submissionSuccess)
      ],
    );
  });
}
