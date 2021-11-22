import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:zen_app/core/usecase/usecase.dart';
import 'package:zen_app/core/utils/validators.dart';
import 'package:zen_app/data/auth/params/login_with_email_and_password.dart';
import 'package:zen_app/domain/auth/usecases/auth_usecase_index.dart';

part 'login_state.dart';

@singleton
class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  void emailChanged(String value) {
    final String newEmail = value;
    if (Validators.isValidEmail(newEmail)) {
      emit(state.copyWith(
        email: newEmail,
        validEmail: true,
      ));
    } else {
      emit(state.copyWith(hasPassword: false));
    }
  }

  void passwordChanged(String value) {
    final String newPassword = value;
    emit(state.copyWith(
      password: newPassword,
      hasPassword: true,
    ));
  }

  Future<void> logInWithCredentials() async {
    final loginWithCredentialsUC = GetIt.I<LoginWithCredentialsUC>();

    if (state.validEmail == false || state.hasPassword == false) {
      return;
    }
    final String email = state.email ?? '';
    final String password = state.password ?? '';
    try {
      emit(const LoginLoading());
      await loginWithCredentialsUC(
          params: LoginWithEmailAndPasswordRequestParams(
              email: email, password: password));

      emit(const LoginSuccess());
    } on Exception {
      emit(const LoginFailed());
    }
  }

  Future<void> logInWithGoogle() async {
    final logInWithGoogleUC = GetIt.I<LogInWithGoogleUC>();

    try {
      await logInWithGoogleUC(params: NoParams());
      emit(const LoginSuccess());
    } catch (_) {
      emit(const LoginFailed());
    }
  }

  Future<void> logInWithApple() async {
    final loginWithAppleUC = GetIt.I<LoginWithAppleUC>();

    try {
      await loginWithAppleUC(params: NoParams());
      emit(const LoginSuccess());
    } catch (_) {
      emit(const LoginFailed());
    }
  }
}
