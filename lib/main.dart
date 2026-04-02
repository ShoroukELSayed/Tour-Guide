import 'package:citytales/features/splash/presentation/view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() {
  runApp(const CityTales());
}

class CityTales extends StatelessWidget {
  const CityTales({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(debugShowCheckedModeBanner: false, home: child);
      },
      child: SplashView(),
    );
  }
}
