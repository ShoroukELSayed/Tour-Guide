class ApiConstants {
  // Geoapify Configuration
  static const String geoapifyApiKey = '04cf753d89de4531828a68e1b7b60ce9'; // Replace with your key
  
  static const String geoapifyBaseUrl = 'https://api.geoapify.com/v2';
  static const String geoapifyGeocodingUrl = 'https://api.geoapify.com/v1/geocode';
  static const String geoapifyMapTilesUrl = 'https://maps.geoapify.com/v1/tile';
  
  // Heritage categories for Geoapify Places API
  static const List<String> heritageCategories = [
    'heritage',
    'tourism.sights',
    'tourism.attraction',
    'historic',
    'historic.archaeological_site',
    'historic.castle',
    'historic.memorial',
    'historic.monument',
    'historic.ruins',
    'historic.tomb',
    'historic.wayside_cross',
    'historic.wreck',
    'tourism.theme_park',
    'tourism.viewpoint',
    'tourism.zoo',
    'tourism.artwork',
    'tourism.gallery',
    'tourism.museum',
  ];
  
  // Default location (Cairo, Egypt for demo)
  static const double defaultLat = 30.0444;
  static const double defaultLng = 31.2357;
  
  // Search radius in meters
  static const int searchRadius = 5000;
  
  // Limits
  static const int placesLimit = 50;
}