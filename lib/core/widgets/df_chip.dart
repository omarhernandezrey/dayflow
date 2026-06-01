import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';
import '../theme/app_typography.dart';

enum DFChipCategory { academic, health, personal }

/// Filter chip — used in tab bars and filter rows.
class DFFilterChip extends StatelessWidget {
  const DFFilterChip({
    super.key,
    required this.label,
    this.selected = false,
    this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.s4,
          vertical: AppDimensions.s2 - 1,
        ),
        decoration: BoxDecoration(
          color: selected ? AppColors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(AppDimensions.rPill),
          border: Border.all(
            color: selected ? AppColors.blue : AppColors.borderStrong,
          ),
        ),
        child: Text(
          label,
          style: AppTypography.inter(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.1,
            color: selected ? Colors.white : AppColors.textDim,
          ),
        ),
      ),
    );
  }
}

/// Category badge chip with a colored dot indicator.
class DFCategoryChip extends StatelessWidget {
  const DFCategoryChip({
    super.key,
    required this.category,
  });

  final DFChipCategory category;

  @override
  Widget build(BuildContext context) {
    final (label, color, bg) = switch (category) {
      DFChipCategory.academic => (
          'Académica',
          AppColors.catAcademic,
          const Color(0x2E3D7BFF),
        ),
      DFChipCategory.health => (
          'Salud',
          AppColors.catHealth,
          const Color(0x2E22C55E),
        ),
      DFChipCategory.personal => (
          'Personal',
          AppColors.catPersonal,
          const Color(0x2EF59E0B),
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.s3,
        vertical: AppDimensions.s1 + 2,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppDimensions.rPill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: AppDimensions.s2 - 2),
          Text(
            label,
            style: AppTypography.inter(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.1,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
