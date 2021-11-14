import 'package:flutter/material.dart';
import 'package:zen_app/core/utils/constants.dart';
import 'package:zen_app/presentation/home/home_screen.dart';
import 'package:zen_app/presentation/login/login_screen.dart';
import 'package:zen_app/presentation/register/register.dart';

class PageRoutes {
  static Route<dynamic> routes(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen());
      case loginRoute:
        return MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen());
      case registerRoute:
        return MaterialPageRoute(
            builder: (BuildContext context) => RegisterScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
          centerTitle: true,
        ),
        body: Center(
          child: Text('Pagina no encontrada'),
        ),
      );
    });
  }
}
