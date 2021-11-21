// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/auth/repositories/authentication_repository_impl.dart'
    as _i4;
import '../../domain/auth/repository/authentication_repository.dart' as _i3;
import '../../domain/auth/usecases/login_with_google_usecase.dart' as _i5;
import '../../domain/auth/usecases/logout_usecase.dart'
    as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.AuthenticationRepository>(
      () => _i4.AuthenticationRepositoryImpl());
  gh.singleton<_i5.LogInWithGoogleUseCase>(
      _i5.LogInWithGoogleUseCase(get<_i3.AuthenticationRepository>()));
  gh.singleton<_i6.LogOutUseCase>(
      _i6.LogOutUseCase(get<_i3.AuthenticationRepository>()));
  return get;
}
