import 'dart:developer';
import 'package:city_tales/features/home/presentation/widgets/place_item.dart';
import 'package:city_tales/features/places/presentation/cubit/places_cubit.dart';
import 'package:city_tales/features/places/presentation/cubit/places_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class NearbyListView extends StatelessWidget {
  const NearbyListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.25.sh,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<PlacesCubit, PlacesState>(
          builder: (context, state) {
            if (state is PlacesLoading) {
              log("Loading nearby places...$state");
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is PlacesLoaded) {
              log("Nearby places loaded: ${state.places.length}");
              final places = state.places.take(10).toList();

              return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: places.length,
                separatorBuilder: (_, _) => Gap(0.02.sw),
                itemBuilder: (_, index) {
                  final place = places[index];

                  return PlaceItem(
                    place: place,
                  );
                },
              );
            }

            return const Center(child: Text("No places found"));
          },
        ),
      ),
    );
  }
}