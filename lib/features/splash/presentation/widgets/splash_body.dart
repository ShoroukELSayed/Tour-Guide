import 'package:animate_do/animate_do.dart';
import 'package:city_tales/core/constants/app_images.dart';
import 'package:city_tales/features/auth/presentation/pages/login_page.dart';
import 'package:city_tales/features/splash/helpers/app_functions.dart';

import 'package:flutter/material.dart';

class SplashBody extends StatelessWidget {
  const SplashBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(gradient: AppFunctions.linearGradient()),
        child: ZoomIn(
          duration: const Duration(seconds: 3),
          onFinish: (direction) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => LoginPage()),
          ),
          child: Center(child: Image.asset(AppImages.iconsLogo)),
        ),
      ),
    );
  }
}
