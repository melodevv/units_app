import 'package:flutter/material.dart';
import 'package:units_app/models/unit.dart';

class UnitCard extends StatelessWidget {
  const UnitCard({
    Key? key,
    required this.unit,
    required this.onTap,
  }) : super(key: key);

  final Unit unit;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      // color: const Color.fromRGBO(26, 128, 253, 1),
      color: Colors.transparent,
      elevation: 0.0,
      shadowColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        side: BorderSide(
          width: 1.0,
          color: Colors.white,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10.0),
        onTap: onTap,
        title: Text(
          unit.unitDesc,
          style: const TextStyle(
            color: Color.fromRGBO(253, 213, 4, 1),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: const Icon(
          Icons.navigate_next,
          color: Colors.white,
        ),
      ),
    );
  }
}
