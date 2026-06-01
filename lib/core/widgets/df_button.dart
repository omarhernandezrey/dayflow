import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';
import '../theme/app_shadows.dart';
import '../theme/app_typography.dart';

enum DFButtonVariant { primary, secondary, success, danger, ghost }

enum DFButtonSize { normal, sm }

class DFButton extends StatelessWidget {
  const DFButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = DFButtonVariant.primary,
    this.size = DFButtonSize.normal,
    this.leading,
    this.fullWidth = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final DFButtonVariant variant;
  final DFButtonSize size;
  final Widget? leading;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    final isSmall = size == DFButtonSize.sm;

    final height = isSmall ? AppDimensions.btnSmHeight : AppDimensions.btnHeight;
    final hPad = isSmall ? AppDimensions.s3 : AppDimensions.s5 - 2;
    final fontSize = isSmall ? 12.5 : 14.0;
    final radius = isSmall ? AppDimensions.rSm : AppDimensions.rMd;

    final (bgColor, fgColor, borderColor, shadows) = _resolve(variant);

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: fullWidth ? double.infinity : null,
        padding: EdgeInsets.symmetric(horizontal: hPad),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(radius),
          border: borderColor != null
              ? Border.all(color: borderColor, width: 1)
              : null,
          boxShadow: shadows,
        ),
        child: Row(
          mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leading != null) ...[
              leading!,
              const SizedBox(width: AppDimensions.s2),
            ],
            Text(
              label,
              style: AppTypography.inter(
                fontSize: fontSize,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.2,
                color: fgColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static (Color, Color, Color?, List<BoxShadow>) _resolve(DFButtonVariant v) =>
      switch (v) {
        DFButtonVariant.primary => (
            AppColors.blue,
            Colors.white,
            null,
            AppShadows.glowBlue,
          ),
        DFButtonVariant.secondary => (
            AppColors.surface2,
            AppColors.text,
            AppColors.borderStrong,
            const [],
          ),
        DFButtonVariant.success => (
            AppColors.success,
            AppColors.bg,
            null,
            AppShadows.glowGreen,
          ),
        DFButtonVariant.danger => (
            Colors.transparent,
            AppColors.danger,
            AppColors.borderStrong,
            const [],
          ),
        DFButtonVariant.ghost => (
            Colors.transparent,
            AppColors.textDim,
            null,
            const [],
          ),
      };
}
