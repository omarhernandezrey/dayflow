import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_dimensions.dart';
import 'app_typography.dart';

/// Light theme data for DayFlow.
/// Preserves the exact same component structure as dark theme,
/// only swapping background/surface/text colors.
abstract final class AppLightTheme {
  static ThemeData get light {
    const colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF3D7BFF),
      onPrimary: Colors.white,
      primaryContainer: Color(0xFFE8F0FF),
      onPrimaryContainer: Color(0xFF3D7BFF),
      secondary: Color(0xFF7C3AED),
      onSecondary: Colors.white,
      secondaryContainer: Color(0xFFF3E8FF),
      onSecondaryContainer: Color(0xFF7C3AED),
      tertiary: Color(0xFFF59E0B),
      onTertiary: Colors.white,
      error: Color(0xFFEF4444),
      onError: Colors.white,
      surface: Colors.white,
      onSurface: Color(0xFF1A1A1A),
      onSurfaceVariant: Color(0xFF6B7280),
      outline: Color(0xFFE5E7EB),
      outlineVariant: Color(0xFFD1D5DB),
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: Color(0xFF1A1A1A),
      onInverseSurface: Colors.white,
      inversePrimary: Color(0xFF1A5FCC),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: const Color(0xFFF8F9FB),
      canvasColor: Colors.white,
      cardColor: Colors.white,
      dividerColor: const Color(0xFFE5E7EB),
      textTheme: AppTypography.textTheme,

      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFFF8F9FB),
        foregroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        centerTitle: false,
        titleTextStyle: AppTypography.heading,
      ),

      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.rLg),
          side: const BorderSide(color: Color(0xFFE5E7EB)),
        ),
        margin: EdgeInsets.zero,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3D7BFF),
          foregroundColor: Colors.white,
          minimumSize: const Size(0, AppDimensions.btnHeight),
          padding: const EdgeInsets.symmetric(horizontal: AppDimensions.s5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.rMd),
          ),
          elevation: 0,
          textStyle: AppTypography.inter(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: const Color(0xFF3D7BFF),
          foregroundColor: Colors.white,
          minimumSize: const Size(0, AppDimensions.btnHeight),
          padding: const EdgeInsets.symmetric(horizontal: AppDimensions.s5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.rMd),
          ),
          textStyle: AppTypography.inter(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF1A1A1A),
          backgroundColor: const Color(0xFFF3F4F6),
          minimumSize: const Size(0, AppDimensions.btnHeight),
          padding: const EdgeInsets.symmetric(horizontal: AppDimensions.s5),
          side: const BorderSide(color: Color(0xFFD1D5DB)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.rMd),
          ),
          textStyle: AppTypography.inter(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF3F4F6),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.s4,
          vertical: AppDimensions.s3,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.rMd),
          borderSide: const BorderSide(color: Color(0xFFE5E7EB), width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.rMd),
          borderSide: const BorderSide(color: Color(0xFFE5E7EB), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.rMd),
          borderSide: const BorderSide(color: Color(0xFF3D7BFF), width: 1.5),
        ),
        hintStyle: AppTypography.inter(
          fontSize: 14.5,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF9CA3AF),
        ),
        labelStyle: AppTypography.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF6B7280),
        ),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF3D7BFF),
        unselectedItemColor: const Color(0xFF9CA3AF),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),

      chipTheme: ChipThemeData(
        backgroundColor: Colors.transparent,
        selectedColor: const Color(0xFF3D7BFF),
        side: const BorderSide(color: Color(0xFFD1D5DB)),
        shape: const StadiumBorder(),
        labelStyle: AppTypography.inter(
          fontSize: 12.5,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.1,
          color: const Color(0xFF6B7280),
        ),
        secondaryLabelStyle: AppTypography.inter(
          fontSize: 12.5,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.rXl),
        ),
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: const Color(0xFF1A1A1A),
        contentTextStyle: AppTypography.body.copyWith(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.rMd),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
