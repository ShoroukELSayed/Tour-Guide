import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationDialog {
  static void showLocationDisabled(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Location Disabled"),
        content: const Text(
          "Please enable location service to continue",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              await Geolocator.openLocationSettings(); 
              Navigator.pop(context);
            },
            child: const Text("Open Settings"),
          ),
        ],
      ),
    );
  }

  static void showPermissionDenied(BuildContext context,
      {bool permanentlyDenied = false}) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Permission Required"),
        content: Text(
          permanentlyDenied
              ? "Permission denied forever. Please enable it from settings."
              : "This app needs location permission",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              if (permanentlyDenied) {
                await Geolocator.openAppSettings(); 
              } else {
                await Geolocator.requestPermission(); 
              }
              Navigator.pop(context);
            },
            child: const Text("Allow"),
          ),
        ],
      ),
    );
  }
}