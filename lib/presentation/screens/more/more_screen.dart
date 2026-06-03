import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_typography.dart';
import '../../providers/achievements_provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/theme_provider.dart';

class MoreScreen extends ConsumerWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unlockedCount = ref.watch(unlockedAchievementsCountProvider.select((v) => v.valueOrNull ?? 0));
    final themeMode = ref.watch(themeModeProvider);
    final userName = ref.watch(authStateProvider.select((v) => v.valueOrNull?.name ?? 'Usuario'));
    final userEmail = ref.watch(authStateProvider.select((v) => v.valueOrNull?.email ?? 'DayFlow User'));
    final userInitials = ref.watch(authStateProvider.select((v) => v.valueOrNull?.initials ?? 'U'));

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppDimensions.s5,
            AppDimensions.s4,
            AppDimensions.s5,
            AppDimensions.s6,
          ),
          children: [
            Text(
              'Más',
              style: AppTypography.inter(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.6,
              ),
            ),
            const SizedBox(height: AppDimensions.s5),
            _ProfileHeader(initials: userInitials, name: userName, email: userEmail),
            const SizedBox(height: AppDimensions.s5),
            _MenuSection(title: 'Personalización', items: [
              _MenuItem(
                icon: Icons.palette_outlined,
                title: 'Apariencia',
                subtitle: _themeLabel(themeMode),
                onTap: () => _showThemePicker(context, ref),
              ),
            ]),
            _MenuSection(title: 'Datos', items: [
              _MenuItem(
                icon: Icons.backup_outlined,
                title: 'Copia de seguridad',
                subtitle: 'Exportar y restaurar',
                onTap: () => context.push('/backup'),
              ),
              _MenuItem(
                icon: Icons.file_download_outlined,
                title: 'Exportar datos',
                subtitle: 'CSV y PDF',
                onTap: () => context.push('/backup'),
              ),
            ]),
            _MenuSection(title: 'Progreso', items: [
              _MenuItem(
                icon: Icons.emoji_events_outlined,
                title: 'Logros',
                subtitle: '$unlockedCount desbloqueados',
                trailing: unlockedCount > 0
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.s2,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.blue,
                          borderRadius: BorderRadius.circular(AppDimensions.rPill),
                        ),
                        child: Text(
                          '$unlockedCount',
                          style: AppTypography.inter(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : null,
                onTap: () => context.push('/achievements'),
              ),
              _MenuItem(
                icon: Icons.calendar_month_outlined,
                title: 'Calendario',
                subtitle: 'Vista mensual y semanal',
                onTap: () => context.push('/calendar'),
              ),
            ]),
            _MenuSection(title: 'Cuenta', items: [
              _MenuItem(
                icon: Icons.logout_rounded,
                title: 'Cerrar sesión',
                subtitle: 'Salir de la aplicación',
                iconColor: AppColors.danger,
                onTap: () async {
                  await ref.read(authStateProvider.notifier).logout();
                  if (context.mounted) context.go('/splash');
                },
              ),
            ]),
          ],
        ),
      ),
    );
  }

  String _themeLabel(ThemeModeOption mode) {
    switch (mode) {
      case ThemeModeOption.light:
        return 'Claro';
      case ThemeModeOption.dark:
        return 'Oscuro';
      case ThemeModeOption.system:
        return 'Sistema';
    }
  }

  void _showThemePicker(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.s5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Tema',
                style: AppTypography.inter(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppDimensions.s4),
              ...ThemeModeOption.values.map((mode) => ListTile(
                    leading: Icon(
                      mode == ThemeModeOption.light
                          ? Icons.light_mode_outlined
                          : mode == ThemeModeOption.dark
                              ? Icons.dark_mode_outlined
                              : Icons.brightness_auto_outlined,
                      color: AppColors.text,
                    ),
                    title: Text(
                      _themeLabel(mode),
                      style: AppTypography.inter(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    trailing: ref.watch(themeModeProvider) == mode
                        ? const Icon(Icons.check_rounded, color: AppColors.blue)
                        : null,
                    onTap: () {
                      ref.read(themeModeProvider.notifier).setMode(mode);
                      Navigator.pop(context);
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.initials, required this.name, required this.email});
  final String initials;
  final String name;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.s4 + 2),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.rLg),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.blue, Color(0xFFA78BFA)],
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              initials,
              style: AppTypography.inter(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: AppDimensions.s4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTypography.inter(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  email,
                  style: AppTypography.caption,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuSection extends StatelessWidget {
  const _MenuSection({required this.title, required this.items});
  final String title;
  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: AppDimensions.s5,
            bottom: AppDimensions.s3,
          ),
          child: Text(
            title.toUpperCase(),
            style: AppTypography.inter(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.textDim,
              letterSpacing: 0.8,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppDimensions.rLg - 2),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(children: items),
        ),
      ],
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.trailing,
    this.iconColor,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Widget? trailing;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.rMd),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.s4,
            vertical: AppDimensions.s3 + 2,
          ),
          child: Row(
            children: [
              Icon(icon, color: iconColor ?? AppColors.text, size: 22),
              const SizedBox(width: AppDimensions.s3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTypography.inter(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: AppTypography.inter(
                        fontSize: 12,
                        color: AppColors.textDim,
                      ),
                    ),
                  ],
                ),
              ),
              if (trailing != null) ...[
                trailing!,
                const SizedBox(width: AppDimensions.s2),
              ],
              const Icon(Icons.chevron_right_rounded, color: AppColors.textMute, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
