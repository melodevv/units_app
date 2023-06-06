// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
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

  // String? emailError, passwordError;
  // UserAuthentication userAuthentication = UserAuthentication();

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    nameController = TextEditingController();
    passwordController = TextEditingController();
    // emailError = null;
    // passwordError = null;
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
      //     'Sign Up',
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
                        // errorText: emailError,
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
                      labelText: 'Name',
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      // autoFocus: true,
                      controller: nameController,
                    ),
                    SizedBox(height: screenHeight * .025),
                    InputField(
                      labelText: 'Password',
                      // errorText: passwordError,
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                      controller: passwordController,
                    ),
                    // SizedBox(height: screenHeight * .025),
                    // InputField(
                    //   onSubmitted: (value) {
                    //     // userAuthentication.submit((email, password) {});
                    //   },
                    //   labelText: 'Confirm Password',
                    //   // errorText: passwordError,
                    //   obscureText: true,
                    //   textInputAction: TextInputAction.done,
                    //   controller: passwordController,
                    // ),
                    SizedBox(
                      height: screenHeight * .055,
                    ),
                    FormButton(
                      onPressed: () {
                        createNewUserInUI(
                          context,
                          email: usernameController.text.trim(),
                          password: passwordController.text.trim(),
                          name: nameController.text.trim(),
                        );
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
                          "Already have and account?",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
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
      // body: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 16),
      //   child: ListView(
      //     children: [
      //       SizedBox(height: screenHeight * .12),
      //       const Text(
      //         'Create Account,',
      //         style: TextStyle(
      //           fontSize: 28,
      //           fontWeight: FontWeight.bold,
      //         ),
      //       ),
      //       SizedBox(height: screenHeight * .01),
      //       Text(
      //         'Sign up to get started!',
      //         style: TextStyle(
      //           fontSize: 18,
      //           color: Colors.grey.withOpacity(.6),
      //         ),
      //       ),
      //       SizedBox(height: screenHeight * .12),
      //       Focus(
      //         // Check to see if the username textfield is still in focus
      //         onFocusChange: (value) async {
      //           if (!value) {
      //             context
      //                 .read<UserService>()
      //                 .checkIfUserExists(usernameController.text.trim());
      //           }
      //         },
      //         child: InputField(
      //           labelText: 'Please enter your email address',
      //           // errorText: emailError,
      //           keyboardType: TextInputType.emailAddress,
      //           textInputAction: TextInputAction.next,
      //           controller: usernameController,
      //         ),
      //       ),
      //       Selector<UserService, bool>(
      //         selector: (context, value) => value.userExists,
      //         builder: (context, value, child) {
      //           return value
      //               ? const Text(
      //                   'Username exits, pleasee choose another',
      //                   style: TextStyle(
      //                     color: Colors.red,
      //                     fontWeight: FontWeight.bold,
      //                   ),
      //                 )
      //               : Container();
      //         },
      //       ),
      //       SizedBox(height: screenHeight * .025),
      //       InputField(
      //         labelText: 'Name',
      //         keyboardType: TextInputType.text,
      //         textInputAction: TextInputAction.next,
      //         // autoFocus: true,
      //         controller: nameController,
      //       ),
      //       SizedBox(height: screenHeight * .025),
      //       InputField(
      //         labelText: 'Password',
      //         // errorText: passwordError,
      //         obscureText: true,
      //         textInputAction: TextInputAction.next,
      //         controller: passwordController,
      //       ),
      //       SizedBox(height: screenHeight * .025),
      //       InputField(
      //         onSubmitted: (value) {
      //           // userAuthentication.submit((email, password) {});
      //         },
      //         labelText: 'Confirm Password',
      //         // errorText: passwordError,
      //         obscureText: true,
      //         textInputAction: TextInputAction.done,
      //         controller: passwordController,
      //       ),
      //       SizedBox(
      //         height: screenHeight * .075,
      //       ),
      //       FormButton(
      //         onPressed: () {
      //           createNewUserInUI(
      //             context,
      //             email: usernameController.text.trim(),
      //             password: passwordController.text.trim(),
      //             name: nameController.text.trim(),
      //           );
      //         },
      //         text: 'Sign Up',
      //       ),
      //       SizedBox(
      //         height: screenHeight * .125,
      //       ),
      //       TextButton(
      //         onPressed: () => Navigator.pop(context),
      //         child: RichText(
      //           text: const TextSpan(
      //             text: "Already have and account? ",
      //             style: TextStyle(color: Colors.grey),
      //             children: [
      //               TextSpan(
      //                 text: 'Sign In',
      //                 style: TextStyle(
      //                   color: Colors.blue,
      //                   fontWeight: FontWeight.bold,
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //       Selector<UserService, Tuple2>(
      //         selector: (context, value) =>
      //             Tuple2(value.showUserProgress, value.userProgressText),
      //         builder: (context, value, child) {
      //           return value.item1
      //               ? AppProgressIndicator(text: value.item2)
      //               : Container();
      //         },
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
