import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:injectable/injectable.dart';
import 'package:zen_app/config/env/environment_config.dart';

abstract class Api {
  Api(this.client);
  final Dio client;
  void addInterceptors(InterceptorsWrapper interceptor);
}

@Injectable(as: Api, env: [
  EnvironmentConfig.demo,
  EnvironmentConfig.dev,
])
class ApiImpl extends Api {
  final Dio dio;
  final InterceptorsWrapper interceptorsWrapper;
  ApiImpl({
    required this.interceptorsWrapper,
    required this.dio,
  }) : super(dio) {
    addInterceptors(interceptorsWrapper);
  }
  @override
  void addInterceptors(InterceptorsWrapper interceptor) {
    client.interceptors.add(interceptor);
  }
}

@Injectable(as: Dio, env: [
  EnvironmentConfig.demo,
  EnvironmentConfig.dev,
])
class MyDio extends DioForNative {
  BaseOptions? baseOptions;
  MyDio({
    required this.baseOptions,
  }) : super(baseOptions);
}

@Injectable(as: InterceptorsWrapper, env: [EnvironmentConfig.demo])
class DemoInterceptorWrapper extends InterceptorsWrapper {
  DemoInterceptorWrapper() : super();
}

@Injectable(as: InterceptorsWrapper, env: [EnvironmentConfig.dev])
class AppInterceptorWrappers extends InterceptorsWrapper {
  AppInterceptorWrappers()
      : super(
          onRequest: (RequestOptions options,
              RequestInterceptorHandler handler) async {
            //TODO: Handle request here, on login token etc
            return handler.next(options);
          },
          onError: (DioError error, ErrorInterceptorHandler handler) async {
            //TODO: Handle error here.
          },
        );
}
