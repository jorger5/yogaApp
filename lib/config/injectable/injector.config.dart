// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../application/auth/login_cubits/login_cubit.dart' as _i7;
import '../../application/ui/ui_cubit.dart' as _i10;
import '../../data/auth/repositories/authentication_repository_impl.dart'
    as _i4;
import '../../domain/auth/repository/authentication_repository.dart' as _i3;
import '../../domain/auth/usecases/login_with_apple_usecase.dart' as _i8;
import '../../domain/auth/usecases/login_with_credentials_usecase.dart' as _i9;
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
  gh.singleton<_i5.LogInWithGoogleUC>(
      _i5.LogInWithGoogleUC(get<_i3.AuthenticationRepository>()));
  gh.singleton<_i6.LogOutUC>(_i6.LogOutUC(get<_i3.AuthenticationRepository>()));
  gh.singleton<_i7.LoginCubit>(_i7.LoginCubit());
  gh.singleton<_i8.LoginWithAppleUC>(
      _i8.LoginWithAppleUC(get<_i3.AuthenticationRepository>()));
  gh.singleton<_i9.LoginWithCredentialsUC>(
      _i9.LoginWithCredentialsUC(get<_i3.AuthenticationRepository>()));
  gh.singleton<_i10.UiCubit>(_i10.UiCubit());
  return get;
}
