import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

abstract final class AppTypography {
  // — UI font helpers —
  static TextStyle inter({
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
    Color? color,
  }) =>
      GoogleFonts.inter(
        fontSize: fontSize,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        height: height,
        color: color ?? AppColors.text,
      );

  static TextStyle mono({
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    Color? color,
  }) =>
      GoogleFonts.jetBrainsMono(
        fontSize: fontSize,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        color: color ?? AppColors.text,
        fontFeatures: const [FontFeature.tabularFigures()],
      );

  // — Type scale —
  static final TextStyle display = inter(
    fontSize: 56,
    fontWeight: FontWeight.w800,
    letterSpacing: -2,
    height: 60 / 56,
  );

  static final TextStyle titleXl = inter(
    fontSize: 34,
    fontWeight: FontWeight.w800,
    letterSpacing: -1,
    height: 38 / 34,
  );

  static final TextStyle title = inter(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.6,
    height: 28 / 24,
  );

  static final TextStyle heading = inter(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.2,
    height: 22 / 17,
  );

  static final TextStyle bodyLg = inter(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    height: 22 / 15,
  );

  static final TextStyle body = inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 20 / 14,
    color: AppColors.textDim,
  );

  static final TextStyle label = inter(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.6,
    color: AppColors.textDim,
  );

  static final TextStyle caption = inter(
    fontSize: 11.5,
    fontWeight: FontWeight.w500,
    height: 16 / 11.5,
    color: AppColors.textMute,
  );

  static final TextStyle numeric = mono(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.4,
  );

  // — Material 3 TextTheme —
  static TextTheme get textTheme => TextTheme(
        displayLarge: display,
        displayMedium: titleXl,
        displaySmall: title,
        headlineLarge: heading.copyWith(fontSize: 20, fontWeight: FontWeight.w800),
        headlineMedium: heading,
        headlineSmall: inter(fontSize: 15, fontWeight: FontWeight.w700),
        titleLarge: inter(fontSize: 17, fontWeight: FontWeight.w700, letterSpacing: -0.2),
        titleMedium: inter(fontSize: 15, fontWeight: FontWeight.w600),
        titleSmall: inter(fontSize: 13, fontWeight: FontWeight.w600),
        bodyLarge: bodyLg,
        bodyMedium: body,
        bodySmall: caption,
        labelLarge: inter(fontSize: 14, fontWeight: FontWeight.w700),
        labelMedium: label,
        labelSmall: inter(fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.8, color: AppColors.textMute),
      );
}
