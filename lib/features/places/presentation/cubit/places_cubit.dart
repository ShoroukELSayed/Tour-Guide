import 'dart:developer';
import 'package:city_tales/core/location/location_tracker.dart';
import 'package:city_tales/core/result/result_extensions.dart';
import 'package:city_tales/core/services/notification_service.dart';
import 'package:city_tales/features/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:city_tales/features/places/data/repositories/place_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'places_state.dart';
import '../../../../core/location/location_service.dart';

class PlacesCubit extends Cubit<PlacesState> {
  final PlaceRepository repo;

  final LocationService locationService;
  final LocationTracker locationTracker;
  final NotificationService notificationService;
  final FavoriteCubit favoriteCubit;
  PlacesCubit({
    required this.repo,
    required this.locationService,
    required this.locationTracker,
    required this.notificationService,
    required this.favoriteCubit,
  }) : super(PlacesInitial());
  Position? lastPosition;
  DateTime? lastFetchTime;
  Future<void> fetchNearbyPlaces({
    bool silent = false,
    String? category,
  }) async {
    if (!silent) emit(PlacesLoading());

    final locationResult = await locationService.getCurrentLocation();
    await locationResult.UiHelpers(
      success: (location) async {
        log("Location Result: ${location.latitude}, ${location.longitude}");
        final locationKey =
            "${location.latitude}_${location.longitude}_${category ?? "all"}";
        final result = await repo.getNearbyPlaces(
          locationKey,
          location.latitude,
          location.longitude,
          category: category,
        );

        await result.UiHelpers(
          success: (places) async {
            emit(
              PlacesLoaded(
                places: places,
                lat: location.latitude,
                lng: location.longitude,
              ),
            );
          },
          failure: (error) async {
            log("Error: $error");
            emit(PlacesError(error));
          },
        );
      },
      failure: (error) async {
        log("Error: $error");
        emit(PlacesError(error));
      },
    );
  }

  void startLiveNearbyUpdates() {
    locationTracker.start(
      onChange: (position) async {
        if (lastFetchTime != null &&
            DateTime.now().difference(lastFetchTime!) <
                const Duration(seconds: 10)) {
          return;
        }

        lastFetchTime = DateTime.now();
        if (lastPosition != null) {
          final distance = Geolocator.distanceBetween(
            lastPosition!.latitude,
            lastPosition!.longitude,
            position.latitude,
            position.longitude,
          );

          if (distance < 50) {
            // تجاهل الحركة الصغيرة جدًا
            return;
          }
        }

        lastPosition = position; // 🔥 تحديث آخر موقع

        final result = await repo.getNearbyPlaces(
          "live",
          position.latitude,
          position.longitude,
        );

        await result.UiHelpers(
          success: (places) async {
            emit(
              PlacesLoaded(
                places: places,
                lat: position.latitude,
                lng: position.longitude,
              ),
            );

            final favIds = Set<String>.from(favoriteCubit.state);

            final favPlaces = places
                .where((p) => favIds.contains(p.id))
                .toList();

            await notificationService.checkProximity(position, favPlaces);
          },
          failure: (error) async {
            emit(PlacesError(error));
          },
        );
      },
    );
  }

  void stopLiveUpdates() {
    locationTracker.stop();
  }

  Future<void> retry() async {
    await fetchNearbyPlaces();
  }
}
