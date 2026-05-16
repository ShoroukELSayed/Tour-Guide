import 'package:city_tales/core/errors/error_handler.dart';
import 'package:city_tales/core/result/result.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FavRemoteDS {
  final supabase = Supabase.instance.client;

  Future<Result<List<String>>> getFavorites(String userId) async {
    try {
      final res = await supabase
          .from('favorites')
          .select()
          .eq('user_id', userId)
          .order('order_index', ascending: true);

      final ids = (res as List).map((e) => e['place_id'] as String).toList();

      return Result.success(ids);
    } catch (e) {
      return Result.failure(ErrorHandler.handle(e));
    }
  }

 Future<void> saveOrder(String userId, List<String> orderedIds) async {
  for (int i = 0; i < orderedIds.length; i++) {
    await supabase
        .from('favorites')
        .update({'order_index': i})
        .match({
          'user_id': userId,
          'place_id': orderedIds[i],
        });
  }
}

  Future<void> toggleFav(String userId, String placeId, bool isFav) async {
    if (isFav) {
      await removeFav(userId, placeId);
    } else {
      await supabase.from('favorites').insert({
        "user_id": userId,
        "place_id": placeId,
      });
    }
  }

  // ⭐ NEW FUNCTION
  Future<void> removeFav(String userId, String placeId) async {
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
