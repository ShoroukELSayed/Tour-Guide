import 'package:geolocator/geolocator.dart';

class LocationResult {
  final Position? position;
  final String? error;

  LocationResult.success(this.position) : error = null;
  LocationResult.failure(this.error) : position = null;

  bool get isSuccess => position != null;
}