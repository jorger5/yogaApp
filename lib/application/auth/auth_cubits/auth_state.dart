part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthState {
  const AppStarted();
  @override
  String toString() => 'App started';
}

class Authenticated extends AuthState {
  const Authenticated(this._user) : super();

  final User _user;

  User get user => _user;

  @override
  String toString() => 'Authenticated { user: $user }';
}

class Unauthenticated extends AuthState {
  const Unauthenticated();
  @override
  String toString() => 'User not logged in';
}
