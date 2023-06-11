import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:units_app/models/unit.dart';
import 'package:units_app/services/helper_unit.dart';
import 'package:units_app/services/unit_service.dart';

class UnitsViewPage extends StatefulWidget {
  const UnitsViewPage({super.key});

  @override
  State<UnitsViewPage> createState() => _UnitsViewPageState();
}

class _UnitsViewPageState extends State<UnitsViewPage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(26, 128, 253, 1),
              Color.fromRGBO(98, 58, 162, 1)
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Selector<UnitService, Unit>(
              selector: (context, value) => value.selectedUnit!,
              builder: (context, value, child) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 15.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Text(
                            'Unit View',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * .03),
                        Text(
                          value.unitDesc,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color.fromRGBO(253, 213, 4, 1),
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: screenHeight * .02),
                        SizedBox(
                          height: screenHeight * 0.65,
                          child: SingleChildScrollView(
                            child: Text(
                              value.reflections,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Colors.white,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Close',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextButton(
                          child: const Text(
                            'delete',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          onPressed: () {
                            context.read<UnitService>().deleteUnit(value);
                            saveAllUnitsInUI(context);
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
