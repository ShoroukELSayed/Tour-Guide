import 'dart:developer';

import 'package:city_tales/core/location/location_service.dart';
import 'package:city_tales/core/result/result_extensions.dart';
import 'package:city_tales/features/category/presentation/cubit/Category_state.dart';
import 'package:city_tales/features/places/data/repositories/place_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final PlaceRepository repo;
  final LocationService locationService;

  CategoryCubit({required this.repo, required this.locationService})
    : super(CategoryInitial());

  Future<void> fetchPlaces(String category) async {
    emit(CategoryLoading());

    final locationResult = await locationService.getCurrentLocation();

    await locationResult.UiHelpers(
      success: (location) async {
        final locationKey =
            "${location.latitude}_${location.longitude}_$category";

        final result = await repo.getNearbyPlaces(
          locationKey,
          location.latitude,
          location.longitude,
          category: category,
        );

        await result.UiHelpers(
          success: (places) async {
            log("Places: ${places.length}");
            emit(
              CategoryLoaded(
                places: places,
                lat: location.latitude,
                lng: location.longitude,
              ),
            );
          },
          failure: (error) async {
            emit(CategoryError(error));
          },
        );
      },
      failure: (error) async {
        emit(CategoryError(error));
      },
    );
  }
}
