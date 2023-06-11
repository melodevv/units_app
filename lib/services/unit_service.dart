// ignore_for_file: prefer_final_fields, unused_field, body_might_complete_normally_nullable, prefer_is_empty

import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:units_app/models/unit.dart';
import 'package:units_app/models/unit_entry.dart';

class UnitService with ChangeNotifier {
  // Variables to store units
  UnitEntry? _unitEntry;

  List<Unit> _units = [];
  List<Unit> get units => _units;

  // Function to reset the units List
  void emptyUnits() {
    _units = [];
    notifyListeners();
  }

  // Variable to determine when to call Progress Indicator
  bool _busyRetrieving = false;
  bool _busySaving = false;

  bool get busyRetrieving => _busyRetrieving;
  bool get busySaving => _busySaving;

  // Variable to store the selectedUnit
  Unit? _selectedUnit;
  Unit? get selectedUnit => _selectedUnit;
  set selectedUnit(Unit? unit) {
    _selectedUnit = unit;
    notifyListeners();
  }

  // Function get the units from Backendless Database table
  // and extracts the data from the Json to a list
  Future<String> getUnits(String username) async {
    String result = 'OK';

    // Get the units from Backendless for the user logged in
    DataQueryBuilder queryBuilder = DataQueryBuilder()
      ..whereClause = "username = '$username'";

    // Start the progress indicator
    _busyRetrieving = true;
    notifyListeners();

    // Get the units table colum data for the logged in user
    List<Map<dynamic, dynamic>?>? map = await Backendless.data
        .of('UnitEntry')
        .find(queryBuilder)
        .onError((error, stackTrace) {
      result = error.toString();
    });

    // Check if ther was any error in the retrieving of the
    // users units
    if (result != 'OK') {
      // Stop the progress indicator
      _busyRetrieving = false;
      notifyListeners();
      return result;
    }

    if (map != null) {
      // Convert the map of units to a list
      if (map.length > 0) {
        _unitEntry = UnitEntry.fromJson(map.first);
        _units = convertMapToUnitList(_unitEntry!.units);
        notifyListeners();
      } else {
        emptyUnits();
      }
    } else {
      result = 'NOT OK';
    }

    // Stop the progress indicator
    _busyRetrieving = false;
    notifyListeners();

    return result;
  }

  // Function called when saving the units
  Future<String> saveUnitEntry(String username, bool inUI) async {
    String result = 'OK';

    // Check fo null on _unitEntry variable
    if (_unitEntry == null) {
      _unitEntry =
          UnitEntry(units: convertUnitListToMap(_units), username: username);
    } else {
      _unitEntry!.units = convertUnitListToMap(_units);
    }

    // Check if the unit save was triggered in the UI
    // start the app progress indicator
    if (inUI) {
      _busySaving = true;
      notifyListeners();
    }

    // Save the units map to Backendless current user units column
    await Backendless.data
        .of('UnitEntry')
        .save(_unitEntry!.toJson())
        .onError((error, stackTrace) {
      result = error.toString();
    });

    // Check if the unit save was triggered in the UI
    // stop the app progress indicator
    if (inUI) {
      _busySaving = false;
      notifyListeners();
    }

    return result;
  }

  // Function Called for when creating a new unit
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
