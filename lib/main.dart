import 'package:citytales/features/splash/presentation/view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const CityTales());
}
class CityTales extends StatelessWidget {
  const CityTales({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: SplashView(),
    ) ;
  }
}