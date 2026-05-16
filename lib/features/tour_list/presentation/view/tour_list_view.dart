import 'package:city_tales/core/constants/app_images.dart';
import 'package:city_tales/features/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:city_tales/features/places/presentation/cubit/places_cubit.dart';
import 'package:city_tales/features/places/presentation/cubit/places_state.dart';
import 'package:city_tales/features/tour_list/presentation/widgets/tour_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class TourListView extends StatelessWidget {
  const TourListView({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryBrown = Color(0xff994F25);

    final favIds = context.watch<FavoriteCubit>().state.toList();

    return Scaffold(
      body: BlocBuilder<PlacesCubit, PlacesState>(
        builder: (context, state) {
          if (state is! PlacesLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          final favoritePlaces = favIds.map((id) {
            return state.places.firstWhere((place) => place.id == id);
          }).toList();

          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.iconsBackground),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back),
                        ),
                        Icon(
                          Icons.person_pin_circle,
                          color: primaryBrown,
                          size: 28.sp,
                        ),
                        Gap(10.w),
                        Text(
                          'My Tour List',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Divider(color: Colors.black12),

                  // 🟢 Reorderable List
                  Expanded(
                    child: ReorderableListView.builder(
                      itemCount: favoritePlaces.length,
                      onReorder: (oldIndex, newIndex) {
                        final favCubit = context.read<FavoriteCubit>();

                        final list = List<String>.from(favCubit.state);

                        if (newIndex > oldIndex) newIndex--;

                        final item = list.removeAt(oldIndex);
                        list.insert(newIndex, item);

                        favCubit.updateOrder(list); // ⭐ لازم يتنادي
                      },
                      itemBuilder: (context, index) {
                        final place = favoritePlaces[index];

                        return TourCard(key: ValueKey(place.id), place: place);
                      },
                    ),
                  ),
                  
                ],
              ),
            ),
          );
        },
      ),
    );
  }

}
