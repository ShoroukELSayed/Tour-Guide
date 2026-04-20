import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class TourListView extends StatelessWidget {
  const TourListView({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryBrown = Color(0xff994F25);
    const Color accentOrange = Color(0xffDA6231);
    const Color scaffoldBg = Color(0xffF9F8F4);

    return Scaffold(
      backgroundColor: scaffoldBg,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 0.35.sh,
            child: Opacity(
              opacity: 0.6,
              child: Image.asset(
                'assets/images/tour_list_bg.jpg',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const SizedBox(),
              ),
            ),
          ),
          Column(
            children: [
              Gap(0.1.sh),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Icon(Icons.person_pin_circle,
                        color: primaryBrown, size: 28.sp),
                    Gap(10.w),
                    Text(
                      'My Tour List',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.add_circle_outline,
                        color: Colors.grey, size: 28.sp),
                  ],
                ),
              ),
              Gap(10.h),
              const Divider(color: Colors.black12),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _buildTourCard(
                      imagePath: 'assets/images/khan.jpg',
                      name: "Khan El Khalili",
                    ),
                    _buildTourCard(
                      imagePath: 'assets/images/citadel.jpg',
                      name: "Citadel of Saladin",
                    ),
                    _buildTourCard(
                      imagePath: 'assets/images/museum.jpg',
                      name: "Egyptian Museum",
                    ),
                    _buildTourCard(
                      imagePath: 'assets/images/pyramids.jpg',
                      name: "Pyramids Of Giza",
                    ),
                  ],
                ),
              ),
              _buildStartButton(color: accentOrange),
              Gap(20.h),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTourCard({required String imagePath, required String name}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Image.asset(
              imagePath,
              width: 50.w,
              height: 50.h,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 50.w,
                height: 50.h,
                color: Colors.grey[200],
                child: Icon(Icons.image, size: 25.sp, color: Colors.grey),
              ),
            ),
          ),
          Gap(15.w),
          Expanded(
            child: Text(
              name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          Icon(Icons.reorder, color: Colors.grey, size: 22.sp),
        ],
      ),
    );
  }

  Widget _buildStartButton({required Color color}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.change_history, color: Colors.white, size: 30.sp),
          Gap(15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Start Tour',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '3 Stops | Approx. 2 hrs',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18.sp),
        ],
      ),
    );
  }
}
