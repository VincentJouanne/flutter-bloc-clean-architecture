import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_clean_architecture/features/authentication/common/domain/domain.dart';
import 'package:flutter_bloc_clean_architecture/features/authentication/login/use_cases/login_with_email_and_password_usecase.dart';
import 'package:flutter_bloc_clean_architecture/features/authentication/login/use_cases/login_with_google_usecase.dart';
import 'package:flutter_bloc_clean_architecture/infrastructure/authentication/adapters/exceptions/login_with_email_and_password_exception.dart';
import 'package:flutter_bloc_clean_architecture/infrastructure/authentication/adapters/exceptions/login_with_google_exception.dart';
import 'package:formz/formz.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(
    this._loginWithEmailAndPasswordUseCase,
    this._loginWithGoogleUseCase,
  ) : super(const LoginState());

  final LoginWithEmailAndPasswordUseCase _loginWithEmailAndPasswordUseCase;
  final LoginWithGoogleUseCase _loginWithGoogleUseCase;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        status: Formz.validate([email, state.password]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([state.email, password]),
      ),
    );
  }

  Future<void> logInWithCredentials() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    final result = await _loginWithEmailAndPasswordUseCase.execute(
      params: LoginWithEmailAndPasswordUseCaseParams(
        email: state.email.value,
        password: state.password.value,
      ),
    );

    result.fold(
      (l) {
        if (l is LogInWithEmailAndPasswordException) {
          emit(
            state.copyWith(
              errorMessage: l.message,
              status: FormzStatus.submissionFailure,
            ),
          );
        } else {
          emit(state.copyWith(status: FormzStatus.submissionFailure));
        }
      },
      (r) => emit(state.copyWith(status: FormzStatus.submissionSuccess)),
    );
  }

  Future<void> logInWithGoogle() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    final result = await _loginWithGoogleUseCase.execute();

    result.fold(
      (l) {
        if (l is LogInWithGoogleException) {
          emit(
            state.copyWith(
              errorMessage: l.message,
              status: FormzStatus.submissionFailure,
            ),
          );
        } else {
          emit(state.copyWith(status: FormzStatus.submissionFailure));
        }
      },
      (r) => emit(state.copyWith(status: FormzStatus.submissionSuccess)),
    );
  }
}
