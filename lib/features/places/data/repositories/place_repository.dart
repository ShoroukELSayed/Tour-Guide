import 'dart:developer';

import 'package:city_tales/core/errors/error_handler.dart';
import 'package:city_tales/core/network/network_info.dart';
import 'package:city_tales/core/result/result.dart';
import 'package:city_tales/core/result/result_extensions.dart';
import 'package:city_tales/core/services/pexels_service.dart';
import 'package:city_tales/features/favorite/data/datasource/fav_local_ds.dart';
import 'package:city_tales/features/favorite/data/datasource/fav_remote_ds.dart';
import 'package:city_tales/features/places/data/datasource/hive_places_datasource.dart';
import 'package:city_tales/features/places/data/datasource/supabase_places_datasource.dart';
import 'package:city_tales/features/places/data/models/place_model.dart';
import 'package:city_tales/features/places/data/services/places_api_service.dart';

class PlaceRepository {
  final PlacesApiService api;
  final SupabasePlacesDataSource supabase;
  final HivePlacesDataSource hive;
  final FavRemoteDS favRemote;
  final FavLocalDS favLocal;
  final NetworkInfo network;
  final PexelsService pexels;

  PlaceRepository({
    required this.api,
    required this.supabase,
    required this.hive,
    required this.favRemote,
    required this.favLocal,
    required this.network,
    required this.pexels,
  });

  Future<Result<List<PlaceModel>>> getNearbyPlaces(
    String locationKey,
    double lat,
    double lon, {
    String? category,
  }) async {
    try {
      final remote = await supabase.getPlaces(locationKey);
      if (remote.isSuccess && remote.data!.isNotEmpty) {
        return remote;
      }

      final local = await hive.getPlaces(locationKey);
      if (local.isSuccess && local.data!.isNotEmpty) {
        await supabase.insertPlaces(locationKey, local.data!);
        return local;
      }

      final Result<List<PlaceModel>> apiResult = await api.getNearbyPlaces(
        lat,
        lon,
        category,
      );
      return await apiResult.UiHelpers(
        success: (models) async {
          final updatedModels = await Future.wait(
            models.map((e) async {
              if (e.image.isNotEmpty) {
                return e;
              }
              final query = "${e.name} ${e.category} Egypt";
              final image = await pexels.getImage(query);
              return e.copyWith(image: image, isFavorite: false);
            }),
          );

          await hive.cachePlaces(locationKey, updatedModels);
          await supabase.insertPlaces(locationKey, updatedModels);

          return Result.success(updatedModels);
        },
        failure: (error) async {
          return Result.failure(error);
        },
      );
    } catch (e) {
      return Result.failure(ErrorHandler.handle(e));
    }
  }

  Future<void> ensurePlaceExists(PlaceModel place) async {
    await supabase.insertPlaces("single", [place]);
  }

  Future<void> addToFavorites(String userId, String placeId) async {
    await supabase.addToFavorites(userId: userId, placeId: placeId);
  }

  Future<void> toggleFavorite(String userId, String placeId, bool isFav) async {
    if (await network.isConnected) {
      await favRemote.toggleFav(userId, placeId, isFav);
      log("✅ Saved to Supabase");
      final updated = await favRemote.getFavorites(userId);

      if (updated.isSuccess) {
        await favLocal.cache(updated.data!);
      }
    } else {
      final local = await favLocal.get();
      log("✅ Saved to Local Storage");
      if (local.contains(placeId)) {
        local.remove(placeId);
      } else {
        local.add(placeId);
      }

      await favLocal.cache(local);
      log("✅ Updated Local Cache");
    }
  }
}
