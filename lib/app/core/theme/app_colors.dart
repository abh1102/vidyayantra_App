import 'package:flutter/material.dart';

class AppColors {
  // Primary Theme Colors - Navy Blue + Gold Premium
  static const Color primaryNavy = Color(0xFF0A122A);
  static const Color primaryGold = Color(0xFFD4AF37);
  static const Color goldLight = Color(0xFFE8D48A);
  static const Color goldDark = Color(0xFFB8962E);
  
  // Background Colors
  static const Color background = Color(0xFF0A122A);
  static const Color backgroundLight = Color(0xFF0F1A3A);
  static const Color cardBackground = Color(0xFF141E3C);
  static const Color cardBackgroundLight = Color(0xFF1A2745);
  
  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB8C5D6);
  static const Color textGold = Color(0xFFD4AF37);
  static const Color textMuted = Color(0xFF6B7A8F);
  
  // Status Colors
  static const Color success = Color(0xFF2ECC71);
  static const Color error = Color(0xFFE74C3C);
  static const Color warning = Color(0xFFF39C12);
  static const Color info = Color(0xFF3498DB);
  
  // Border Colors
  static const Color border = Color(0xFF2A3A5C);
  static const Color borderGold = Color(0xFFD4AF37);
  
  // Gradient
  static const LinearGradient goldGradient = LinearGradient(
    colors: [Color(0xFFD4AF37), Color(0xFFE8D48A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient navyGradient = LinearGradient(
    colors: [Color(0xFF0A122A), Color(0xFF141E3C)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
