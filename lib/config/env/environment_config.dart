import 'package:zen_app/config/env/environment_variables.dart';

abstract class EnvironmentConfig implements EnvironmentVariables {
  static const String env = String.fromEnvironment('ENV', defaultValue: 'demo');
  static const String demo = 'demo';
  static const String dev = 'dev';
}
