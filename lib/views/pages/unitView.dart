// ignore_for_file: unused_field, prefer_const_constructors, unnecessary_null_comparison
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart' as provider;
import 'package:tuple/tuple.dart';
import 'package:units_app/models/theme.dart';
import 'package:units_app/services/helper_unit.dart';
import 'package:units_app/services/helper_user.dart';
import 'package:units_app/services/user_service.dart';
import 'package:units_app/views/widgets/app_progress_indicator.dart';
import 'dart:convert';

import 'package:units_app/views/widgets/dialogs.dart';
import 'package:units_app/views/widgets/icon_buttons.dart';
import 'package:units_app/views/widgets/unitsListView.dart';

class UnitPage extends StatefulWidget {
  const UnitPage({super.key});

  @override
  State<UnitPage> createState() => _UnitPageState();
}

class _UnitPageState extends State<UnitPage> {
  List _units = [];

  Future<void> readUnits() async {
    final String response =
        await rootBundle.loadString('assets/unitReflections.json');
    final data = await json.decode(response);
    setState(() {
      _units = data["ReflectionData"];
    });
  }

  String name = '';
  late TextEditingController unitController = TextEditingController();
  late TextEditingController reflectionController = TextEditingController();

  @override
  initState() {
    super.initState();
    unitController = TextEditingController();
    reflectionController = TextEditingController();
  }

  @override
  dispose() {
    unitController.dispose();
    reflectionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              refreshUnitsInUI(context);
            },
          ),
          // This button creates a new unit reflection,
          // you need to first enter the unit description,
          // press next when done, then enter the reflection,
          // and then save the unit
          IconButtons(
            unitController: unitController,
            reflectionController: reflectionController,
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              saveAllUnitsInUI(context);
            },
          ),
        ],
        title: Text(
          'Unit Reflection',
        ),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                provider.Consumer<ThemeSwitch>(
                  builder: (context, value, child) {
                    return SwitchListTile(
                      value: value.darkTheme,
                      onChanged: (newValue) {
                        value.switchTheme();
                      },
                    );
                  },
                ),
                provider.Selector<UserService, BackendlessUser?>(
                  selector: (context, value) => value.currentUser,
                  builder: (context, value, child) {
                    name = value!.getProperty('name');
                    return value == null
                        ? Container()
                        : Text(
                            '${value.getProperty('name')}\'s Units List',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 35,
                            ),
                          );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      showSnackBar(context, 'Loading reflections...');
                      readUnits();
                    },
                    child: const Text(
                      'View Reflections',
                      style: TextStyle(
                        color: Colors.lightBlue,
                      ),
                    ),
                  ),
                ),
                _units.isNotEmpty
                    ? Expanded(
                        // This UnitsListView displays the units reflections created by the user,
                        // allowing them to delete, and toggle them
                        child: UnitsListView(units: _units),
                      )
                    : Container(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {
                      logoutUserInUI(context);
                      showSnackBar(context, "Logout successful!");
                    },
                    child: Text(
                      "Logout",
                    ),
                  ),
                ),
              ],
            ),
          ),
          provider.Selector<UserService, Tuple2>(
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
