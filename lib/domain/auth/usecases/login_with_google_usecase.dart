import 'package:injectable/injectable.dart';

import 'package:zen_app/core/usecase/usecase.dart';
import 'package:zen_app/domain/auth/repository/authentication_repository.dart';

@singleton
class LogInWithGoogleUC implements UseCase<void, NoParams> {
  final AuthenticationRepository _authenticationRepository;

  LogInWithGoogleUC(this._authenticationRepository);

  @override
  Future<void> call({required NoParams params}) {
    return _authenticationRepository.logInWithGoogle(params);
  }
}
