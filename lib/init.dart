// ignore_for_file: use_build_context_synchronously

import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:units_app/routes/routes.dart';
import 'package:units_app/services/unit_service.dart';
import 'package:units_app/services/user_service.dart';

class InitApp {
  static const String apiKeyAndroid = '45316AD5-A906-4554-90E9-3B9B89F129E7';
  static const String apiKeyiOS = '2ACE6E3D-8794-4F15-A491-ECA6361A8ADD';
  static const String appID = '8329D488-8458-0878-FF19-AB3C3C087A00';

  static void initializeApp(BuildContext context) async {
    await Backendless.initApp(
        applicationId: appID,
        iosApiKey: apiKeyiOS,
        androidApiKey: apiKeyAndroid);
    String result = await context.read<UserService>().checkIfUserLoggedIn();
    if (result == 'OK') {
      context
          .read<UnitService>()
          .getUnits(context.read<UserService>().currentUser!.email);
      Navigator.popAndPushNamed(context, RouteManager.unitPage);
    } else {
      Navigator.popAndPushNamed(context, RouteManager.loginPage);
    }
  }
}
