// ignore_for_file: body_might_complete_normally_nullable, unrelated_type_equality_checks, avoid_print

import 'dart:convert';

import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:units_app/models/unit_entry.dart';

class UserService with ChangeNotifier {
  BackendlessUser? _currentUser;
  BackendlessUser? get currentUser => _currentUser;

  // Called when the user logsout
  void setCurrentUserNull() {
    _currentUser = null;
  }

  // Called to see if the user exists
  bool _userExists = false;
  bool get userExists => _userExists;

  set userExists(bool value) {
    _userExists = value;
    notifyListeners();
  }

  // Called to see if the password is valid
  bool _passwordInvalid = false;
  bool get passwordInvalid => _passwordInvalid;

  set passwordInvalid(bool value) {
    _passwordInvalid = value;
    notifyListeners();
  }

  // Use to see when to call the loading page
  bool _showUserProgress = false;
  bool get showUserProgress => _showUserProgress;

  // Text to pass to the loading page when called
  String _userProgressText = '';
  String get userProgressText => _userProgressText;

  Future<String> resetPassword(String username) async {
    String result = 'OK';

    // Start the progress indicator
    _showUserProgress = true;
    _userProgressText = 'Sending Reset instructions...please wait...';
    notifyListeners();

    // send the reset instructions to user email
    await Backendless.userService
        .restorePassword(username)
        .onError((error, stackTrace) {
      result = getHumanReadableError(error.toString());
    });

    // Stop the progress indicator
    _showUserProgress = false;
    notifyListeners();

    return result;
  }

  // Logins user in
  Future<String> loginUser(String username, String password) async {
    String result = 'OK';

    // Start the progress indicator
    _showUserProgress = true;
    _userProgressText = 'Logging you in...please wait...';
    notifyListeners();

    BackendlessUser? user = await Backendless.userService
        .login(username, password, true)
        .onError((error, stackTrace) {
      result = getHumanReadableError(error.toString());
    });

    // Update the current user if user exists
    if (user != null) {
      _currentUser = user;
    }

    // Stop the progress indicator
    _showUserProgress = false;
    notifyListeners();

    return result;
  }

  // Logs out the user
  Future<String> logoutUser() async {
    String result = 'OK';

    // Start the progress indicator
    _showUserProgress = true;
    _userProgressText = 'Signing you out...please wait...';
    notifyListeners();

    await Backendless.userService.logout().onError((error, stackTrace) {
      result = error.toString();
    });

    // Stop the progress indicator
    _showUserProgress = false;
    notifyListeners();

    return result;
  }

  // Check if the user has already been logged in
  Future<String> checkIfUserLoggedIn() async {
    String result = 'OK';

    // Check to see if there is a valid login
    bool? validLogin = await Backendless.userService
        .isValidLogin()
        .onError((error, stackTrace) {
      result = error.toString();
    });

    // Check to see if the user login is valid
    // and get ObjectId of logged in user
    if (validLogin != null && validLogin) {
      String? currentUserObjectId = await Backendless.userService
          .loggedInUser()
          .onError((error, stackTrace) {
        result = error.toString();
      });

      // Find the current user ObjectId on Backendless Users table
      if (currentUserObjectId != Null) {
        Map<dynamic, dynamic>? mapOfCurrentUser = await Backendless.data
            .of("Users")
            .findById(currentUserObjectId!)
            .onError((error, stackTrace) {
          result = error.toString();
        });

        // set the current user
        if (mapOfCurrentUser != Null) {
          _currentUser = BackendlessUser.fromJson(mapOfCurrentUser!);
          notifyListeners();
        } else {
          result = 'NOT OK';
        }
      } else {
        result = 'NOT OK';
      }
    } else {
      result = 'NOT OK';
    }

    return result;
  }

  // Check if the username has already been used
  void checkIfUserExists(String username) async {
    DataQueryBuilder queryBuilder = DataQueryBuilder()
      ..whereClause = "email = '$username'";

    await Backendless.data
        .withClass<BackendlessUser>()
        .find(queryBuilder)
        .then((value) {
      if (value == null || value.isEmpty) {
        _userExists = false;
        notifyListeners();
      } else {
        _userExists = true;
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }

  void checkIfPasswordInvalid(String password) {
    if (password.length <= 8) {
      _passwordInvalid = true;
      notifyListeners();
    } else {
      _passwordInvalid = false;
      notifyListeners();
    }
  }

  // Create a new user on Backendless and create a database table
  Future<String> createUser(BackendlessUser user) async {
    String result = 'OK';

    // Start the progress indicator
    _showUserProgress = true;
    _userProgressText = 'Creating a new user...please wait...';
    notifyListeners();

    try {
      Map<String, dynamic> starterUnits = {};

      // Get the json file data from Dropbox
      // This is so that we can create starter notes for new users
      final response = await get(
        Uri.parse(
            'https://dl.dropbox.com/s/q6chvs5eqktd1nb/unitReflections.json?dl=0'),
      );

      if (response.statusCode == 200) {
        starterUnits = jsonDecode(response.body);
      }

      // Try to register the new user on Backendless
      await Backendless.userService.register(user);

      // Create an empty table entry
      UnitEntry emptyEntry = UnitEntry(
        units: starterUnits,
        username: user.email,
      );

      // Save data to Backendless {TodoEntry} Table
      await Backendless.data
          .of('UnitEntry')
          .save(emptyEntry.toJson())
          .onError((error, stackTrace) {
        result = error.toString();
      });
    } catch (e) {
      result = getHumanReadableError(e.toString());
    }

    // Stop the progress indicator
    _showUserProgress = false;
    notifyListeners();

    return result;
  }
}

// List of possible error that may occur in more understandable language
String getHumanReadableError(String message) {
  if (message.contains('email address must be confirmed first')) {
    return 'Please check your inbox and confirm your email address and try to login again.';
  }
  if (message.contains('User already exists')) {
    return 'This user already exists in our database. Please create a new user.';
  }
  if (message.contains('Invalid login or password')) {
    return 'Please check your username or password. The combination do not match any entry in our database.';
  }
  if (message
      .contains('User account is locked out due to too many failed logins')) {
    return 'Your account is locked due to too many failed login attempts. Please wait 30 minutes and try again.';
  }
  if (message.contains('Unable to find a user with the specified identity')) {
    return 'Your email address does not exist in our database. Please check for spelling mistakes.';
  }
  if (message.contains(
      'Unable to resolve host "api.backendless.com": No address associated with hostname')) {
    return 'It seems as if you do not have an internet connection. Please connect and try again.';
  }
  return message;
}
