import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimensions.dart';
import '../../core/theme/app_typography.dart';
import '../../l10n/app_localizations.dart';

/// Professional error state widget with retry action.
class DFError extends StatelessWidget {
  const DFError({
    super.key,
    required this.message,
    this.onRetry,
  });

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.s6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 48,
              color: AppColors.danger.withAlpha(180),
            ),
            const SizedBox(height: AppDimensions.s3),
            Text(
              l10n.errorTitle,
              style: AppTypography.inter(
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppDimensions.s2),
            Text(
              message,
              style: AppTypography.inter(
                fontSize: 13.5,
                color: AppColors.textDim,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppDimensions.s4),
              ElevatedButton(
                onPressed: onRetry,
                child: Text(l10n.retryButton),
              ),
            ],
          ],
        ),
      ),
    );
  }
}