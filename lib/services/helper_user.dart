// ignore_for_file: use_build_context_synchronously

import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:units_app/routes/routes.dart';
import 'package:units_app/services/user_service.dart';
import 'package:units_app/views/widgets/dialogs.dart';

// This function is our viewmodel for registering a user
// in on the RegisterPage
void createNewUserInUI(BuildContext context,
    {required String email,
    required String password,
    required String name}) async {
  // Remove focus from Textfeild and close keyboard
  FocusManager.instance.primaryFocus?.unfocus();

  if (email.isEmpty || name.isEmpty || password.isEmpty) {
    showSnackBar(
      context,
      'Please enter all fields!',
    );
  } else {
    BackendlessUser user = BackendlessUser()
      ..email = email.trim()
      ..password = password.trim()
      ..putProperties({'name': name.trim()});

    String result = await context.read<UserService>().createUser(user);

    if (result != 'OK') {
      showSnackBar(context, result);
    } else {
      showSnackBar(context, 'New user successfully created!');
      Navigator.pop(context);
    }
  }
}

// This function is our viewmodel for logging a users
// in on the LoginPage
void loginUserInUI(BuildContext context,
    {required String email, required String password}) async {
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
      // get the units of the users
      Navigator.of(context).popAndPushNamed(RouteManager.unitPage);
    }
  }
}

// This function is our viewmodel for resetting a users password when
// the forgot password TextButton is clicked
void resetPasswordInUI(BuildContext context, {required String email}) async {
  if (email.isEmpty) {
    showSnackBar(context,
        'Please enter your email address then click the Reset Password again!');
  } else {
    String result = await context.read<UserService>().resetPassword(email);

    if (result == 'OK') {
      showSnackBar(
          context, 'Successfull sent password reset, Please check your mail');
    } else {
      showSnackBar(context, result);
    }
  }
}

// this function is our viewmodel for logging out a user
void logoutUserInUI(BuildContext context) async {
  String result = await context.read<UserService>().logoutUser();

  if (result == 'OK') {
    context.read<UserService>().setCurrentUserNull();
    Navigator.popAndPushNamed(context, RouteManager.loginPage);
  } else {
    showSnackBar(context, result);
  }
}
