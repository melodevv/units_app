import 'package:flutter/material.dart';
import 'package:units_app/services/helper_unit.dart';
import 'package:units_app/views/widgets/form_button.dart';

class UnitCreatePage extends StatefulWidget {
  const UnitCreatePage({super.key});

  @override
  State<UnitCreatePage> createState() => _UnitCreatePageState();
}

class _UnitCreatePageState extends State<UnitCreatePage> {
  // controller for textfields
  late TextEditingController descriptionController = TextEditingController();
  late TextEditingController reflectionController = TextEditingController();

  @override
  initState() {
    super.initState();
    descriptionController = TextEditingController();
    reflectionController = TextEditingController();
  }

  @override
  dispose() {
    descriptionController.dispose();
    reflectionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // THis Container code is for the app background
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
              Color.fromRGBO(26, 128, 253, 1),
              Color.fromRGBO(98, 58, 162, 1)
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    children: [
                      const Text(
                        'Create A Unit Entry',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      TextField(
                        controller: descriptionController,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(253, 213, 4, 1),
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Enter Unit Description',
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ),
                          focusedBorder: InputBorder.none,
                          border: InputBorder.none,
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.66,
                        child: TextField(
                          expands: true,
                          minLines: null,
                          maxLines: null,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                          textAlignVertical: TextAlignVertical.top,
                          controller: reflectionController,
                          decoration: InputDecoration(
                            hintText: 'Start typing here...',
                            hintStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(0),
                              borderSide: const BorderSide(
                                  color: Colors.transparent, width: 1.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  FormButton(
                    text: 'Save',
                    onPressed: () {
                      createNewUnitInUI(
                        context,
                        descriptionController: descriptionController,
                        reflectionController: reflectionController,
                      );
                      saveAllUnitsInUI(context);
                    },
                  ),
                  TextButton(
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      descriptionController.text = '';
                      reflectionController.text = '';
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
