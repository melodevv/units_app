// ignore_for_file: unused_field, prefer_const_constructors, unnecessary_null_comparison
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart' as provider;
import 'package:tuple/tuple.dart';
import 'package:units_app/routes/routes.dart';
import 'package:units_app/viewmodel/helper_unit.dart';
import 'package:units_app/viewmodel/helper_user.dart';
import 'package:units_app/services/unit_service.dart';
import 'package:units_app/services/user_service.dart';
import 'package:units_app/views/widgets/app_progress_indicator.dart';
import 'package:units_app/views/widgets/nav_button.dart';
import 'package:units_app/views/widgets/unit_card.dart';

class UnitReflectionsPage extends StatefulWidget {
  const UnitReflectionsPage({super.key});

  @override
  State<UnitReflectionsPage> createState() => _UnitReflectionsPageState();
}

class _UnitReflectionsPageState extends State<UnitReflectionsPage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // THis Container code is for the app background
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25.0, vertical: 15.0),
                    child: Container(
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
                          NavButtons(
                            icon: Icon(Icons.refresh_rounded),
                            iconSize: 30,
                            onPressed: () {
                              refreshUnitsInUI(context);
                            },
                          ),
                          NavButtons(
                            icon: Icon(Icons.add_rounded),
                            iconSize: 30,
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(RouteManager.unitCreate);
                            },
                          ),
                          NavButtons(
                            icon: Icon(Icons.exit_to_app_rounded),
                            iconSize: 30,
                            onPressed: () {
                              logoutUserInUI(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SvgPicture.asset('assets/images/homepage.svg'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: provider.Selector<UserService, BackendlessUser?>(
                      selector: (context, value) => value.currentUser,
                      builder: (context, value, child) {
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
                  ),
                  SizedBox(height: screenHeight * .02),
                  Expanded(
                    child: provider.Consumer<UnitService>(
                      builder: (context, value, child) {
                        return ListView.builder(
                          itemCount: value.units.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.fromLTRB(25, 0, 25, 15),
                              child: UnitCard(
                                unit: value.units[index],
                                onTap: () {
                                  context.read<UnitService>().selectedUnit =
                                      value.units[index];
                                  Navigator.of(context)
                                      .pushNamed(RouteManager.unitViewPage);
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
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
            provider.Selector<UnitService, Tuple2>(
              selector: (context, value) =>
                  Tuple2(value.busyRetrieving, value.busySaving),
              builder: (context, value, child) {
                return value.item1
                    ? AppProgressIndicator(
                        text:
                            'Busy Retrieving data from the database...please wait')
                    : value.item2
                        ? AppProgressIndicator(
                            text:
                                'Busy saving data to the database...please wait')
                        : Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
