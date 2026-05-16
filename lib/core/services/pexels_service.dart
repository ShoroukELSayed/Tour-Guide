import 'package:city_tales/core/constants/api_keys.dart';
import 'package:dio/dio.dart';

class PexelsService {
  final Dio dio;

  PexelsService(this.dio);

  Future<String?> getImage(String placeName) async {
    try {
      final res = await dio.get(
        "https://api.pexels.com/v1/search",
        queryParameters: {
          "query": "$placeName landmark",
          "per_page": 1,
        },
        options: Options(
          headers: {
            "Authorization": ApiKeys.pexels,
          },
        ),
      );

      final photos = res.data["photos"];

      if (photos != null && photos.isNotEmpty) {
        return photos[0]["src"]["large"];
      }

      return null;
    } catch (e) {
      return null;
    }
  }
}