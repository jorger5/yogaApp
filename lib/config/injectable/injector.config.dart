// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../application/auth/login_cubits/login_cubit.dart' as _i10;
import '../../application/ui/ui_cubit.dart' as _i13;
import '../../core/api/api.dart' as _i7;
import '../../core/api/api_configuration.dart' as _i6;
import '../../data/auth/repositories/authentication_repository_impl.dart'
    as _i4;
import '../../domain/auth/repository/authentication_repository.dart' as _i3;
import '../../domain/auth/usecases/login_with_apple_usecase.dart' as _i11;
import '../../domain/auth/usecases/login_with_credentials_usecase.dart' as _i12;
import '../../domain/auth/usecases/login_with_google_usecase.dart' as _i8;
import '../../domain/auth/usecases/logout_usecase.dart' as _i9;

const String _demo = 'demo';
const String _dev = 'dev';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.AuthenticationRepository>(
      () => _i4.AuthenticationRepositoryImpl());
  gh.factory<_i5.BaseOptions>(() => _i6.DemoBaseOptions(),
      registerFor: {_demo});
  gh.factory<_i5.BaseOptions>(() => _i6.DevBaseOptions(), registerFor: {_dev});
  gh.factory<_i5.Dio>(() => _i7.MyDio(baseOptions: get<_i5.BaseOptions>()),
      registerFor: {_demo, _dev});
  gh.factory<_i5.InterceptorsWrapper>(() => _i7.DemoInterceptorWrapper(),
      registerFor: {_demo});
  gh.factory<_i5.InterceptorsWrapper>(() => _i7.AppInterceptorWrappers(),
      registerFor: {_dev});
  gh.singleton<_i8.LogInWithGoogleUC>(
      _i8.LogInWithGoogleUC(get<_i3.AuthenticationRepository>()));
  gh.singleton<_i9.LogOutUC>(_i9.LogOutUC(get<_i3.AuthenticationRepository>()));
  gh.singleton<_i10.LoginCubit>(_i10.LoginCubit());
  gh.singleton<_i11.LoginWithAppleUC>(
      _i11.LoginWithAppleUC(get<_i3.AuthenticationRepository>()));
  gh.singleton<_i12.LoginWithCredentialsUC>(
      _i12.LoginWithCredentialsUC(get<_i3.AuthenticationRepository>()));
  gh.singleton<_i13.UiCubit>(_i13.UiCubit());
  gh.factory<_i7.Api>(
      () => _i7.ApiImpl(
          interceptorsWrapper: get<_i5.InterceptorsWrapper>(),
          dio: get<_i5.Dio>()),
      registerFor: {_demo, _dev});
  return get;
}
