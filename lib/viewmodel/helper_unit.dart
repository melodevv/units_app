// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:units_app/models/unit.dart';
import 'package:units_app/services/unit_service.dart';
import 'package:units_app/services/user_service.dart';
import 'package:units_app/views/widgets/dialogs.dart';

// Function for the refreashing units in the ui
void refreshUnitsInUI(BuildContext context) async {
  // Get the and store the result of the getUnits function
  String result = await context
      .read<UnitService>()
      .getUnits(context.read<UserService>().currentUser!.email);

  // verify the result gotten from the getUnits function
  if (result != 'OK') {
    showSnackBar(context, result);
  } else {
    showSnackBar(context, 'Data succefully retrieved from the database');
  }
}

// Function for the saving the units in the ui
void saveAllUnitsInUI(BuildContext context) async {
  // Get the and store the result of the saveUnitEntry function
  String result = await context
      .read<UnitService>()
      .saveUnitEntry(context.read<UserService>().currentUser!.email, true);

  // verify the result gotten from the saveUnitEntry function
  if (result != 'OK') {
    showSnackBar(context, result);
  } else {
    showSnackBar(context, 'Unit successfully saved!');
  }
}

// Function for creating new unit entry in the ui
void createNewUnitInUI(BuildContext context,
    {required TextEditingController descriptionController,
    required TextEditingController reflectionController}) async {
  if (descriptionController.text.isEmpty || reflectionController.text.isEmpty) {
    showSnackBar(context, 'All fields should be filled');
  } else {
    // Create new Unit Entry
    Unit unit = Unit(
      unitDesc: descriptionController.text.trim(),
      reflections: reflectionController.text.trim(),
    );

    // This code is to prevent having duplicate values
    if (context.read<UnitService>().units.contains(unit)) {
      showSnackBar(context, 'Duplicate value. Please try again');
    } else {
      context.read<UnitService>().createUnit(unit);
      descriptionController.text = '';
      reflectionController.text = '';
      Navigator.pop(context);
    }
  }
}
