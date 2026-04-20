part of 'tour_cubit.dart';

@immutable
abstract class TourState {}

// دي الحالة اللي الـ UI بيعتمد عليها
class TourInitial extends TourState {
  final String selectedCategory;
  TourInitial({required this.selectedCategory});
}
