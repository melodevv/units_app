// ignore_for_file: unused_field, prefer_const_constructors, unnecessary_null_comparison
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart' as provider;
import 'package:tuple/tuple.dart';
import 'package:units_app/services/helper_unit.dart';
import 'package:units_app/services/helper_user.dart';
import 'package:units_app/services/user_service.dart';
import 'package:units_app/views/widgets/app_progress_indicator.dart';
import 'package:units_app/views/widgets/dialogs.dart';

import 'package:units_app/views/widgets/unitsListView.dart';

class UnitPage extends StatefulWidget {
  const UnitPage({super.key});

  @override
  State<UnitPage> createState() => _UnitPageState();
}

class _UnitPageState extends State<UnitPage> {
  final _units = [];

  String name = '';
  late TextEditingController unitController = TextEditingController();
  late TextEditingController reflectionController = TextEditingController();

  @override
  initState() {
    super.initState();
    unitController = TextEditingController();
    reflectionController = TextEditingController();
  }

  @override
  dispose() {
    unitController.dispose();
    reflectionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(26, 128, 253, 1),
              Color.fromRGBO(98, 58, 162, 1)
            ],
          ),
        ),
        child: Stack(
          children: [
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: screenWidth - 25,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          nav_buttons(
                            icon: Icon(Icons.refresh_rounded),
                            iconSize: 30,
                            onPressed: () {
                              refreshUnitsUI(context);
                            },
                            // unitController: unitController,
                            // reflectionController: reflectionController,
                          ),
                          // This button creates a new unit reflection,
                          // you need to first enter the unit description,
                          // press next when done, then enter the reflection,
                          // and then save the unit
                          nav_buttons(
                            icon: Icon(Icons.add_rounded),
                            iconSize: 30,
                            onPressed: () {},
                            // unitController: unitController,
                            // reflectionController: reflectionController,
                          ),
                          nav_buttons(
                            icon: Icon(Icons.save_rounded),
                            iconSize: 30,
                            onPressed: () {
                              saveAllUnitsUI(context);
                            },
                          ),
                          nav_buttons(
                            icon: Icon(Icons.exit_to_app_rounded),
                            iconSize: 30,
                            onPressed: () {
                              logoutUserInUI(context);
                              showSnackBar(context, "Logout successful!");
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SvgPicture.asset('assets/images/homepage.svg'),
                  provider.Selector<UserService, BackendlessUser?>(
                    selector: (context, value) => value.currentUser,
                    builder: (context, value, child) {
                      name = value!.getProperty('name');
                      return value == null
                          ? Container()
                          : Text(
                              '${value.getProperty('name')}\'s Units'
                                  .toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 45,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                    },
                  ),
                  _units.isNotEmpty
                      ? Expanded(
                          // This UnitsListView displays the units reflections created by the user,
                          // allowing them to delete, and toggle them
                          child: UnitsListView(units: _units),
                        )
                      : Container(),
                ],
              ),
            ),
            provider.Selector<UserService, Tuple2>(
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
      ),
    );
  }
}

class nav_buttons extends StatelessWidget {
  const nav_buttons({
    super.key,
    required this.icon,
    required this.iconSize,
    required this.onPressed,
  });

  final Icon icon;
  final double iconSize;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: Colors.white,
      icon: icon,
      iconSize: iconSize,
      onPressed: onPressed,
    );
  }
}
