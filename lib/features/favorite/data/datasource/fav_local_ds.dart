import 'package:hive/hive.dart';

class FavLocalDS {
  static const boxName = "favBox";

  Future<void> cache(List<String> ids) async {
    final box = await Hive.openBox(boxName);
    await box.put("fav", ids);
  }

  Future<List<String>> get() async {
    final box = await Hive.openBox(boxName);
    return List<String>.from(box.get("fav") ?? []);
  }
}