import 'package:city_tales/features/places/domain/entities/place_entity.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final Set<String> _notifiedPlaces = {};

  Future<void> initNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _notificationsPlugin.initialize(settings: initializationSettings);
  }
  Future<void> sendLocationAlert(PlaceEntity place) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'location_alerts',
          'Location Alerts',
          importance: Importance.max,
          priority: Priority.high,
        );

    await _notificationsPlugin.show(
      id: place.id.hashCode,
      title: 'Near ${place.name} ',
      body: 'You are close to ${place.name}. Tap to explore!',
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'location_alerts',
          'Location Alerts',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }

  Future<void> checkProximity(
    Position userPosition,
    List<PlaceEntity> favorites,
  ) async {
    for (var place in favorites) {
      final distance = Geolocator.distanceBetween(
        userPosition.latitude,
        userPosition.longitude,
        place.lat,
        place.lng,
      );

      if (distance < 500 && !_notifiedPlaces.contains(place.id)) {
        _notifiedPlaces.add(place.id);

        await sendLocationAlert(place);
      }
    }
  }
}
