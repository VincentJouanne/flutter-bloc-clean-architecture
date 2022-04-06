import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_clean_architecture/features/authentication/domain/domain.dart';
import 'package:flutter_bloc_clean_architecture/features/authentication/login/bloc/login_cubit.dart';
import 'package:flutter_bloc_clean_architecture/infrastructure/authentication/adapters/fake/in_memory_authentication_gateway.dart';
import 'package:flutter_bloc_clean_architecture/infrastructure/authentication/adapters/fake/mock_authentication_gateway.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';

const validEmail = 'me@gmail.coom';
const invalidEmail = 'abc';
const validPassword = 'Password123';
const invalidPassword = '123';

void main() {
  final _mockAuthenticationGateway = MockAuthenticationGateway();
  final _inMemoryAuthenticationGateway = InMemoryAuthenticationGateway();

  group('$LoginCubit', () {
    blocTest<LoginCubit, LoginState>(
      'should prevent from login if email is badly formatted',
      build: () => LoginCubit(
        _mockAuthenticationGateway,
      ),
      act: (cubit) {
        cubit
          ..emailChanged(invalidEmail)
          ..logInWithCredentials();
      },
      expect: () => [
        const LoginState(
          email: Email.dirty(invalidEmail),
          status: FormzStatus.invalid,
        )
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'should prevent from login if password is badly formatted',
      build: () => LoginCubit(
        _mockAuthenticationGateway,
      ),
      act: (cubit) {
        cubit
          ..emailChanged(validEmail)
          ..passwordChanged(invalidPassword)
          ..logInWithCredentials();
      },
      expect: () => [
        const LoginState(
          email: Email.dirty(validEmail),
          status: FormzStatus.invalid,
        ),
        const LoginState(
          email: Email.dirty(validEmail),
          password: Password.dirty(invalidPassword),
          status: FormzStatus.invalid,
        )
      ],
    );

    blocTest<LoginCubit, LoginState>(
      '''should expose an error message if login with email and password fails with specific exception''',
      setUp: () => when(
        () => _mockAuthenticationGateway.logInWithEmailAndPassword(
          email: validEmail,
          password: validPassword,
        ),
      ).thenAnswer(
        (_) async => left(
          LogInWithEmailAndPasswordException.fromCode('invalid-email'),
        ),
      ),
      build: () => LoginCubit(
        _mockAuthenticationGateway,
      ),
      act: (cubit) {
        cubit
          ..emailChanged(validEmail)
          ..passwordChanged(validPassword)
          ..logInWithCredentials();
      },
      expect: () => [
        const LoginState(
          email: Email.dirty(validEmail),
          status: FormzStatus.invalid,
        ),
        const LoginState(
          email: Email.dirty(validEmail),
          password: Password.dirty(validPassword),
          status: FormzStatus.valid,
        ),
        const LoginState(
          email: Email.dirty(validEmail),
          password: Password.dirty(validPassword),
          status: FormzStatus.submissionInProgress,
        ),
        const LoginState(
          email: Email.dirty(validEmail),
          password: Password.dirty(validPassword),
          status: FormzStatus.submissionFailure,
        )
      ],
    );

    blocTest<LoginCubit, LoginState>(
      '''should expose an error message if login with email and password fails with random exception''',
      setUp: () => when(
        () => _mockAuthenticationGateway.logInWithEmailAndPassword(
          email: validEmail,
          password: validPassword,
        ),
      ).thenAnswer(
        (_) async => left(
          const LogInWithEmailAndPasswordException(),
        ),
      ),
      build: () => LoginCubit(
        _mockAuthenticationGateway,
      ),
      act: (cubit) {
        cubit
          ..emailChanged(validEmail)
          ..passwordChanged(validPassword)
          ..logInWithCredentials();
      },
      expect: () => [
        const LoginState(
          email: Email.dirty(validEmail),
          status: FormzStatus.invalid,
        ),
        const LoginState(
          email: Email.dirty(validEmail),
          password: Password.dirty(validPassword),
          status: FormzStatus.valid,
        ),
        const LoginState(
          email: Email.dirty(validEmail),
          password: Password.dirty(validPassword),
          status: FormzStatus.submissionInProgress,
        ),
        const LoginState(
          email: Email.dirty(validEmail),
          password: Password.dirty(validPassword),
          status: FormzStatus.submissionFailure,
        )
      ],
    );

    blocTest<LoginCubit, LoginState>(
      '''should expose an error message if login with google fails with specific exception''',
      setUp: () => when(_mockAuthenticationGateway.logInWithGoogle).thenAnswer(
        (_) async => left(
          LogInWithGoogleException.fromCode(
            'account-exists-with-different-credential',
          ),
        ),
      ),
      build: () => LoginCubit(
        _mockAuthenticationGateway,
      ),
      act: (cubit) {
        cubit
          ..emailChanged(validEmail)
          ..passwordChanged(validPassword)
          ..logInWithGoogle();
      },
      expect: () => [
        const LoginState(
          email: Email.dirty(validEmail),
          status: FormzStatus.invalid,
        ),
        const LoginState(
          email: Email.dirty(validEmail),
          password: Password.dirty(validPassword),
          status: FormzStatus.valid,
        ),
        const LoginState(
          email: Email.dirty(validEmail),
          password: Password.dirty(validPassword),
          status: FormzStatus.submissionInProgress,
        ),
        const LoginState(
          email: Email.dirty(validEmail),
          password: Password.dirty(validPassword),
          status: FormzStatus.submissionFailure,
        )
      ],
    );

    blocTest<LoginCubit, LoginState>(
      '''should expose an error message if login with google fails with random exception''',
      setUp: () => when(_mockAuthenticationGateway.logInWithGoogle).thenAnswer(
        (_) async => left(
          const LogInWithGoogleException(),
        ),
      ),
      build: () => LoginCubit(
        _mockAuthenticationGateway,
      ),
      act: (cubit) {
        cubit
          ..emailChanged(validEmail)
          ..passwordChanged(validPassword)
          ..logInWithGoogle();
      },
      expect: () => [
        const LoginState(
          email: Email.dirty(validEmail),
          status: FormzStatus.invalid,
        ),
        const LoginState(
          email: Email.dirty(validEmail),
          password: Password.dirty(validPassword),
          status: FormzStatus.valid,
        ),
        const LoginState(
          email: Email.dirty(validEmail),
          password: Password.dirty(validPassword),
          status: FormzStatus.submissionInProgress,
        ),
        const LoginState(
          email: Email.dirty(validEmail),
          password: Password.dirty(validPassword),
          status: FormzStatus.submissionFailure,
        )
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'should succeed if login with email and password succeed',
      build: () => LoginCubit(
        _inMemoryAuthenticationGateway,
      ),
      act: (cubit) {
        cubit
          ..emailChanged(validEmail)
          ..passwordChanged(validPassword)
          ..logInWithCredentials();
      },
      expect: () => [
        const LoginState(
          email: Email.dirty(validEmail),
          status: FormzStatus.invalid,
        ),
        const LoginState(
          email: Email.dirty(validEmail),
          password: Password.dirty(validPassword),
          status: FormzStatus.valid,
        ),
        const LoginState(
          email: Email.dirty(validEmail),
          password: Password.dirty(validPassword),
          status: FormzStatus.submissionInProgress,
        ),
        const LoginState(
          email: Email.dirty(validEmail),
          password: Password.dirty(validPassword),
          status: FormzStatus.submissionSuccess,
        )
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'should succeed if login with google succeed',
      build: () => LoginCubit(
        _inMemoryAuthenticationGateway,
      ),
      act: (cubit) {
        cubit
          ..emailChanged(validEmail)
          ..passwordChanged(validPassword)
          ..logInWithGoogle();
      },
      expect: () => [
        const LoginState(
          email: Email.dirty(validEmail),
          status: FormzStatus.invalid,
        ),
        const LoginState(
          email: Email.dirty(validEmail),
          password: Password.dirty(validPassword),
          status: FormzStatus.valid,
        ),
        const LoginState(
          email: Email.dirty(validEmail),
          password: Password.dirty(validPassword),
          status: FormzStatus.submissionInProgress,
        ),
        const LoginState(
          email: Email.dirty(validEmail),
          password: Password.dirty(validPassword),
          status: FormzStatus.submissionSuccess,
        )
      ],
    );
  });
}
