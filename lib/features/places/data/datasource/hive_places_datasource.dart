import 'package:city_tales/core/errors/error_handler.dart';
import 'package:city_tales/core/result/result.dart';
import 'package:city_tales/features/places/data/models/place_model.dart';
import 'package:hive/hive.dart';

class HivePlacesDataSource {
  static const boxName = "placesBox";
  
  String _key(String locationKey) => "places_$locationKey";

  Future<void> cachePlaces(
      String locationKey, List<PlaceModel> places) async {

    final box = await Hive.openBox(boxName);
    // await box.clear();
    await box.put(
      _key(locationKey),
      places.map((e) => e.toJson()).toList(),
    );
  }

  Future<Result<List<PlaceModel>>> getPlaces(String locationKey) async {
  try {
    final box = await Hive.openBox(boxName);
    // await box.clear();

    final data = box.get(_key(locationKey));

    if (data == null) return Result.success([]);

    final places = (data as List)
        .map((e) => PlaceModel.fromJson(
              Map<String, dynamic>.from(e),
            ))
        .toList();

    return Result.success(places);
  } catch (e) {
    return Result.failure(ErrorHandler.handle(e)); 
  }
}
}