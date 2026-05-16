import 'package:latlong2/latlong.dart';

// lib/core/constants/app_constants.dart

class AppConstants {
  AppConstants._();

  // Default Location (Cairo, Egypt)
  static const LatLng defaultLocation = LatLng(30.0444, 31.2357);
  static const double defaultZoom = 14.0;
  static const double defaultRadius = 5000; // meters

  // Map Styles for Geoapify
  static const String mapStyleOsmBright = 'osm-bright';
  static const String mapStyleDarkMatter = 'dark-matter';
  static const String mapStylePositron = 'positron';
  static const String mapStyleLiberty = 'liberty';

  // Categories with Geoapify type mapping
  static const List<Map<String, dynamic>> placeCategories = [
    {'id': 'all', 'name': 'All', 'icon': 'explore', 'type': 'museum'},
    {'id': 'tourism', 'name': 'Tourist', 'icon': 'tour', 'type': 'museum'},
    {'id': 'historic', 'name': 'Historical', 'icon': 'account_balance', 'type': 'museum'},
    {'id': 'catering', 'name': 'Food', 'icon': 'restaurant', 'type': 'restaurant'},
    {'id': 'commercial', 'name': 'Shopping', 'icon': 'shopping_bag', 'type': 'shop'},
    {'id': 'accommodation', 'name': 'Hotels', 'icon': 'hotel', 'type': 'hotel'},
  ];
}