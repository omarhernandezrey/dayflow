import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_dimensions.dart';
import 'app_typography.dart';

abstract final class AppTheme {
  static ThemeData get dark {
    const colorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.blue,
      onPrimary: Colors.white,
      primaryContainer: AppColors.blueSoft,
      onPrimaryContainer: AppColors.blue,
      secondary: AppColors.violet,
      onSecondary: Colors.white,
      secondaryContainer: Color(0x267C3AED),
      onSecondaryContainer: AppColors.violet,
      tertiary: AppColors.catPersonal,
      onTertiary: AppColors.bg,
      error: AppColors.danger,
      onError: Colors.white,
      surface: AppColors.surface,
      onSurface: AppColors.text,
      onSurfaceVariant: AppColors.textDim,
      outline: AppColors.border,
      outlineVariant: AppColors.borderStrong,
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: AppColors.text,
      onInverseSurface: AppColors.bg,
      inversePrimary: AppColors.blueDeep,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.bg,
      canvasColor: AppColors.surface,
      cardColor: AppColors.surface,
      dividerColor: AppColors.border,
      textTheme: AppTypography.textTheme,

      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.bg,
        foregroundColor: AppColors.text,
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        centerTitle: false,
        titleTextStyle: AppTypography.heading,
      ),

      // Card
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.rLg),
          side: const BorderSide(color: AppColors.border),
        ),
        margin: EdgeInsets.zero,
      ),

      // ElevatedButton (maps to primary)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.blue,
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

      // FilledButton
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.blue,
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

      // OutlinedButton (maps to secondary)
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.text,
          backgroundColor: AppColors.surface2,
          minimumSize: const Size(0, AppDimensions.btnHeight),
          padding: const EdgeInsets.symmetric(horizontal: AppDimensions.s5),
          side: const BorderSide(color: AppColors.borderStrong),
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

      // TextButton (ghost)
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.textDim,
          minimumSize: const Size(0, AppDimensions.btnHeight),
          padding: const EdgeInsets.symmetric(horizontal: AppDimensions.s4),
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

      // InputDecoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface2,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.s4,
          vertical: AppDimensions.s3,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.rMd),
          borderSide: const BorderSide(color: AppColors.border, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.rMd),
          borderSide: const BorderSide(color: AppColors.border, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.rMd),
          borderSide: const BorderSide(color: AppColors.blue, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.rMd),
          borderSide: const BorderSide(color: AppColors.danger, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.rMd),
          borderSide: const BorderSide(color: AppColors.danger, width: 1.5),
        ),
        hintStyle: AppTypography.inter(
          fontSize: 14.5,
          fontWeight: FontWeight.w500,
          color: AppColors.textMute,
        ),
        labelStyle: AppTypography.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.textDim,
        ),
        floatingLabelStyle: AppTypography.inter(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColors.blue,
        ),
        prefixIconColor: AppColors.textDim,
        suffixIconColor: AppColors.textDim,
      ),

      // Checkbox
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return AppColors.success;
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(AppColors.bg),
        side: const BorderSide(color: AppColors.borderStrong, width: 1.8),
        shape: const CircleBorder(),
      ),

      // Switch (toggle)
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(Colors.white),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return AppColors.blue;
          return AppColors.surfaceHi;
        }),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),

      // BottomNavigationBar
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.blue,
        unselectedItemColor: AppColors.textMute,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: AppTypography.inter(
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: AppTypography.inter(
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),

      // NavigationBar (Material 3)
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.blueSoft,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.blue);
          }
          return const IconThemeData(color: AppColors.textMute);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppTypography.inter(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.blue,
            );
          }
          return AppTypography.inter(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: AppColors.textMute,
          );
        }),
        elevation: 0,
        height: AppDimensions.bottomNav,
      ),

      // Chip
      chipTheme: ChipThemeData(
        backgroundColor: Colors.transparent,
        selectedColor: AppColors.blue,
        side: const BorderSide(color: AppColors.borderStrong),
        shape: const StadiumBorder(),
        labelStyle: AppTypography.inter(
          fontSize: 12.5,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.1,
          color: AppColors.textDim,
        ),
        secondaryLabelStyle: AppTypography.inter(
          fontSize: 12.5,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.s3,
          vertical: AppDimensions.s2,
        ),
        elevation: 0,
        pressElevation: 0,
      ),

      // ListTile
      listTileTheme: ListTileThemeData(
        tileColor: Colors.transparent,
        iconColor: AppColors.textDim,
        textColor: AppColors.text,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.rMd),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.s4,
          vertical: AppDimensions.s2,
        ),
      ),

      // Divider
      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
        space: 0,
      ),

      // Dialog
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.rXl),
        ),
        elevation: 0,
      ),

      // SnackBar
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.surfaceHi,
        contentTextStyle: AppTypography.body.copyWith(color: AppColors.text),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.rMd),
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 0,
      ),

      // FloatingActionButton
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
        highlightElevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.rLg),
        ),
      ),

      // Icon
      iconTheme: const IconThemeData(
        color: AppColors.textDim,
        size: 24,
      ),

      // Slider
      sliderTheme: const SliderThemeData(
        activeTrackColor: AppColors.blue,
        inactiveTrackColor: AppColors.surfaceHi,
        thumbColor: AppColors.blue,
        overlayColor: AppColors.blueSoft,
      ),

      // ProgressIndicator
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.blue,
        linearTrackColor: AppColors.surfaceHi,
        circularTrackColor: AppColors.surfaceHi,
      ),
    );
  }
}
