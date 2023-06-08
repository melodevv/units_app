import 'package:flutter/material.dart';
import 'package:units_app/routes/routes.dart';
import 'package:units_app/services/helper_user.dart';
import 'package:units_app/views/widgets/form_button.dart';
import 'package:units_app/views/widgets/textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  late TextEditingController usernameController = TextEditingController();
  late TextEditingController nameController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    nameController = TextEditingController();
    passwordController = TextEditingController();
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
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight * .12),
                    const Text(
                      'Aready have an Account?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * .01),
                    const Text(
                      'Sign in to continue!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: screenHeight * .12),
                    InputField(
                      labelText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      controller: usernameController,
                    ),
                    SizedBox(height: screenHeight * .025),
                    InputField(
                      labelText: 'Please enter your password',
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                      controller: passwordController,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () async {
                          resetPasswordInUI(context,
                              email: usernameController.text.trim());
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.lightBlue,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * .015,
                    ),
                    FormButton(
                        text: 'Log In',
                        onPressed: () async {
                          loginUserInUI(
                            context,
                            email: usernameController.text.trim(),
                            password: passwordController.text.trim(),
                          );
                        }),
                    SizedBox(
                      height: screenHeight * .15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an Account?",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Got to RegisterPage
                            Navigator.of(context)
                                .popAndPushNamed(RouteManager.registerPage);
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
