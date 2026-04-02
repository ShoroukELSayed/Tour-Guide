import 'package:citytales/core/constants/app_images.dart';
import 'package:citytales/features/home/presentation/widgets/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class NearbyListView extends StatelessWidget {
  const NearbyListView({super.key});

  @override
  Widget build(BuildContext context) {
   final places = [
    Place(
      image: AppImages.imagesPyramitsOfGiza,
      name: 'Pyramits Of Giza',
    ),
    Place(
      image: AppImages.imagesKhanElkhalili,
      name: 'Khan El Khalili',
    ),
    Place(
      image: AppImages.imagesCitadelOfSaladin,
      name: 'Citadel of saladin',
    ),
   ];
    return SizedBox(
      height: 0.25.sh,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: places.length,
          separatorBuilder: (_, index) => Gap(0.02.sw),
          itemBuilder: (_, index) => places[index],
        ),
      ),
    );
  }
}
