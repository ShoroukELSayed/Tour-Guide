import 'package:flutter/material.dart';

class AppColors {
  // Primary Palette (from logo)
  static const Color primary = Color(0xFF1B4D72);      // Deep Blue
  static const Color secondary = Color(0xFFF4B942);      // Golden Yellow
  static const Color accent = Color(0xFFE86A33);       // Orange/Red Pin
  
  // Backgrounds
  static const Color background = Color(0xFFF5F0E8);   // Parchment/Beige
  static const Color darkBackground = Color(0xFF1A1A2E);
  static const Color cardBackground = Color(0xFFFAF6F0);
  static const Color darkCardBackground = Color(0xFF16213E);
  
  // Text
  static const Color textPrimary = Color(0xFF2C3E50);
  static const Color textSecondary = Color(0xFF7F8C8D);
  static const Color textLight = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF1A1A2E);
  
  // Status
  static const Color success = Color(0xFF27AE60);
  static const Color error = Color(0xFFE74C3C);
  static const Color warning = Color(0xFFF39C12);
  
  // Map
  static const Color mapMarkerBlue = Color(0xFF3498DB);
  static const Color mapMarkerRed = Color(0xFFE74C3C);
  static const Color mapMarkerGold = Color(0xFFF4B942);
  
  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, Color(0xFF2E7D9E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient goldGradient = LinearGradient(
    colors: [secondary, Color(0xFFE8A838)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}