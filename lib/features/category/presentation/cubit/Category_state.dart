import 'package:city_tales/core/errors/failures.dart';
import 'package:city_tales/features/places/domain/entities/place_entity.dart';
import 'package:equatable/equatable.dart';

abstract class CategoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<PlaceEntity> places;
  final double lat;
  final double lng;
  CategoryLoaded({required this.places, required this.lat, required this.lng});
}

class CategoryError extends CategoryState {
  final Failure failure;
  CategoryError(this.failure);
  @override
  List<Object?> get props => [failure];
}
