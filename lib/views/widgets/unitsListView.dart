// ignore_for_file: file_names

import 'package:flutter/material.dart';

class UnitsListView extends StatelessWidget {
  const UnitsListView({
    super.key,
    required List units,
  }) : _units = units;

  final List _units;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _units.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.grey,
          key: ValueKey(_units[index]["unitId"]),
          child: Padding(
            padding: const EdgeInsets.only(
                top: 20.0, bottom: 20, left: 16.0, right: 16.0),
            child: ListTile(
              title: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  _units[index]["unitDesc"],
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
              ),
              subtitle: Text(_units[index]["reflections"]),
            ),
          ),
        );
      },
    );
  }
}
