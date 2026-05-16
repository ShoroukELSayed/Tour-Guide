import 'package:city_tales/core/errors/failures.dart';
import 'package:city_tales/features/places/domain/entities/place_entity.dart';
import 'package:equatable/equatable.dart';

abstract class PlacesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PlacesInitial extends PlacesState {}

class PlacesLoading extends PlacesState {}

class PlacesLoaded extends PlacesState {
  final List<PlaceEntity> places;
  final double lat;
  final double lng;
  PlacesLoaded({required this.places, required this.lat, required this.lng});
}

class PlacesError extends PlacesState {
  final Failure failure;
  PlacesError(this.failure);
  @override
  List<Object?> get props => [failure];
}
