import 'package:injectable/injectable.dart';
import 'package:zen_app/core/usecase/usecase.dart';
import 'package:zen_app/data/auth/repositories/authentication_repository_impl.dart';
import 'package:zen_app/domain/auth/repository/authentication_repository.dart';

@singleton
class LogInWithGoogleUseCase implements UseCase<void, NoParams> {
  final AuthenticationRepository _authenticationRepository;

  LogInWithGoogleUseCase(this._authenticationRepository);

  @override
  Future<void> call({required NoParams params}) {
    return _authenticationRepository.logInWithGoogle(params);
  }
}
