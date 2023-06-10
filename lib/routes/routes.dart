import 'package:flutter/material.dart';
import 'package:units_app/views/pages/unitcreate.dart';
import 'package:units_app/views/pages/loading.dart';
import 'package:units_app/views/pages/signin.dart';
import 'package:units_app/views/pages/signup.dart';
import 'package:units_app/views/pages/unitreflections.dart';
import 'package:units_app/views/pages/unitview.dart';

class RouteManager {
  // variables for all the possible app routes
  static const String loginPage = '/';
  static const String registerPage = '/registerPage';
  static const String unitPage = '/unitPage';
  static const String loadingPage = '/loadingPage';
  static const String unitCreate = '/unitCreatePage';
  static const String unitViewPage = '/UnitViewPage';

  // The page routing for the app
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginPage:
        return MaterialPageRoute(
          builder: (context) => const SignInPage(),
        );

      case registerPage:
        return MaterialPageRoute(
          builder: (context) => const SingUpPage(),
        );

      case unitPage:
        return MaterialPageRoute(
          builder: (context) => const UnitReflectionsPage(),
        );

      case loadingPage:
        return MaterialPageRoute(
          builder: (context) => const Loading(),
        );
      case unitCreate:
        return MaterialPageRoute(
          builder: (context) => const UnitCreatePage(),
        );
      case unitViewPage:
        return MaterialPageRoute(
          builder: (context) => const UnitsViewPage(),
        );

      default:
        throw const FormatException('Route not found! Check routes again!');
    }
  }
}
