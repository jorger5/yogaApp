import 'package:injectable/injectable.dart';

import 'package:zen_app/core/usecase/usecase.dart';
import 'package:zen_app/domain/auth/repository/authentication_repository.dart';

@singleton
class LoginWithAppleUC implements UseCase<void, NoParams> {
  final AuthenticationRepository _authenticationRepository;

  LoginWithAppleUC(this._authenticationRepository);

  @override
  Future<void> call({required NoParams params}) {
    return _authenticationRepository.logInWithApple(params);
  }
}
