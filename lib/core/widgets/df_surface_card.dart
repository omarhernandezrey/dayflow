import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';

/// The standard DayFlow surface card — dark background with subtle border.
class DFCard extends StatelessWidget {
  const DFCard({
    super.key,
    required this.child,
    this.padding,
    this.radius = AppDimensions.rLg,
    this.color = AppColors.surface,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double radius;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(AppDimensions.s4 + 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: AppColors.border),
      ),
      child: child,
    );
  }
}
