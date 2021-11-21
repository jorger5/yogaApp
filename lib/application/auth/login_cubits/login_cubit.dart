import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import 'package:zen_app/core/usecase/usecase.dart';
import 'package:zen_app/core/utils/validators.dart';
import 'package:zen_app/data/auth/params/login_with_email_and_password.dart';
import 'package:zen_app/data/auth/repositories/authentication_repository_impl.dart';
import 'package:zen_app/domain/auth/usecases/login_with_google_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepository) : super(const LoginState());

  final AuthenticationRepositoryImpl _authenticationRepository;

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
    if (state.validEmail == false || state.hasPassword == false) {
      return;
    }
    final String? email = state.email ?? '';
    final String? password = state.password ?? '';
    try {
      emit(const LoginLoading());
      await _authenticationRepository
          .logInWithEmailAndPassword(LoginWithEmailAndPasswordRequestParams(
        email: email!,
        password: password!,
      ));
      emit(const LoginSuccess());
    } on Exception {
      emit(const LoginFailed());
    }
  }

  Future<void> logInWithGoogle() async {
    final logInWithGoogleUseCase = GetIt.I<LogInWithGoogleUseCase>();

    try {
      await logInWithGoogleUseCase(params: NoParams());
      emit(const LoginSuccess());
    } catch (_) {
      emit(const LoginFailed());
    }
  }

  Future<void> logInWithApple() async {
    try {
      await _authenticationRepository.logInWithApple(NoParams());
      emit(const LoginSuccess());
    } catch (_) {
      emit(const LoginFailed());
    }
  }
}
