import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:zen_app/core/usecase/usecase.dart';
import 'package:zen_app/data/auth/repositories/authentication_repository_impl.dart';
import 'package:zen_app/domain/auth/usecases/auth_usecase_index.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
    AuthenticationRepositoryImpl authenticationRepository,
  )   : _authenticationRepository = authenticationRepository,
        super(authenticationRepository.getUser() == null
            ? const Unauthenticated()
            : Authenticated(authenticationRepository.getUser()!));

  final AuthenticationRepositoryImpl _authenticationRepository;

  Future<void> userLoggedIn() async {
    try {
      final User? user = _authenticationRepository.getUser()!;
      if (user != null) {
        print('Is signed in');
        emit(Authenticated(user));
      } else {
        print('unauthenticated');
        emit(const Unauthenticated());
      }
    } catch (_) {
      emit(const Unauthenticated());
    }
  }

  Future<void> userLogOut() async {
    final logOutUseCase = GetIt.I<LogOutUC>();
    await logOutUseCase(params: NoParams());
    if (_authenticationRepository.getUser() == null) {
      emit(const Unauthenticated());
    }
  }
}
