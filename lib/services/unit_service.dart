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

  // Variable to determine when to call Progress Indicator
  bool _busyRetrieving = false;
  bool _busySaving = false;

  bool get busyRetrieving => _busyRetrieving;
  bool get busySaving => _busySaving;

  // Function get the units from Backendless Database table
  // and extaction the data from the Json to a list
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
        _units = convertMapToUnitList(_unitEntry!.units);
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

  // Function called when saving a the units
 Future<String> saveUnitsEntry(String username, bool inUI) async {
    String result = 'OK';
    if (_unitEntry == null) {
      _unitEntry =
          UnitEntry(units: convertUnitListToMap(_units), username: username);
    } else {
      _unitEntry!.units = convertUnitListToMap(_units);
    }

    if (inUI) {
      _busySaving = true;
      notifyListeners();
    }

    await Backendless.data
        .of('UnitEntry')
        .save(_unitEntry!.toJson())
        .onError((error, stackTrace) {
      result = error.toString();
    });

    if (inUI) {
      _busySaving = false;
      notifyListeners();
    }
    return result;
  }


  // Function Called for when deleting a specified unit
  void deleteUnit(Unit unit) {
    _units.remove(unit);
    notifyListeners();
  }

  // Function Called for when creating a new unit
  void createUnit(Unit unit) {
    _units.insert(0, unit);
    notifyListeners();
  }
}
