// ignore_for_file: unused_field, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:units_app/services/helper_unit.dart';
import 'package:units_app/services/helper_user.dart';
import 'package:units_app/services/user_service.dart';
import 'package:units_app/views/widgets/app_progress_indicator.dart';
import 'dart:convert';

import 'package:units_app/views/widgets/dialogs.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Unit Reflection',
          style: TextStyle(
            color: Colors.grey[500],
          ),
        ),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          refreshUnitsUI(context);
                        },
                        icon: const Icon(
                          Icons.refresh,
                          size: 30,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          saveAllUnitsUI(context);
                        },
                        icon: const Icon(
                          Icons.save,
                          size: 30,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          logoutUserInUI(context);
                        },
                        icon: const Icon(
                          Icons.exit_to_app,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'User\'s Units List',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 46,
                      color: Colors.white,
                    ),
                  ),
                ),
                _units.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: _units.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: Colors.black,
                              key: ValueKey(_units[index]["unitId"]),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 20.0,
                                    bottom: 20,
                                    left: 16.0,
                                    right: 16.0),
                                child: ListTile(
                                  title: Text(_units[index]["unitDesc"]),
                                  subtitle: Text(_units[index]["reflections"]),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : const Text(
                        "Welcome [Placeholder for Student Name]!\nClick here for your unit summaries.\n\nOr you can add a new unit."),
              ],
            ),
          ),
          Positioned(
            top: 830,
            left: 330,
            child: IconButton(
              color: Colors.lightBlue,
              onPressed: () {
                logoutUserInUI(context);
              },
              icon: const Icon(
                Icons.add,
                size: 30,
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
      drawer: Drawer(
        elevation: 14,
        shadowColor: Colors.lightBlue,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey[700],
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      'https://www.excitededucator.com/uploads/5/1/3/4/51346849/screenshot-2020-09-10-at-18-03-07_orig.png'),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8),
                    child: ListTile(
                      leading: ElevatedButton(
                        onPressed: () {
                          showSnackBar(context, 'Loading reflections...');
                          readUnits();
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'View Reflections',
                          style: TextStyle(
                            color: Colors.lightBlue,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    leading: IconButton(
                      color: Colors.grey,
                      icon: Icon(Icons.refresh),
                      onPressed: () {},
                    ),
                    title: Text('Reload'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    leading: IconButton(
                      color: Colors.grey,
                      icon: Icon(Icons.add),
                      onPressed: () {},
                    ),
                    title: Text('Add reflection'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    leading: IconButton(
                      color: Colors.grey,
                      icon: Icon(Icons.save),
                      onPressed: () {},
                    ),
                    title: Text('Save reflection'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
              thickness: 2,
              color: Colors.lightBlue,
              indent: 4,
              endIndent: 4,
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                    onPressed: () {
                      logoutUserInUI(context);
                    },
                    child: Text("Logout")))
          ],
        ),
      ),
    );
  }
}
