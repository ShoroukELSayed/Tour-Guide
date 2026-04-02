import 'package:citytales/core/constants/app_images.dart';
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
          image: AssetImage(AppImages.imagesHomeBackground),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 0.06.sh,
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
            SearchBar(
              leading: Icon(Icons.search),
              hintText: 'Search fo places ',
              constraints: BoxConstraints(minHeight: 40),
            ),
          ],
        ),
      ),
    );
  }
}
