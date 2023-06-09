// ignore_for_file: deprecated_member_use, prefer_conditional_assignment, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData lightTheme = ThemeData(
  cardTheme: CardTheme(color: Colors.grey),
  iconTheme: IconThemeData(
    color: Colors.grey[900],
  ),
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: Colors.grey[100],
  drawerTheme: DrawerThemeData(
    backgroundColor: Colors.grey[100],
    shadowColor: Colors.lightBlue,
  ),
  appBarTheme: AppBarTheme(
    shadowColor: Colors.purple,
    elevation: 2,
    color: Colors.blue,
    iconTheme: const IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
    ),
  ),
  textTheme: TextTheme(
    headline6: TextStyle(
        color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
    bodyText1: TextStyle(color: Colors.grey[900]),
    bodyText2: TextStyle(color: Colors.grey[900]),
    caption: TextStyle(color: Colors.grey[900]),
  ),
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
  useMaterial3: true,
);

ThemeData darkTheme = ThemeData(
  iconTheme: IconThemeData(
    color: Colors.grey[200],
  ),
  scaffoldBackgroundColor: Colors.grey[900],
  textTheme: TextTheme(
    headline6: TextStyle(
        color: Colors.grey[500], fontSize: 20, fontWeight: FontWeight.bold),
    bodyText1: TextStyle(color: Colors.grey[500]),
    bodyText2: TextStyle(color: Colors.grey[300]),
    caption: TextStyle(color: Colors.grey[200]),
  ),
  primaryColor: Colors.grey[900],
  drawerTheme: DrawerThemeData(
    backgroundColor: Colors.grey[900],
    shadowColor: Colors.lightBlue,
  ),
  appBarTheme: AppBarTheme(
    shadowColor: Colors.lightBlue,
    elevation: 1,
    color: Colors.grey[900],
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
    ),
    iconTheme: IconThemeData(color: Colors.grey[200]),
  ),
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
  useMaterial3: true,
);

class ThemeSwitch with ChangeNotifier {
  bool _darkTheme = false;
  SharedPreferences? _preferences;
  bool _doneLoading = false;
  bool get loading => _doneLoading;

  set doneLoading(bool value) {
    _doneLoading = value;
    notifyListeners();
  }

  bool get darkTheme => _darkTheme;
  themeSettings() {
    _loadSettingsFromPrefs();
  }

  _initializePrefs() async {
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
  }

  _loadSettingsFromPrefs() async {
    await _initializePrefs();
    _darkTheme = _preferences?.getBool('darkthem') ?? false;
    notifyListeners();
  }

  _saveSettingsToPrefs() async {
    await _initializePrefs();
    _preferences?.setBool('darkTheme', _darkTheme);
  }

  void switchTheme() {
    _darkTheme = !_darkTheme;
    _saveSettingsToPrefs();
    notifyListeners();
  }
}
