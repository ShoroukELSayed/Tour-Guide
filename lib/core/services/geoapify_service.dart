import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants/api_constants.dart';
import '../../data/models/place_model.dart';

class GeoapifyService {
  final http.Client _client;

  GeoapifyService({http.Client? client}) : _client = client ?? http.Client();

  /// Search nearby places
  Future<List<PlaceModel>> searchNearbyPlaces({
    required double lat,
    required double lng,
    int radius = ApiConstants.searchRadius,
    List<String>? categories,
    int limit = ApiConstants.placesLimit,
  }) async {
    try {
      final categoryString =
          (categories ?? ApiConstants.heritageCategories).join(',');

      final url = Uri.parse(
        '${ApiConstants.geoapifyBaseUrl}/places?'
        'categories=${Uri.encodeComponent(categoryString)}'
        '&filter=circle:$lng,$lat,$radius'
        '&bias=proximity:$lng,$lat'
        '&limit=20'
        '&apiKey=${ApiConstants.geoapifyApiKey}',
      );
// https://api.geoapify.com/v2/places?categories=commercial&filter=place:51607209473f7d52c059d36425f14d644440f00101f9012c25800000000000c002089203094d616e68617474616e&limit=20&apiKey=YOUR_API_KEY

      final response = await _client.get(url);

      if (response.statusCode != 200) {
        throw Exception('Failed to load places: ${response.statusCode}');
      }

      final data = jsonDecode(response.body);

      final List features = data['features'] ?? [];

      return features.map((e) => PlaceModel.fromGeoapify(e)).toList();
    } catch (e) {
      throw Exception('searchNearbyPlaces error: $e');
    }
  }

  /// Get place details
  Future<PlaceModel> getPlaceDetails(String placeId) async {
    try {
      final url = Uri.parse(
        'https://api.geoapify.com/v2/place-details?id=$placeId'
        '&apiKey=${ApiConstants.geoapifyApiKey}',
      );

      final response = await _client.get(url);

      if (response.statusCode != 200) {
        throw Exception('Failed to load place details');
      }

      final data = jsonDecode(response.body);

      final features = data['features'] ?? [];

      if (features.isEmpty) {
        throw Exception('No place found');
      }

      return PlaceModel.fromGeoapify(features[0]);
    } catch (e) {
      throw Exception('getPlaceDetails error: $e');
    }
  }

  /// Reverse geocoding
  Future<String> getAddressFromCoordinates(double lat, double lng) async {
    try {
      final url = Uri.parse(
        '${ApiConstants.geoapifyGeocodingUrl}/reverse?'
        'lat=$lat&lon=$lng'
        '&apiKey=${ApiConstants.geoapifyApiKey}',
      );

      final response = await _client.get(url);

      if (response.statusCode != 200) return 'Unknown location';

      final data = jsonDecode(response.body);

      final results = data['results'] as List? ?? [];

      if (results.isEmpty) return 'Unknown location';

      return results.first['formatted'] ?? 'Unknown location';
    } catch (_) {
      return 'Unknown location';
    }
  }

  /// Search by text
  Future<List<PlaceModel>> searchByText(
  String text, {
  double? biasLat,
  double? biasLng,
}) async {
  try {
    final url = Uri.parse(
      '${ApiConstants.geoapifyBaseUrl}/places?'
      'text=${Uri.encodeComponent(text)}'
      '&apiKey=${ApiConstants.geoapifyApiKey}',
    );

    final response = await _client.get(url);

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    final data = jsonDecode(response.body);
    final List features = data['features'] ?? [];

    return features.map((e) => PlaceModel.fromGeoapify(e)).toList();
  } catch (e) {
    throw Exception('searchByText error: $e');
  }
}

  /// Map tiles
  String getMapTileUrl(String style) {
    return 'https://maps.geoapify.com/v1/tile/$style/{z}/{x}/{y}.png'
        '?apiKey=${ApiConstants.geoapifyApiKey}';
  }

  static const String mapStyleOsmBright = 'osm-bright';
  static const String mapStyleDarkMatter = 'dark-matter';
  static const String mapStylePositron = 'positron';
  static const String mapStyleLiberty = 'liberty';
}
