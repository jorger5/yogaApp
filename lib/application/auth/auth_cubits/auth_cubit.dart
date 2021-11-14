import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zen_app/infrastructure/auth/repositories/authentication_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
    AuthenticationRepository authenticationRepository,
  )   : _authenticationRepository = authenticationRepository,
        super(authenticationRepository.getUser() == null
            ? Unauthenticated()
            : Authenticated(authenticationRepository.getUser()!));

  final AuthenticationRepository _authenticationRepository;

  Future<void> userLoggedIn() async {
    try {
      final isSignedIn = _authenticationRepository.isSignedIn();
      if (isSignedIn) {
        print('Is signed in');
        final User user = _authenticationRepository.getUser()!;
        emit(Authenticated(user));
      } else {
        print('unauthenticated');
        emit(Unauthenticated());
      }
    } catch (_) {
      emit(Unauthenticated());
    }
  }

  Future<void> userLogOut() async {
    await _authenticationRepository.logOut();
    if (_authenticationRepository.getUser() == null) {
      emit(Unauthenticated());
    }
  }
}
