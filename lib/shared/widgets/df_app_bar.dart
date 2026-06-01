import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimensions.dart';
import '../../core/theme/app_typography.dart';

class DFAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DFAppBar({
    super.key,
    required this.title,
    this.showMenu = false,
    this.showBack = false,
    this.showPlus = false,
    this.showMore = false,
    this.showSettings = false,
    this.onMenu,
    this.onBack,
    this.onPlus,
    this.onMore,
    this.onSettings,
  });

  final String title;
  final bool showMenu;
  final bool showBack;
  final bool showPlus;
  final bool showMore;
  final bool showSettings;
  final VoidCallback? onMenu;
  final VoidCallback? onBack;
  final VoidCallback? onPlus;
  final VoidCallback? onMore;
  final VoidCallback? onSettings;

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        color: AppColors.bg,
        height: 56,
        child: Row(
          children: [
            // Left action
            SizedBox(
              width: 56,
              child: _leftAction(context),
            ),

            // Title
            Expanded(
              child: Text(
                title,
                style: AppTypography.heading,
                textAlign: TextAlign.left,
              ),
            ),

            // Right action
            SizedBox(
              width: 56,
              child: _rightAction(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget? _leftAction(BuildContext context) {
    if (showBack) {
      return _IconBtn(
        icon: Icons.chevron_left_rounded,
        onTap: onBack ?? () => Navigator.of(context).maybePop(),
      );
    }
    if (showMenu) {
      return _IconBtn(icon: Icons.menu_rounded, onTap: onMenu);
    }
    return null;
  }

  Widget? _rightAction(BuildContext context) {
    if (showPlus) {
      return _IconBtn(icon: Icons.add_rounded, onTap: onPlus);
    }
    if (showMore) {
      return _IconBtn(icon: Icons.more_horiz_rounded, onTap: onMore);
    }
    if (showSettings) {
      return _IconBtn(icon: Icons.settings_outlined, onTap: onSettings);
    }
    return null;
  }
}

class _IconBtn extends StatelessWidget {
  const _IconBtn({required this.icon, this.onTap});
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(AppDimensions.s2),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimensions.rSm),
          border: Border.all(color: AppColors.border),
        ),
        child: Icon(icon, color: AppColors.text, size: 20),
      ),
    );
  }
}
