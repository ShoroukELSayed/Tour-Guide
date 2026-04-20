import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    const Color generalIconColor = Color(0xff1A2436);
    const Color visitedPlacesIconColor = Color(0xff122B4A);
    const Color favoriteIconColor = Color(0xffDA6231);
    const Color exportIconColor = Color(0xffBF5317);
    const Color activeSwitchColor = Color(0xff0D4A8D);
    const Color scaffoldBgColor = Color(0xffFDFBF7);

    return Scaffold(
      backgroundColor: scaffoldBgColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Settings / Profile',
          style: TextStyle(
            color: const Color(0xff1A2436),
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/settings_bg.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: double.infinity,
                height: double.infinity,
                color: const Color(0xffFDFBF7),
                child: const Center(
                    child: Icon(Icons.image_outlined,
                        size: 50, color: Colors.grey)),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 150.h),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                children: [
                  _buildSettingItem(
                    Icons.dark_mode_outlined,
                    "Dark Mode",
                    iconColor: generalIconColor,
                    trailing: Switch(
                      value: true,
                      onChanged: (v) {},
                      activeColor: activeSwitchColor,
                    ),
                  ),
                  _buildSettingItem(
                    Icons.notifications_none,
                    "Notifications",
                    iconColor: generalIconColor,
                    trailing: Switch(
                      value: true,
                      onChanged: (v) {},
                      activeColor: activeSwitchColor,
                    ),
                  ),
                  _buildSettingItem(
                    Icons.location_on_outlined,
                    "Visited Places",
                    iconColor: visitedPlacesIconColor,
                    value: "12",
                  ),
                  _buildSettingItem(
                    Icons.favorite_border,
                    "Favorites",
                    iconColor: favoriteIconColor,
                    value: "8",
                  ),
                  _buildSettingItem(
                    Icons.work_outline,
                    "Export My Tour (PDF)",
                    iconColor: exportIconColor,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 120.h,
            left: 30.w,
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: const Offset(0, 5))
                ],
              ),
              child: Image.asset(
                'assets/images/user_icon.png',
                width: 35.w,
                height: 35.h,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.person, size: 35.sp, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(IconData icon, String title,
      {required Color iconColor, String? value, Widget? trailing}) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(icon, color: iconColor),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              color: const Color(0xff1A2436),
            ),
          ),
          trailing: trailing ??
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (value != null)
                    Text(
                      value,
                      style: TextStyle(color: Colors.grey, fontSize: 16.sp),
                    ),
                  Gap(10.w),
                  Icon(Icons.arrow_forward_ios,
                      size: 14.sp, color: Colors.black54),
                ],
              ),
        ),
        const Divider(color: Colors.black12),
      ],
    );
  }
}
