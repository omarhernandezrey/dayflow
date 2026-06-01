import 'package:flutter/material.dart';

abstract final class AppColors {
  // Surfaces
  static const Color bg           = Color(0xFF0E0F13);
  static const Color surface      = Color(0xFF181A20);
  static const Color surface2     = Color(0xFF1F222A);
  static const Color surfaceHi    = Color(0xFF262A33);

  // Borders  (7% and 12% white)
  static const Color border       = Color(0x12FFFFFF);
  static const Color borderStrong = Color(0x1FFFFFFF);

  // Text
  static const Color text         = Color(0xFFF2F3F7);
  static const Color textDim      = Color(0xFFA4A8B3);
  static const Color textMute     = Color(0xFF6B6F7A);

  // Brand
  static const Color blue         = Color(0xFF3D7BFF);
  static const Color blueDeep     = Color(0xFF2A5BC8);
  static const Color blueSoft     = Color(0x263D7BFF); // 15% blue
  static const Color violet       = Color(0xFF7C3AED);

  // Categories
  static const Color catAcademic  = Color(0xFF3D7BFF);
  static const Color catHealth    = Color(0xFF22C55E);
  static const Color catPersonal  = Color(0xFFF59E0B);

  // Semantic
  static const Color success      = Color(0xFF22C55E);
  static const Color warning      = Color(0xFFF59E0B);
  static const Color danger       = Color(0xFFEF4444);
  static const Color info         = Color(0xFF38BDF8);

  // Glow (for BoxShadow color)
  static const Color glowBlue     = Color(0x663D7BFF); // 40%
  static const Color glowAmber    = Color(0x59F59E0B); // 35%
  static const Color glowGreen    = Color(0x5922C55E); // 35%
}
