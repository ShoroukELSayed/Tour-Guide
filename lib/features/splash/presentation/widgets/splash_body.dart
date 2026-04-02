import 'package:animate_do/animate_do.dart';
import 'package:citytales/core/constants/app_images.dart';
import 'package:citytales/core/utils/app_functions.dart';
import 'package:citytales/features/home/presentation/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashBody extends StatelessWidget {
  const SplashBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: AppFunctions.linearGradient(),
        ),
        child: ZoomIn(
          duration: 3.seconds,
          onFinish: (direction) => Get.to(() => HomeView()),
          child: Center(child: Image.asset(AppImages.imagesLogo)),
        ),
      ),
    );
  }

  
}
