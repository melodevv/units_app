// ignore_for_file: use_build_context_synchronously

import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:units_app/routes/routes.dart';
import 'package:units_app/services/user_service.dart';

class InitApp {
  static const String apiKeyAndroid = '46504B08-5162-4120-B9FA-1F938DD7CED9';
  static const String apiKeyiOS = 'E281AD11-E6A6-423D-AB2E-84E6689E3A75';
  static const String appID = '3660A7D5-2E72-16FE-FF13-F47D7346EE00';

  static void initializeApp(BuildContext context) async {
    await Backendless.initApp(
        applicationId: appID,
        iosApiKey: apiKeyiOS,
        androidApiKey: apiKeyAndroid);
    String result = await context.read<UserService>().checkIfUserLoggedIn();
    if (result == 'OK') {
      Navigator.popAndPushNamed(context, RouteManager.unitPage);
    } else {
      Navigator.popAndPushNamed(context, RouteManager.loginPage);
    }
  }
}
