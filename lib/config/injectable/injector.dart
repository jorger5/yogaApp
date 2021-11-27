import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:zen_app/config/env/environment_config.dart';

import 'injector.config.dart';

final getIt = GetIt.instance;

final EnvironmentConfig envConfig = getIt<EnvironmentConfig>();

@InjectableInit(
  initializerName: r'$initGetIt', // default
)
Future<void> configureDependencies() async {
  $initGetIt(getIt, environment: EnvironmentConfig.env);
}
