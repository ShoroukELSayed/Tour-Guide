import 'dart:developer';

import 'package:city_tales/core/result/result_extensions.dart';
import 'package:city_tales/features/places/data/repositories/place_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FavoriteCubit extends Cubit<List<String>> {
  final PlaceRepository repo;

  FavoriteCubit({required this.repo}) : super([]);

  final userId = Supabase.instance.client.auth.currentUser?.id;

  Future<void> loadFavorites() async {
    if (userId == null) return;

    final result = await repo.favRemote.getFavorites(userId!);

    await result.UiHelpers(
      success: (ids) async {
        emit(ids);
        await repo.favLocal.cache(ids);
      },
      failure: (_) async {
        final local = await repo.favLocal.get();
        emit(local);
      },
    );
  }

  Future<void> toggle(String placeId, bool isFav) async {
    print("TOGGLE CLICKED");
    if (userId == null) {
      log("User not logged in $userId");
    }

    try {
      await repo.favRemote.toggleFav(userId!, placeId, isFav);

      final updated = List<String>.from(state);

      if (isFav) {
        updated.remove(placeId);
      } else {
        updated.add(placeId);
      }

      emit(updated);

      repo.favLocal.cache(updated.toList());
    } catch (e) {
      log("Error: $e");
      // ❌ هنا ممنوع نكسر UI
    }
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    final list = List<String>.from(state);

    if (newIndex > oldIndex) newIndex--;

    final item = list.removeAt(oldIndex);
    list.insert(newIndex, item);

    // ✅ هنا الحل
    emit(list);

    await repo.favLocal.cache(list);
    await repo.favRemote.saveOrder(userId!, list);
  }

  Future<void> updateOrder(List<String> newOrder) async {
    final userId = Supabase.instance.client.auth.currentUser!.id;

    emit(newOrder); // تحديث UI فورًا

    await repo.favRemote.saveOrder(userId, newOrder);
    await repo.favLocal.cache(newOrder); // حفظ في Hive
  }

  Future<void> remove(String placeId) async {
    final updated = List<String>.from(state);

    updated.remove(placeId);

    emit(updated);

    await repo.favLocal.cache(updated.toList());

    await repo.favRemote.removeFav(userId!, placeId);
  }

  bool isFavorite(String placeId) {
    return state.contains(placeId);
  }
}
