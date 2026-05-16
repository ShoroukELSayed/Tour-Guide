import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StartTourButton extends StatelessWidget {
  final Color color;
  final VoidCallback onPressed;

  const StartTourButton({
    super.key,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: Size(double.infinity, 50.h),
        padding: EdgeInsets.all(16.w),
      ),
      child: Row(
        children: const [
          Icon(Icons.change_history, color: Colors.white, size: 30),
          SizedBox(width: 15),
          Expanded(
            child: Text(
              'Start Tour',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: Colors.white),
        ],
      ),
    );
  }
}