// ignore_for_file: body_might_complete_normally_nullable

import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
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

  // Use to see when to call the loading page
  bool _showUserProgress = false;
  bool get showUserProgress => _showUserProgress;

  // Text to pass to the loading page when called
  String _userProgressText = '';
  String get userProgressText => _userProgressText;

  Future<String> resetPassword(String username) async {
    String result = 'OK';
    return result;
  }

  // Logins user in
  Future<String> loginUser(String username, String password) async {
    String result = 'OK';

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
    return result;
  }

  // Check if the user has already been logged in
  Future<String> checkIfUserLoggedIn() async {
    String result = 'O';
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

  // Create a new user on Backendless and create a database table
  Future<String> createUser(BackendlessUser user) async {
    String result = 'OK';

    // Start the progress indicator
    _showUserProgress = true;
    _userProgressText = 'Creating a new user...please wait...';
    notifyListeners();

    try {
      // Try to register the new user on Backendless
      await Backendless.userService.register(user);

      // Create an empty table entry
      UnitEntry emptyEntry = UnitEntry(units: {}, username: user.email);

      // Save data to Backendless {TodoEntry} Table
      await Backendless.data
          .of('TodoEntry')
          .save(emptyEntry.toJson())
          .onError((error, stackTrace) {
        result = error.toString();
        return null;
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
