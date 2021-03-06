import 'package:injectable/injectable.dart';
import 'package:zen_app/core/usecase/usecase.dart';

import 'package:zen_app/domain/auth/repository/authentication_repository.dart';

@singleton
class LogOutUC implements UseCase<void, NoParams> {
  final AuthenticationRepository _authenticationRepository;

  LogOutUC(this._authenticationRepository);

  @override
  Future<void> call({required NoParams params}) {
    return _authenticationRepository.logOut(params);
  }
}
