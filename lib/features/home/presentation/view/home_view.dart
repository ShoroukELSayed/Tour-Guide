import 'package:citytales/core/constants/app_images.dart';
import 'package:citytales/features/home/presentation/widgets/home_app_bar.dart';
import 'package:citytales/features/home/presentation/widgets/nearby_list_view.dart';
import 'package:citytales/features/home/presentation/widgets/taps_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(AppImages.imagesBackground),
            fit: BoxFit.fill
            )
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  HomeAppBar(),
                  Gap(0.07.sh),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Text('Nearby Places.', style: TextStyle(fontSize: 20)),
                        Expanded(child: Divider(thickness: 2)),
                      ],
                    ),
                  ),
                  Gap(0.02.sh),
                  NearbyListView(),
                ],
              ),
              Positioned(
                top: 0.35.sh,
                left: 0.064.sw,
                child: TapsListView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
