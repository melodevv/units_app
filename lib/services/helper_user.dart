// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:units_app/routes/routes.dart';
import 'package:units_app/services/user_service.dart';
import 'package:units_app/views/widgets/dialogs.dart';

void createNewUserInUI(BuildContext context,
    {required String email,
    required String password,
    required String name}) async {
  // Remove focus from Textfeild and close keyboard
  FocusManager.instance.primaryFocus?.unfocus();

  if (email.isEmpty || password.isEmpty) {
    showSnackBar(
      context,
      'Please enter all fields!',
    );
  } else {
    String result = await context
        .read<UserService>()
        .loginUser(email.trim(), password.trim());

    if (result != 'OK') {
      showSnackBar(context, result);
    } else {
      // get the todos of the users
      Navigator.of(context).popAndPushNamed(RouteManager.unitPage);
    }
  }
}

void loginUserInUI(BuildContext context,
    {required String email, required String password}) async {}

void resetPasswordInUI(BuildContext context, {required String email}) async {}

void logoutUserInUI(BuildContext context) async {}
