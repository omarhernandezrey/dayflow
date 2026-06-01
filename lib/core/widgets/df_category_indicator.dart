import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';
import '../theme/app_typography.dart';
import 'df_chip.dart';

/// A single activity row with a category dot, title, and category label.
class DFCategoryIndicator extends StatelessWidget {
  const DFCategoryIndicator({
    super.key,
    required this.title,
    required this.category,
    this.subtitle,
  });

  final String title;
  final DFChipCategory category;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final color = switch (category) {
      DFChipCategory.academic => AppColors.catAcademic,
      DFChipCategory.health   => AppColors.catHealth,
      DFChipCategory.personal => AppColors.catPersonal,
    };

    final categoryLabel = switch (category) {
      DFChipCategory.academic => 'Académica',
      DFChipCategory.health   => 'Salud',
      DFChipCategory.personal => 'Personal',
    };

    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: AppDimensions.s2 + 2),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTypography.inter(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                  color: AppColors.text,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (subtitle != null)
                Text(
                  subtitle!,
                  style: AppTypography.caption,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ),
        const SizedBox(width: AppDimensions.s2),
        Text(
          categoryLabel,
          style: AppTypography.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.textMute,
          ),
        ),
      ],
    );
  }
}
