
import 'dart:developer';

import 'package:city_tales/core/errors/failures.dart';
import 'package:city_tales/core/result/result.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Result<Position>> getCurrentLocation() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        return Result.failure(
          const LocationServiceFailure("Location service is disabled"),
        );
      }

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) {
        return Result.failure(
          const LocationPermissionFailure("Location permission denied"),
        );
      }

      if (permission == LocationPermission.deniedForever) {
        return Result.failure(
          const LocationPermissionFailure(
            "Location permission denied forever",
            permanentlyDenied: true,
          ),
        );
      }

      final position = await Geolocator.getCurrentPosition();
      final cairoLocation = Position(
        altitudeAccuracy: position.altitudeAccuracy,
        headingAccuracy: position.headingAccuracy,
        latitude: 29.9792,
        longitude: 31.1342,
        timestamp: position.timestamp,
        accuracy: position.accuracy,
        altitude: position.altitude,
        heading: position.heading,
        speed: position.speed,
        speedAccuracy: position.speedAccuracy,
      );
      return Result.success(cairoLocation);
    } catch (e) {
      log("LocationService Error: $e");
      return Result.failure(const UnknownFailure());
    }
  }
}
