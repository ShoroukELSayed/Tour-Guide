import 'package:flutter/material.dart';

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
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: color,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(3, 4),
            ),
          ],
        ),
        child: Column(
          spacing: 5,
          children: [
            Icon(icon, color: Colors.white),
            Text(title, style: TextStyle(color: Colors.white, fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
