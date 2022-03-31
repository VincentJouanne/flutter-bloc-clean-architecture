import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_clean_architecture/features/authentication/domain/domain.dart';
import 'package:flutter_bloc_clean_architecture/features/authentication/signup/bloc/signup_state.dart';
import 'package:flutter_bloc_clean_architecture/infrastructure/authentication/port/authentication_gateway.dart';
import 'package:formz/formz.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._authenticationGateway) : super(const SignUpState());

  final AuthenticationGateway _authenticationGateway;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        status: Formz.validate([
          email,
          state.password,
          state.confirmedPassword,
        ]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    final confirmedPassword = ConfirmedPassword.dirty(
      password: password.value,
      value: state.confirmedPassword.value,
    );
    emit(
      state.copyWith(
        password: password,
        confirmedPassword: confirmedPassword,
        status: Formz.validate([
          state.email,
          password,
          confirmedPassword,
        ]),
      ),
    );
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: value,
    );
    emit(
      state.copyWith(
        confirmedPassword: confirmedPassword,
        status: Formz.validate([
          state.email,
          state.password,
          confirmedPassword,
        ]),
      ),
    );
  }

  Future<void> signUpFormSubmitted() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    final result = await _authenticationGateway.signUp(
      email: state.email.value,
      password: state.password.value,
    );

    result.fold(
      (l) {
        emit(
          state.copyWith(
            errorMessage: l.message,
            status: FormzStatus.submissionFailure,
          ),
        );
      },
      (r) => emit(state.copyWith(status: FormzStatus.submissionSuccess)),
    );
  }
}
