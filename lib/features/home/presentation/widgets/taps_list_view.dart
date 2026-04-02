import 'package:citytales/features/home/presentation/widgets/category_tap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class TapsListView extends StatelessWidget {
  const TapsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final taps = [
      CategoryTap(
        onTap: () {},
        icon: Icons.map,
        title: 'Explore Map',
        color: Color.fromARGB(255, 100, 148, 155),
      ),
      CategoryTap(
        onTap: () {},
        icon: Icons.map,
        title: 'Explore Map',
        color: Color(0xffBF5317),
      ),
      CategoryTap(
        onTap: () {},
        icon: Icons.list_alt_outlined,
        title: 'My Tour List',
        color: Color(0xffE2911F),
      ),
    ];
    return SizedBox(
     width: 1.sw,
     height: 0.15.sh,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) => taps[index],
        separatorBuilder: (_, index) => Gap(0.03.sw),
        itemCount: taps.length,
      ),
    );
  }
}
