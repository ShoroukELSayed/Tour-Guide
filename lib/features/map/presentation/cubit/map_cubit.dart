import 'package:city_tales/features/places/domain/entities/place_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MapCubit extends Cubit<PlaceEntity?> {
  MapCubit() : super(null);

  void selectPlace(PlaceEntity place) {
    emit(place);
  }

  void clearSelection() {
    emit(null);
  }
}
