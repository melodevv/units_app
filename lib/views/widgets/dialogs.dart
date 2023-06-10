import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    duration: const Duration(milliseconds: 3500),
    elevation: 10,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(5),
      topRight: Radius.circular(5),
    )),
    backgroundColor: const Color.fromRGBO(253, 213, 4, 1),
    content: Text(
      message,
      style: const TextStyle(
        fontSize: 16,
        color: Color.fromRGBO(38, 38, 38, 1),
      ),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
