part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({
    this.email = '',
    this.password = '',
    this.validEmail = false,
    this.hasPassword = false,
    this.isLogged = false,
  });
  final String? email, password;
  final bool validEmail, hasPassword, isLogged;

  @override
  List<dynamic> get props => [email, password];

  LoginState copyWith({
    String? email,
    String? password,
    bool? validEmail,
    bool? hasPassword,
    bool? isLogging,
    bool? isLogged,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      validEmail: validEmail ?? this.validEmail,
      hasPassword: hasPassword ?? this.hasPassword,
      isLogged: isLogged ?? this.isLogged,
    );
  }
}

class LoginLoading extends LoginState {
  const LoginLoading();
  @override
  String toString() => 'Login loading';
}

class LoginSuccess extends LoginState {
  const LoginSuccess();
  @override
  String toString() => 'Login success';
}

class LoginFailed extends LoginState {
  const LoginFailed();
  @override
  String toString() => 'Login failed';
}
