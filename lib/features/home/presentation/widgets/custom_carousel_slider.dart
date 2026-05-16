import 'package:carousel_slider/carousel_slider.dart';
import 'package:city_tales/core/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCarouselSlider extends StatelessWidget {
  const CustomCarouselSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        ImageSlider(image: AssetImage(AppImages.iconsPyramids)),
        ImageSlider(image: AssetImage(AppImages.iconsCitadel)),
        ImageSlider(image: AssetImage(AppImages.iconsMuseum)),
        ImageSlider(image: AssetImage(AppImages.iconsCitadelOfSaladin)),
      ],
      options: CarouselOptions(
        height: 160.r,
        
        viewportFraction: 0.6,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        enlargeFactor: 0.4,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}

class ImageSlider extends StatelessWidget {
  const ImageSlider({super.key, required this.image});
  final ImageProvider<Object> image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(image: image, fit: BoxFit.cover),
      ),
    );
  }
}
