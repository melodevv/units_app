import 'package:flutter/material.dart';
import 'package:units_app/views/pages/loading.dart';
import 'package:units_app/views/pages/login.dart';
import 'package:units_app/views/pages/register.dart';
import 'package:units_app/views/pages/unit.dart';

class RouteManager {
  static const String loginPage = '/';
  static const String registerPage = '/registerPage';
  static const String unitPage = '/unitPage';
  static const String loadingPage = '/loadingPage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginPage:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );

      case registerPage:
        return MaterialPageRoute(
          builder: (context) => const RegisterPage(),
        );

      case unitPage:
        return MaterialPageRoute(
          builder: (context) => const UnitPage(),
        );

      case loadingPage:
        return MaterialPageRoute(
          builder: (context) => const Loading(),
        );

      default:
        throw const FormatException('Route not found! Check routes again!');
    }
  }
}
