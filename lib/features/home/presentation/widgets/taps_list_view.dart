import 'package:citytales/features/home/presentation/widgets/category_tap.dart';
import 'package:citytales/features/tour/presentation/view/tour_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class TapsListView extends StatelessWidget {
  const TapsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final taps = [
      CategoryTap(
        onTap: () {},
        icon: Icons.map,
        title: 'Explore Map',
        color: const Color.fromARGB(255, 100, 148, 155),
      ),
      CategoryTap(
        onTap: () {},
        icon: Icons.map_outlined,
        title: 'Explore Map',
        color: const Color(0xffBF5317),
      ),
      CategoryTap(
        onTap: () {
          Get.to(() => const TourListView());
        },
        icon: Icons.list_alt_outlined,
        title: 'My Tour List',
        color: const Color(0xffE2911F),
      ),
    ];

    return SizedBox(
      width: 1.sw,
      height: 0.15.sh,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) => taps[index],
        separatorBuilder: (_, index) => Gap(0.03.sw),
        itemCount: taps.length,
      ),
    );
  }
}
