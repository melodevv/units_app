import 'package:flutter/material.dart';
import 'package:units_app/routes/routes.dart';
import 'package:units_app/services/helper_user.dart';
import 'package:units_app/viewmodel/user_auth_validation.dart';
import 'package:units_app/views/widgets/form_button.dart';
import 'package:units_app/views/widgets/textfield.dart';

class LoginPage extends StatefulWidget {
  /// Callback for when this form is submitted successfully. Parameters are (email, password)
  final Function(String? email, String? password)? onSubmitted;

  const LoginPage({this.onSubmitted, Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
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
      // appBar: AppBar(
      //   title: const Text(
      //     "Sign In",
      //     style: TextStyle(color: Colors.grey),
      //   ),
      // ),

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
                      // errorText: emailError,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      // autoFocus: true,
                      controller: usernameController,
                    ),
                    SizedBox(height: screenHeight * .025),
                    InputField(
                      labelText: 'Please enter your password',
                      errorText: passwordError,
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                      controller: passwordController,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
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
                        onPressed: () {
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
                            Navigator.of(context)
                                .pushNamed(RouteManager.registerPage);
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

      // body: Padding(
      //   padding: const EdgeInsets.all(40),
      //   child: ListView(
      //     children: [
      //       SizedBox(height: screenHeight * .12),
      //       const Text(
      //         'Welcome,',
      //         style: TextStyle(
      //           fontSize: 28,
      //           fontWeight: FontWeight.bold,
      //         ),
      //       ),
      //       SizedBox(height: screenHeight * .01),
      //       const Text(
      //         'Sign in to continue!',
      //         style: TextStyle(
      //           fontSize: 18,
      //         ),
      //       ),
      //       SizedBox(height: screenHeight * .12),
      //       InputField(
      //         onChanged: (value) {},
      //         labelText: 'Email',
      //         // errorText: emailError,
      //         keyboardType: TextInputType.emailAddress,
      //         textInputAction: TextInputAction.next,
      //         // autoFocus: true,
      //         controller: usernameController,
      //       ),
      //       SizedBox(height: screenHeight * .025),
      //       InputField(
      //         onChanged: (value) {},
      //         onSubmitted: (val) {
      //           userAuthentication.submit((email, password) {});
      //         },
      //         labelText: 'Password',
      //         // errorText: passwordError,
      //         obscureText: true,
      //         textInputAction: TextInputAction.next,
      //         controller: passwordController,
      //       ),
      //       Align(
      //         alignment: Alignment.centerRight,
      //         child: TextButton(
      //           onPressed: () {},
      //           child: const Text(
      //             'Forgot Password?',
      //             style: TextStyle(
      //               color: Colors.lightBlue,
      //             ),
      //           ),
      //         ),
      //       ),
      //       SizedBox(
      //         height: screenHeight * .075,
      //       ),
      //       FormButton(
      //           text: 'Log In',
      //           onPressed: () {
      //             userAuthentication.submit((email, password) {});
      //           }),
      //       SizedBox(
      //         height: screenHeight * .15,
      //       ),
      //       TextButton(
      //         onPressed: () => Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //             builder: (_) => const RegisterPage(),
      //           ),
      //         ),
      //         child: RichText(
      //           text: const TextSpan(
      //             text: "I'm a new user, ",
      //             style: TextStyle(color: Colors.grey),
      //             children: [
      //               TextSpan(
      //                 text: 'Sign Up',
      //                 style: TextStyle(
      //                   color: Colors.blue,
      //                   fontWeight: FontWeight.bold,
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
