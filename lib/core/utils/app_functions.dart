import 'package:flutter/material.dart';

class AppFunctions {
  static LinearGradient linearGradient() {
    return LinearGradient(
          colors: [
            Colors.blueAccent,
            Colors.white,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
  }
}