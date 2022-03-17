import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_clean_architecture/features/authentication/common/domain/domain.dart';
import 'package:flutter_bloc_clean_architecture/features/authentication/login/bloc/login_cubit.dart';
import 'package:flutter_bloc_clean_architecture/features/authentication/login/use_cases/login_with_email_and_password_usecase.dart';
import 'package:flutter_bloc_clean_architecture/features/authentication/login/use_cases/login_with_google_usecase.dart';
import 'package:flutter_bloc_clean_architecture/infrastructure/authentication/adapters/exceptions/login_with_email_and_password_exception.dart';
import 'package:flutter_bloc_clean_architecture/infrastructure/authentication/adapters/exceptions/login_with_google_exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginWithEmailAndPassword extends Mock
    implements LoginWithEmailAndPasswordUseCase {}

class MockLoginWithGoogleUseCase extends Mock
    implements LoginWithGoogleUseCase {}

const validEmail = 'me@gmail.coom';
const invalidEmail = 'abc';
const validPassword = 'Password123';
const invalidPassword = '123';

void main() {
  final _loginWithEmailAndPasswordUseCase = MockLoginWithEmailAndPassword();
  final _loginWithGoogleUseCase = MockLoginWithGoogleUseCase();

  group('$LoginCubit', () {
    blocTest<LoginCubit, LoginState>(
      'should prevent from login if email is badly formatted',
      build: () => LoginCubit(
        _loginWithEmailAndPasswordUseCase,
        _loginWithGoogleUseCase,
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
        _loginWithEmailAndPasswordUseCase,
        _loginWithGoogleUseCase,
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
        () => _loginWithEmailAndPasswordUseCase.execute(
          params: const LoginWithEmailAndPasswordUseCaseParams(
            email: validEmail,
            password: validPassword,
          ),
        ),
      ).thenAnswer(
        (_) async => left(
          LogInWithEmailAndPasswordException.fromCode('invalid-email'),
        ),
      ),
      build: () => LoginCubit(
        _loginWithEmailAndPasswordUseCase,
        _loginWithGoogleUseCase,
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
        () => _loginWithEmailAndPasswordUseCase.execute(
          params: const LoginWithEmailAndPasswordUseCaseParams(
            email: validEmail,
            password: validPassword,
          ),
        ),
      ).thenAnswer(
        (_) async => left(
          Exception(),
        ),
      ),
      build: () => LoginCubit(
        _loginWithEmailAndPasswordUseCase,
        _loginWithGoogleUseCase,
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
      setUp: () => when(_loginWithGoogleUseCase.execute).thenAnswer(
        (_) async => left(
          LogInWithGoogleException.fromCode(
            'account-exists-with-different-credential',
          ),
        ),
      ),
      build: () => LoginCubit(
        _loginWithEmailAndPasswordUseCase,
        _loginWithGoogleUseCase,
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
      setUp: () => when(_loginWithGoogleUseCase.execute).thenAnswer(
        (_) async => left(
          Exception(),
        ),
      ),
      build: () => LoginCubit(
        _loginWithEmailAndPasswordUseCase,
        _loginWithGoogleUseCase,
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
      setUp: () => when(
        () => _loginWithEmailAndPasswordUseCase.execute(
          params: const LoginWithEmailAndPasswordUseCaseParams(
            email: validEmail,
            password: validPassword,
          ),
        ),
      ).thenAnswer((_) async => const Right(null)),
      build: () => LoginCubit(
        _loginWithEmailAndPasswordUseCase,
        _loginWithGoogleUseCase,
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
      setUp: () => when(_loginWithGoogleUseCase.execute)
          .thenAnswer((_) async => const Right(null)),
      build: () => LoginCubit(
        _loginWithEmailAndPasswordUseCase,
        _loginWithGoogleUseCase,
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
