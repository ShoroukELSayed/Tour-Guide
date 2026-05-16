import 'package:city_tales/core/errors/error_handler.dart';
import 'package:city_tales/core/result/result.dart';
import 'package:city_tales/features/places/data/models/place_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabasePlacesDataSource {
  final supabase = Supabase.instance.client;

  Future<Result<List<PlaceModel>>> getPlaces(String locationKey) async {
    try {
      final res = await supabase
          .from('places')
          .select()
          .eq('location_key', locationKey);

      final data = (res as List).map((e) => PlaceModel.fromJson(e)).toList();

      return Result.success(data);
    } catch (e) {
      return Result.failure(ErrorHandler.handle(e));
    }
  }

  Future<void> insertPlaces(String locationKey, List<PlaceModel> places) async {
    final userId = supabase.auth.currentUser!.id;
    final data = places.map((e) {
      final json = e.toJson();
      json['location_key'] = locationKey;
      json['user_id'] = userId;
      return json;
    }).toList();

    await supabase.from('places').upsert(data);
  }

  Future<void> addToFavorites({
    required String userId,
    required String placeId,
  }) async {
    try {
      await supabase.from('favorites').upsert({
        'user_id': userId,
        'place_id': placeId,
      });
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  Future<void> removeFromFavorites({
    required String userId,
    required String placeId,
  }) async {
    try {
      await supabase.from('favorites').delete().match({
        'user_id': userId,
        'place_id': placeId,
      });
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
}
