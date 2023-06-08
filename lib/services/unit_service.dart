// ignore_for_file: prefer_final_fields, unused_field, body_might_complete_normally_nullable

import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:units_app/models/unit.dart';
import 'package:units_app/models/unit_entry.dart';

class UnitService with ChangeNotifier {
  UnitEntry? _unitEntry;
  List<Unit> _units = [];
  List<Unit> get units => _units;
  void emptyUnits() {
    _units = [];
    notifyListeners();
  }

  bool _busyRetrieving = false;
  bool _busySaving = false;

  bool get busyRetrieving => _busyRetrieving;
  bool get busySaving => _busySaving;

  Future<String> getUnits(String username) async {
    String result = 'OK';
    DataQueryBuilder queryBuilder = DataQueryBuilder()
      ..whereClause = "username = $username";
    _busyRetrieving = true;
    notifyListeners();
    List<Map<dynamic, dynamic>?>? map = await Backendless.data
        .of('UnitEntry')
        .find(queryBuilder)
        .onError((error, stackTrace) {
      result = error.toString();
    });
    if (result != 'OK') {
      _busyRetrieving = false;
      notifyListeners();
      return result;
    }
    if (map != null) {
      if (map.isNotEmpty) {
        _unitEntry = UnitEntry.fromJson(map.first);
        _units = convertMapToTodoList(_unitEntry!.units);
        notifyListeners();
      } else {
        emptyUnits();
      }
    } else {
      result = 'Not OK';
    }
    _busyRetrieving = false;
    notifyListeners();
    return result;
  }

  Future<String> saveUnitsEntry(String username, bool inUI) async {
    String result = 'OK';
    return result;
  }

  void deleteUnit(Unit unit) {
    _units.remove(unit);
    notifyListeners();
  }

  void createUnit(Unit unit) {
    _units.insert(0, unit);
    notifyListeners();
  }
}
