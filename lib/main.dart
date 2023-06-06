// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:units_app/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: const [],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey[900],
          textTheme: TextTheme(
            headline6: TextStyle(
                color: Colors.grey[500],
                fontSize: 20,
                fontWeight: FontWeight.bold),
            bodyText1: TextStyle(color: Colors.grey[500]),
            bodyText2: TextStyle(color: Colors.grey[300]),
            caption: TextStyle(color: Colors.grey[200]),
          ),
          primaryColor: Colors.grey[900],
          appBarTheme: AppBarTheme(
            color: Colors.grey[900],
            iconTheme: IconThemeData(color: Colors.grey[500]),
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
          useMaterial3: true,
        ),
        initialRoute: RouteManager.loginPage,
        onGenerateRoute: RouteManager.generateRoute,
      ),
    );
  }
}
