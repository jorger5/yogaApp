import 'package:zen_app/core/usecase/usecase.dart';
import 'package:zen_app/data/auth/params/register_user_params.dart';

import 'package:zen_app/domain/auth/repository/authentication_repository.dart';

class RegisterUserUseCase implements UseCase<void, RegisterUserRequestParams> {
  final AuthenticationRepository _authenticationRepository;

  RegisterUserUseCase(this._authenticationRepository);

  @override
  Future<void> call({required RegisterUserRequestParams params}) {
    return _authenticationRepository.register(params);
  }
}
