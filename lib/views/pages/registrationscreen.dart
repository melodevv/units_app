import 'package:flutter/material.dart';
import 'package:units_app/viewmodel/user_auth_validation.dart';
import '../widgets/form_button.dart';
import '../widgets/textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController usernameController = TextEditingController();
  late TextEditingController nameController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();

  String? emailError, passwordError;
  UserAuthentication userAuthentication = UserAuthentication();

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    nameController = TextEditingController();
    passwordController = TextEditingController();
    emailError = null;
    passwordError = null;
  }

  @override
  void dispose() {
    usernameController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign Up',
          style: TextStyle(color: Colors.grey),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            SizedBox(height: screenHeight * .12),
            const Text(
              'Create Account,',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenHeight * .01),
            Text(
              'Sign up to get started!',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.withOpacity(.6),
              ),
            ),
            SizedBox(height: screenHeight * .12),
            InputField(
              labelText: 'Email',
              errorText: emailError,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autoFocus: true,
              controller: usernameController,
            ),
            SizedBox(height: screenHeight * .025),
            InputField(
              labelText: 'Name',
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              autoFocus: true,
              controller: nameController,
            ),
            SizedBox(height: screenHeight * .025),
            InputField(
              labelText: 'Password',
              errorText: passwordError,
              obscureText: true,
              textInputAction: TextInputAction.next,
              controller: passwordController,
            ),
            SizedBox(height: screenHeight * .025),
            InputField(
              onSubmitted: (value) {
                userAuthentication.submit((email, password) {});
              },
              labelText: 'Confirm Password',
              errorText: passwordError,
              obscureText: true,
              textInputAction: TextInputAction.done,
              controller: passwordController,
            ),
            SizedBox(
              height: screenHeight * .075,
            ),
            FormButton(
              text: 'Sign Up',
              onPressed: () {
                userAuthentication.submit((email, password) {});
              },
            ),
            SizedBox(
              height: screenHeight * .125,
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: RichText(
                text: const TextSpan(
                  text: "I'm already a member, ",
                  style: TextStyle(color: Colors.grey),
                  children: [
                    TextSpan(
                      text: 'Sign In',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
