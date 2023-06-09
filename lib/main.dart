// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:units_app/models/theme.dart';
import 'package:units_app/routes/routes.dart';
import 'package:units_app/services/user_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => UserService(),
          ),
          ChangeNotifierProvider(
            create: (context) => ThemeSwitch(),
          ),
        ],
        child: Consumer<ThemeSwitch>(
          builder: (context, value, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: value.darkTheme ? darkTheme : lightTheme,
              initialRoute: RouteManager.loadingPage,
              onGenerateRoute: RouteManager.generateRoute,
            );
          },
        ));
  }
}
