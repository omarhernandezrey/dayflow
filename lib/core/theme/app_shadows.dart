import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract final class AppShadows {
  static const List<BoxShadow> shadow1 = [
    BoxShadow(
      color: Color(0x40000000), // 25% black
      blurRadius: 8,
      offset: Offset(0, 2),
    ),
  ];

  static const List<BoxShadow> shadow2 = [
    BoxShadow(
      color: Color(0x59000000), // 35% black
      blurRadius: 24,
      offset: Offset(0, 8),
    ),
  ];

  static const List<BoxShadow> shadow3 = [
    BoxShadow(
      color: Color(0x73000000), // 45% black
      blurRadius: 40,
      offset: Offset(0, 16),
    ),
  ];

  static const List<BoxShadow> glowBlue = [
    BoxShadow(
      color: AppColors.glowBlue,
      blurRadius: 24,
      offset: Offset(0, 8),
    ),
  ];

  static const List<BoxShadow> glowAmber = [
    BoxShadow(
      color: AppColors.glowAmber,
      blurRadius: 24,
      offset: Offset(0, 8),
    ),
  ];

  static const List<BoxShadow> glowGreen = [
    BoxShadow(
      color: AppColors.glowGreen,
      blurRadius: 24,
      offset: Offset(0, 8),
    ),
  ];
}
