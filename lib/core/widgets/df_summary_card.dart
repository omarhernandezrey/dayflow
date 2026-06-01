import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';
import '../theme/app_typography.dart';

enum DFSummaryVariant { blue, green, orange }

class DFSummaryCard extends StatelessWidget {
  const DFSummaryCard({
    super.key,
    required this.value,
    required this.label,
    required this.variant,
    this.icon,
  });

  final String value;
  final String label;
  final DFSummaryVariant variant;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final (color, shadow) = switch (variant) {
      DFSummaryVariant.blue   => (AppColors.catAcademic, AppColors.glowBlue),
      DFSummaryVariant.green  => (AppColors.catHealth,   AppColors.glowGreen),
      DFSummaryVariant.orange => (AppColors.catPersonal, AppColors.glowAmber),
    };

    return Container(
      padding: const EdgeInsets.all(AppDimensions.s4 - 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppDimensions.rMd),
        boxShadow: [
          BoxShadow(
            color: shadow,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon indicator
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(64),
              borderRadius: BorderRadius.circular(AppDimensions.rXs),
            ),
            child: icon != null
                ? Icon(icon, size: 14, color: Colors.white)
                : null,
          ),
          const Spacer(),
          Text(
            value,
            style: AppTypography.inter(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.8,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: AppDimensions.s1),
          Text(
            label,
            style: AppTypography.inter(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.white.withAlpha(235),
            ),
          ),
        ],
      ),
    );
  }
}

/// Row of three summary cards — home screen signature widget.
class DFSummaryRow extends StatelessWidget {
  const DFSummaryRow({
    super.key,
    required this.totalActivities,
    required this.completed,
    required this.pending,
  });

  final int totalActivities;
  final int completed;
  final int pending;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 100,
            child: DFSummaryCard(
              value: '$totalActivities',
              label: 'Actividades\ntotales',
              variant: DFSummaryVariant.blue,
              icon: Icons.check_box_outline_blank_rounded,
            ),
          ),
        ),
        const SizedBox(width: AppDimensions.s2 + 2),
        Expanded(
          child: SizedBox(
            height: 100,
            child: DFSummaryCard(
              value: '$completed',
              label: 'Completadas',
              variant: DFSummaryVariant.green,
              icon: Icons.check_circle_outline_rounded,
            ),
          ),
        ),
        const SizedBox(width: AppDimensions.s2 + 2),
        Expanded(
          child: SizedBox(
            height: 100,
            child: DFSummaryCard(
              value: '$pending',
              label: 'Pendientes',
              variant: DFSummaryVariant.orange,
              icon: Icons.schedule_rounded,
            ),
          ),
        ),
      ],
    );
  }
}
