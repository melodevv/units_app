// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:units_app/models/unit.dart';
import 'package:units_app/services/unit_service.dart';
import 'package:units_app/services/user_service.dart';
import 'package:units_app/views/widgets/dialogs.dart';

void refreshUnitsUI(BuildContext context) async {
  String result = await context
      .read<UnitService>()
      .getUnits(context.read<UserService>().currentUser!.email);
  if (result != 'OK') {
    showSnackBar(context, result);
  } else {
    showSnackBar(context, 'Data succefully retrieved from the database');
  }
}

void saveAllUnitsUI(BuildContext context) async {
  String result = await context
      .read<UnitService>()
      .saveUnitsEntry(context.read<UserService>().currentUser!.email, true);
  if (result != 'OK') {
    showSnackBar(context, result);
  } else {
    showSnackBar(context, 'Unit successfully saved!');
  }
}

void createUnitsInUI(
  BuildContext context, {
  required TextEditingController descriptionController,
  required TextEditingController reflectionController,
}) async {
  if (descriptionController.text.isEmpty) {
    showSnackBar(context, 'Enter units description');
  } else {
    Unit unit = Unit(
      unitDesc: descriptionController.text.trim(),
      reflections: reflectionController.text.trim(),
      //created: DateTime.now(),
    );
    if (context.read<UnitService>().units.contains(unit)) {
      showSnackBar(context, 'Duplicate value. Please try again');
    } else {
      descriptionController.text = '';
      context.read<UnitService>().createUnit(unit);
      Navigator.pop(context);
    }
  }
}
