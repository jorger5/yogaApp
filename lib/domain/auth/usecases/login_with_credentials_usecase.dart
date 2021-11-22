import 'package:injectable/injectable.dart';

import 'package:zen_app/core/usecase/usecase.dart';
import 'package:zen_app/data/auth/params/login_with_email_and_password.dart';
import 'package:zen_app/domain/auth/repository/authentication_repository.dart';

@singleton
class LoginWithCredentialsUC
    implements UseCase<void, LoginWithEmailAndPasswordRequestParams> {
  final AuthenticationRepository _authenticationRepository;

  LoginWithCredentialsUC(this._authenticationRepository);

  @override
  Future<void> call({required LoginWithEmailAndPasswordRequestParams params}) {
    return _authenticationRepository.logInWithEmailAndPassword(params);
  }
}
