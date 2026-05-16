import 'package:city_tales/core/errors/failures.dart';
import 'package:flutter/material.dart';

class SnackBarHelper {
  static void show(BuildContext context, Failure failure) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(failure.message),
        backgroundColor: Colors.red,
      ),
    );
  }
}