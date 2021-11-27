import 'package:flutter/material.dart';
import 'package:zen_app/core/utils/constants.dart';
import 'package:zen_app/presentation/home/home_screen.dart';
import 'package:zen_app/presentation/login/login_screen.dart';
import 'package:zen_app/presentation/onboarding/onboarding_screen.dart';
import 'package:zen_app/presentation/register/register.dart';

class PageRoutes {
  static Route<dynamic> routes(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());
      case loginRoute:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen());
      case registerRoute:
        return MaterialPageRoute(
            builder: (BuildContext context) => const RegisterScreen());
      case onboardingRoute:
        return MaterialPageRoute(
            builder: (BuildContext context) => const OnboardingScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
          centerTitle: true,
        ),
        body: const Center(
          child: Text('Pagina no encontrada'),
        ),
      );
    });
  }
}
