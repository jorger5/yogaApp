import 'package:injectable/injectable.dart';
import 'package:zen_app/core/usecase/usecase.dart';
import 'package:zen_app/data/auth/params/register_user_params.dart';
import 'package:zen_app/data/auth/repositories/authentication_repository_impl.dart';
import 'package:zen_app/domain/auth/repository/authentication_repository.dart';

@singleton
class LogOutUseCase implements UseCase<void, NoParams> {
  final AuthenticationRepository _authenticationRepository;

  LogOutUseCase(this._authenticationRepository);

  @override
  Future<void> call({required NoParams params}) {
    return _authenticationRepository.logOut(params);
  }
}
