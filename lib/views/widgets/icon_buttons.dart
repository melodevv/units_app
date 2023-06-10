import 'package:flutter/material.dart';
import 'package:units_app/services/helper_unit.dart';

class IconButtons extends StatelessWidget {
  const IconButtons({
    super.key,
    required this.unitController,
    required this.reflectionController,
  });

  final TextEditingController unitController;
  final TextEditingController reflectionController;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.add),
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                title: const Text("Add new Unit"),
                content: TextField(
                  decoration: const InputDecoration(
                      hintText: "Please enter unit description"),
                  controller: unitController,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            title: const Text("Add new Unit"),
                            content: TextField(
                              decoration: const InputDecoration(
                                  hintText: "Please enter unit reflection"),
                              controller: reflectionController,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('back'),
                              ),
                              TextButton(
                                onPressed: () {
                                  createNewUnitInUI(
                                    context,
                                    descriptionController: unitController,
                                    reflectionController: reflectionController,
                                  );
                                },
                                child: const Text(
                                  'Save',
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('next'),
                  ),
                ],
              );
            });
      },
    );
  }
}
