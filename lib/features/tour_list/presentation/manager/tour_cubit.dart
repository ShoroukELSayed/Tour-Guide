import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tour_state.dart';

class TourCubit extends Cubit<TourState> {
  // بنبدأ بحالة TourInitial وبنبعت لها القيمة الافتراضية
  TourCubit() : super(TourInitial(selectedCategory: "Historical"));

  void changeCategory(String categoryName) {
    emit(TourInitial(selectedCategory: categoryName));
  }
}
