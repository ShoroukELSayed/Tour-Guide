import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryTap extends StatelessWidget {
  const CategoryTap({
    super.key,
    required this.color,
    required this.icon,
    required this.title,
    required this.onTap,
  });
  final Color color;
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.r, horizontal: 12.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: color,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10.r,
              offset: Offset(3.r, 4.r),
            ),
          ],
        ),
        child: Column(
          spacing: 5.r,
          children: [
            Icon(icon, color: Colors.white),
            Text(title, style: TextStyle(color: Colors.white, fontSize: 15.5.sp)),
          ],
        ),
      ),
    );
  }
}
