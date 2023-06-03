import 'package:flutter/widgets.dart';

class UserAuthentication extends ChangeNotifier {
  String? emailError;
  String? passwordError;
  String email = '';
  String password = '';
  String confirmPassword = '';
  void resetErrorText() {
    emailError = null;
    passwordError = null;
    notifyListeners();
  }

  bool validate() {
    resetErrorText();
    RegExp emailExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    bool isValid = true;
    if (email.isEmpty || !emailExp.hasMatch(email)) {
      emailError = 'Email is invalid';
      isValid = false;
    }
    if (password.isEmpty || confirmPassword.isEmpty) {
      passwordError = 'Please enter a password';
      isValid = false;
    }
    if (password != confirmPassword) {
      passwordError = 'Passwords do not match';
      isValid = false;
    }
    notifyListeners();
    return isValid;
  }

  void submit(void Function(String email, String password)? onSubmitted) {
    if (validate()) {
      if (onSubmitted != null) {
        onSubmitted(email, password);
      }
    }
  }
}
