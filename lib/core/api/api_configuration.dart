import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:zen_app/config/env/environment_config.dart';
import 'package:zen_app/config/injectable/injector.dart';

@Injectable(as: BaseOptions, env: [EnvironmentConfig.demo])
class DemoBaseOptions extends BaseOptions {
  DemoBaseOptions() : super(baseUrl: '');
}

@Injectable(as: BaseOptions, env: [EnvironmentConfig.dev])
class DevBaseOptions extends BaseOptions {
  DevBaseOptions()
      : super(
          baseUrl: envConfig.baseUrl,
          receiveTimeout: 10000,
          connectTimeout: 10000,
        );
}
