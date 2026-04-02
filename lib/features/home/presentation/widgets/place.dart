import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Place extends StatelessWidget {
  const Place({super.key, required this.image, required this.name});
  final String image;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.40.sw,
      height: 0.25.sh,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.fill),
      ),
      child: Align(
        alignment: AlignmentGeometry.bottomCenter,
        child: Container(
          width: 0.40.sw,
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
            color: Colors.black.withAlpha(190),
          ),
          child: Text(
            textAlign: TextAlign.center,
            name,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
