import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
// Press ctrl + . and ignore the error or warning about outdated widgets for the file
class MyApp extends StatelessWidget {
  final ThemeData charcoalTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.grey[900],
    accentColor: Colors.grey[500],
    scaffoldBackgroundColor: Colors.grey[900],
    textTheme: TextTheme(
      bodyText1: TextStyle(color: Colors.grey[500]),
      bodyText2: TextStyle(color: Colors.grey[500]),
    ),
    appBarTheme: AppBarTheme(
      color: Colors.grey[900],
      iconTheme: IconThemeData(color: Colors.grey[500]),
      textTheme: TextTheme(
        headline6: TextStyle(
          color: Colors.grey[500],
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Charcoal Theme',
      theme: charcoalTheme,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Charcoal Theme'),
        ),
        body: Center(
          child: Text(
            'Hello, World!',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ),
    );
  }
}
