import 'dart:convert';
import 'dart:developer';
import 'package:city_tales/core/constants/api_keys.dart';
import 'package:city_tales/core/errors/error_handler.dart';
import 'package:city_tales/core/errors/failures.dart';
import 'package:city_tales/core/result/result.dart';
import 'package:http/http.dart' as http;
import '../models/place_model.dart';
import 'package:translator/translator.dart';

final GoogleTranslator translator = GoogleTranslator();

final Map<String, String> _cache = {};

class PlacesApiService {
  final String apiKey = ApiKeys.geoapify;
  Future<String> translateToEnglish(String name) async {
  if (name.isEmpty) return name;

  if (_cache.containsKey(name)) {
    return _cache[name]!;
  }

  final isArabic = RegExp(r'[\u0600-\u06FF]').hasMatch(name);

  if (!isArabic) {
    _cache[name] = name;
    return name;
  }

  try {
    final translated = await translator.translate(name, to: 'en');

    final result = translated.text;

    _cache[name] = result;
    log("Translated $name to $result");
    return result;
  } catch (e) {
    return name;
  }
}

  Future<Result<List<PlaceModel>>> getNearbyPlaces(
    double lat,
    double lon,
    String? category,
  ) async {
    try {
      final selectedCategory = category ??
        "tourism.sights,tourism.attraction";
      final url =
          // "https://api.geoapify.com/v2/places"
          // "?categories=tourism.sights,tourism.attraction"
          // "&filter=circle:$lon,$lat,10000"
          // "&bias=proximity:$lon,$lat"
          // "&limit=40"
          // "&lang=en"
          // "&apiKey=$apiKey";
          "https://api.geoapify.com/v2/places"
        "?categories=$selectedCategory"
        "&filter=circle:$lon,$lat,10000"
        "&bias=proximity:$lon,$lat"
        "&limit=40"
        "&lang=en"
        "&apiKey=$apiKey";

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final features = data['features'] as List;

        final places = await Future.wait(
          features.map((e) async {
            final place = PlaceModel.fromApi(e);

            if (place.name.isEmpty) return place;

            final translatedName = await translateToEnglish(place.name);

            return place.copyWith(name: translatedName);
          }),
        );

        return Result.success(places);
      } else {
        return Result.failure(
          ServerFailure("API Error: ${response.statusCode}"),
        );
      }
    } catch (e) {
      return Result.failure(ErrorHandler.handle(e));
    }
  }
}
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../models/place_model.dart';

// class PlacesApiService {
//   final String apiKey = "AIzaSyDoWvZmagQkAjZYyrPH5P8C2tkP9dAUFDc";

//   Future<List<PlaceModel>> getNearbyPlaces(
//     double lat,
//     double lng,
//   ) async {
//     final url = Uri.parse(
//       "https://places.googleapis.com/v1/places:searchNearby",
//     );

//     final body = jsonEncode({
//       "includedTypes": ["tourist_attraction", "restaurant"],
//       "maxResultCount": 20,
//       "locationRestriction": {
//         "circle": {
//           "center": {
//             "latitude": lat,
//             "longitude": lng,
//           },
//           "radius": 5000.0
//         }
//       }
//     });

//     final response = await http.post(
//       url,
//       headers: {
//         "Content-Type": "application/json",
//         "X-Goog-Api-Key": apiKey,
//         "X-Goog-FieldMask":
//             "places.id,places.displayName,places.location,places.types,places.photos"
//       },
//       body: body,
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       final places = data['places'] as List;

//       return places
//           .map((e) => PlaceModel.fromJson(e))
//           .toList();
//     } else {
//       throw Exception("Google API Error: ${response.body}");
//     }
//   }


//   String getPlaceImage(String photoName) {
//     if (photoName.isEmpty) return "";

//     return "https://places.googleapis.com/v1/$photoName/media?maxHeightPx=400&maxWidthPx=400&key=$apiKey";
//   }
// }
