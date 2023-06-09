// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:units_app/routes/routes.dart';
import 'package:units_app/services/helper_user.dart';
import 'package:units_app/services/user_service.dart';
import 'package:units_app/views/widgets/app_progress_indicator.dart';
import 'package:units_app/views/widgets/form_button.dart';
import 'package:units_app/views/widgets/textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
      body: Stack(
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
                      SizedBox(height: screenHeight * .12),
                      const Text(
                        'Are you a new user?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenHeight * .01),
                      Text(
                        'Sign up to get started!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.withOpacity(.6),
                        ),
                      ),
                      SizedBox(height: screenHeight * .12),
                      Focus(
                        // Check to see if the username textfield is still in focus
                        onFocusChange: (value) async {
                          if (!value) {
                            context.read<UserService>().checkIfUserExists(
                                usernameController.text.trim());
                          }
                        },
                        child: InputField(
                          labelText: 'Please enter your email address',
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          controller: usernameController,
                        ),
                      ),
                      Selector<UserService, bool>(
                        selector: (context, value) => value.userExists,
                        builder: (context, value, child) {
                          return value
                              ? const Text(
                                  'Username exits, pleasee choose another',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : Container();
                        },
                      ),
                      SizedBox(height: screenHeight * .025),
                      InputField(
                        labelText: 'Please enter your name',
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        controller: nameController,
                      ),
                      SizedBox(height: screenHeight * .025),
                      Focus(
                        onFocusChange: (value) {
                          if (!value) {
                            context.read<UserService>().checkIfPasswordInvalid(
                                passwordController.text.trim());
                          }
                        },
                        child: InputField(
                          labelText: 'Please enter your password',
                          obscureText: true,
                          textInputAction: TextInputAction.next,
                          controller: passwordController,
                        ),
                      ),
                      Selector<UserService, bool>(
                        selector: (context, value) => value.passwordInvalid,
                        builder: (context, value, child) {
                          return value
                              ? const Text(
                                  'Password must be 8 character long and contain:\n'
                                  'Minimum 1 Upper case\n'
                                  'Minimum 1 lowercase\n'
                                  'Minimum 1 Numeric Number\n'
                                  'Minimum 1 Special character [() ! @ # \$ & * ~]',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : Container();
                        },
                      ),
                      SizedBox(
                        height: screenHeight * .055,
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
                        height: screenHeight * .125,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account?",
                            style: TextStyle(
                              color: Colors.grey,
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
    );
  }
}
