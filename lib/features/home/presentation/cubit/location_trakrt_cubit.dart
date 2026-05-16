import 'package:city_tales/core/location/location_tracker.dart';
import 'package:city_tales/core/result/result_extensions.dart';
import 'package:city_tales/features/places/data/repositories/place_repository.dart';
import 'package:city_tales/features/places/presentation/cubit/places_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationTrackingCubit extends Cubit<PlacesState> {
  final LocationTracker tracker;
  final PlaceRepository repo;

  LocationTrackingCubit(this.tracker, this.repo) : super(PlacesInitial());

  void start() {
    tracker.start(
      onChange: (pos) async {
        final result = await repo.getNearbyPlaces(
          "${pos.latitude}_${pos.longitude}",
          pos.latitude,
          pos.longitude,
        );

        await result.UiHelpers(
          success: (places) async {
            emit(
              PlacesLoaded(
                places: places,
                lat: pos.latitude,
                lng: pos.longitude,
              ),
            );
          },
          failure: (e) async => emit(PlacesError(e)),
        );
      },
    );
  }

  void stop() => tracker.stop();
}
