import 'package:city_tales/features/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:city_tales/features/places/domain/entities/place_entity.dart';
import 'package:city_tales/features/places/presentation/pages/details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class TourCard extends StatelessWidget {
  final PlaceEntity place;

  const TourCard({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DetailsPage(place: place)),
        );
      },
      child: Container(
        key: key,
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Row(
          children: [
            Image.network(
              place.image,
              width: 50.w,
              height: 50.h,
              fit: BoxFit.cover,
            ),

            Gap(15.w),

            Expanded(child: Text(place.name, overflow: TextOverflow.ellipsis)),

            // 🗑️ delete icon
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                context.read<FavoriteCubit>().remove(place.id);
              },
            ),

            // drag handle
            const Icon(Icons.drag_handle, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
