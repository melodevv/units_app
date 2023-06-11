import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:units_app/routes/routes.dart';
import 'package:units_app/viewmodel/helper_user.dart';
import 'package:units_app/views/widgets/form_button.dart';
import 'package:units_app/views/widgets/textfield.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);
  @override
  State<SignInPage> createState() => _LoginPage();
}

class _LoginPage extends State<SignInPage> {
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(98, 58, 162, 1),
              Color.fromRGBO(26, 128, 253, 1),
              Color.fromRGBO(98, 58, 162, 1)
            ],
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/images/login.svg'),
                        const Text(
                          'WELCOME BACK!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: screenHeight * .05),
                        InputField(
                          hintText: 'Please enter your email',
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          controller: usernameController,
                          prefixIcon: const Icon(Icons.person),
                        ),
                        SizedBox(height: screenHeight * .025),
                        InputField(
                          hintText: 'Please enter your password',
                          obscureText: true,
                          textInputAction: TextInputAction.next,
                          controller: passwordController,
                          prefixIcon: const Icon(Icons.lock),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () async {
                              resetPasswordInUI(context,
                                  email: usernameController.text.trim());
                            },
                            child: const Text(
                              'Forgot your password?',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * .015,
                        ),
                        FormButton(
                            text: 'Sign In',
                            onPressed: () async {
                              loginUserInUI(
                                context,
                                email: usernameController.text.trim(),
                                password: passwordController.text.trim(),
                              );
                            }),
                        SizedBox(
                          height: screenHeight * .08,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(
                                color: Colors.white,
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
                                  color: Color.fromRGBO(253, 213, 4, 1),
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
            ),
          ],
        ),
      ),
    );
  }
}
