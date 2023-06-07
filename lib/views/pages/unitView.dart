import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

void main() {
  runApp(const UnitPage());
}

class UnitPage extends StatefulWidget {
  const UnitPage({Key? key}) : super(key: key);
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
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text("Unit View"),
            ),
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _units.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                            itemCount: _units.length,
                            itemBuilder: (context, index) {
                              return Card(
                                key: ValueKey(_units[index]["unitId"]),
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 32.0,
                                        bottom: 32,
                                        left: 16.0,
                                        right: 16.0),
                                    child: ListTile(
                                      title: Text(_units[index]["unitDesc"]),
                                      subtitle:
                                          Text(_units[index]["reflections"]),
                                    )),
                              );
                            }))
                    : const Text(
                        "Welcome [Placeholder for Student Name]!\nClick here for your unit summaries.\n\nOr you can add a new unit."),
                ElevatedButton(
                    onPressed: () {
                      readUnits();
                    },
                    child: const Text('View Reflections')),
                ElevatedButton(
                    onPressed: () {}, child: const Text("Add new unit"))
              ],
            ))));
  }
}
