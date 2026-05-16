import 'package:city_tales/core/constants/app_images.dart';
import 'package:city_tales/features/home/presentation/widgets/custom_carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.42.sh,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.iconsHomeBackground),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 0.02.sh,
          children: [
            Gap(0.0001.sh),
            Text(
              'CityTales',
              style: TextStyle(
                color: Colors.white,
                fontSize: 45,
                fontWeight: FontWeight.w500,
                fontFamily: 'Lobster Two',
              ),
            ),
            // SearchBar(
            //   leading: Icon(Icons.search),
            //   hintText: 'Search fo places ',
            //   constraints: BoxConstraints(minHeight: 40),
            // ),
            CustomCarouselSlider()
          ],
        ),
      ),
    );
  }
}
