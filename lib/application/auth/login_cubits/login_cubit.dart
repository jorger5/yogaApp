import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zen_app/core/utils/validators.dart';
import 'package:zen_app/infrastructure/auth/repositories/authentication_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepository) : super(const LoginState());

  final AuthenticationRepository _authenticationRepository;

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
      emit(LoginLoading());
      await _authenticationRepository.logInWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      emit(LoginSuccess());
    } on Exception {
      emit(LoginFailed());
    }
  }

  Future<void> logInWithGoogle() async {
    try {
      await _authenticationRepository.logInWithGoogle();
      emit(LoginSuccess());
    } catch (_) {
      emit(LoginFailed());
    }
  }

  Future<void> logInWithApple() async {
    try {
      await _authenticationRepository.logInWithApple();
      emit(LoginSuccess());
    } catch (_) {
      emit(LoginFailed());
    }
  }
}
