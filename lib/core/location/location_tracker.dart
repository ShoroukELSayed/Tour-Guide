// import 'dart:async';
// import 'package:geolocator/geolocator.dart';

// class LocationTracker {
//   StreamSubscription<Position>? _subscription;

//   void start({
//     required Function(Position position) onChange,
//     int distanceFilter = 50,
//   }) {
//     const settings = LocationSettings(
//       accuracy: LocationAccuracy.high,
//       distanceFilter: 50,
//     );

//     _subscription =
//         Geolocator.getPositionStream(locationSettings: settings)
//             .listen((position) {
//       onChange(position);
//     });
//   }

//   void stop() {
//     _subscription?.cancel();
//   }
// }
import 'dart:async';

import 'package:geolocator/geolocator.dart';

class LocationTracker {
  StreamSubscription? _subscription;

  void start({
    required Function(Position position) onChange,
  }) {
    _subscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 50, 
      ),
    ).listen((Position position) {
      onChange(position);
    });
  }

  void stop() {
    _subscription?.cancel();
    _subscription = null;
  }
}