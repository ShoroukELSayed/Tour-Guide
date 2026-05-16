import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../../data/models/place_model.dart';
import '../../../data/repositories/place_repository.dart';

class MapViewModel extends ChangeNotifier {
  final PlaceRepository _repository;

  MapViewModel(this._repository);

  List<PlaceModel> _places = [];
  PlaceModel? _selectedPlace;
  Position? _userPosition;

  bool _isLoading = false;
  String? _error;
  bool _isDarkMode = false;

  double _currentLat = 30.0444;
  double _currentLng = 31.2357;

  // getters
  List<PlaceModel> get places => _places;
  PlaceModel? get selectedPlace => _selectedPlace;
  Position? get userPosition => _userPosition;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isDarkMode => _isDarkMode;
  double get currentLat => _currentLat;
  double get currentLng => _currentLng;

  Future<void> initialize() async {
    await _getUserLocation();
    await _loadNearbyPlaces();
  }

  Future<void> _getUserLocation() async {
    try {
      final position = await _repository.getCurrentLocation();

      if (position != null) {
        _userPosition = position;
        _currentLat = position.latitude;
        _currentLng = position.longitude;

        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> _loadNearbyPlaces() async {
    _setLoading(true);

    try {
      _places = await _repository.getNearbyPlaces(
        lat: _currentLat,
        lng: _currentLng,
      );

      _error = null;
    } catch (e) {
      _error = e.toString();
    }

    _setLoading(false);
  }

  Future<void> searchPlaces(String query) async {
    if (query.trim().isEmpty) {
      await _loadNearbyPlaces();
      return;
    }

    _setLoading(true);

    try {
      _places = await _repository.searchPlaces(
        query,
        lat: _currentLat,
        lng: _currentLng,
      );

      _error = null;
      log('Found ${_places.length} places for query "$query"');
    } catch (e) {
      _error = e.toString();
    }

    _setLoading(false);
  }

  void selectPlace(PlaceModel place) {
    _selectedPlace = place;
    notifyListeners();
  }

  void clearSelectedPlace() {
    _selectedPlace = null;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}