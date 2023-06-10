// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:units_app/routes/routes.dart';
import 'package:units_app/services/helper_user.dart';
import 'package:units_app/services/user_service.dart';
import 'package:units_app/views/widgets/app_progress_indicator.dart';
import 'package:units_app/views/widgets/form_button.dart';
import 'package:units_app/views/widgets/textfield.dart';

class SingUpPage extends StatefulWidget {
  const SingUpPage({Key? key}) : super(key: key);

  @override
  _SingUpPageState createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  late TextEditingController usernameController;
  late TextEditingController nameController;
  late TextEditingController passwordController;

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
                        SvgPicture.asset('assets/images/signup.svg'),
                        const Text(
                          'SIGN UP',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: screenHeight * .05),
                        Focus(
                          // Check to see if the username textfield is still in focus
                          onFocusChange: (value) async {
                            if (!value) {
                              context.read<UserService>().checkIfUserExists(
                                  usernameController.text.trim());
                            }
                          },
                          child: InputField(
                            hintText: 'Please enter your email address',
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            controller: usernameController,
                            prefixIcon: const Icon(Icons.person),
                          ),
                        ),
                        Selector<UserService, bool>(
                          selector: (context, value) => value.userExists,
                          builder: (context, value, child) {
                            return value
                                ? const Text(
                                    'Username exits, pleasee choose another',
                                    style: TextStyle(
                                      color: Color.fromRGBO(253, 213, 4, 1),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : Container();
                          },
                        ),
                        SizedBox(height: screenHeight * .025),
                        InputField(
                          hintText: 'Please enter your name',
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          controller: nameController,
                          prefixIcon: const Icon(Icons.perm_identity),
                        ),
                        SizedBox(height: screenHeight * .025),
                        Focus(
                          onFocusChange: (value) {
                            if (!value ||
                                passwordController.text !=
                                    'Please enter your password') {
                              context
                                  .read<UserService>()
                                  .checkIfPasswordInvalid(
                                      passwordController.text.trim());
                            }
                          },
                          child: InputField(
                            hintText: 'Please enter your password',
                            obscureText: true,
                            textInputAction: TextInputAction.next,
                            controller: passwordController,
                            prefixIcon: const Icon(Icons.lock),
                          ),
                        ),
                        Selector<UserService, bool>(
                          selector: (context, value) => value.passwordInvalid,
                          builder: (context, value, child) {
                            return value
                                ? const Text(
                                    'Password should be atlease 8 characters long',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromRGBO(253, 213, 4, 1),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : Container();
                          },
                        ),
                        SizedBox(
                          height: screenHeight * .05,
                        ),
                        FormButton(
                          onPressed: () async {
                            if (UserService().passwordInvalid != true) {
                              createNewUserInUI(
                                context,
                                email: usernameController.text.trim(),
                                password: passwordController.text.trim(),
                                name: nameController.text.trim(),
                              );
                            }
                          },
                          text: 'Sign Up',
                        ),
                        SizedBox(
                          height: screenHeight * .08,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account?",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .popAndPushNamed(RouteManager.loginPage);
                              },
                              child: const Text(
                                'Sign In',
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
            Selector<UserService, Tuple2>(
              selector: (context, value) =>
                  Tuple2(value.showUserProgress, value.userProgressText),
              builder: (context, value, child) {
                return value.item1
                    ? AppProgressIndicator(text: value.item2)
                    : Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
