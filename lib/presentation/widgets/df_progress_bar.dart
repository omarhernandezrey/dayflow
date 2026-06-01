import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// Animated progress bar with percentage display for quantifiable habits.
class DFProgressBar extends StatelessWidget {
  const DFProgressBar({
    super.key,
    required this.current,
    required this.target,
    required this.color,
    this.height = 8,
    this.showLabel = true,
    this.label,
  });

  final double current;
  final double target;
  final Color color;
  final double height;
  final bool showLabel;
  final String? label;

  double get _percentage => target > 0 ? (current / target).clamp(0.0, 1.0) : 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showLabel)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (label != null)
                Text(
                  label!,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDim,
                  ),
                ),
              Text(
                '${(current).toStringAsFixed(current == current.toInt() ? 0 : 1)}/${target.toStringAsFixed(target == target.toInt() ? 0 : 1)}',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ],
          ),
        if (showLabel) const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(height / 2),
          child: Container(
            height: height,
            decoration: BoxDecoration(
              color: AppColors.surface2,
              borderRadius: BorderRadius.circular(height / 2),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: _percentage,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(height / 2),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
