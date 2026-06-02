import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimensions.dart';
import '../../core/theme/app_typography.dart';
import '../../presentation/providers/auth_provider.dart';
import '../../presentation/providers/celebration_provider.dart';
import '../../presentation/providers/home_widget_updater_provider.dart';
import '../../presentation/widgets/df_confetti.dart';

class DFNavShell extends ConsumerWidget {
  const DFNavShell({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Keep home widget updater alive
    ref.watch(homeWidgetUpdaterProvider);

    final confettiKey = GlobalKey<DFConfettiState>();

    ref.listen(celebrationTriggerProvider, (prev, next) {
      if (next) {
        confettiKey.currentState?.play();
        ref.read(celebrationTriggerProvider.notifier).state = false;
      }
    });

    return Scaffold(
      backgroundColor: AppColors.bg,
      drawer: _DFDrawer(ref: ref),
      body: Stack(
        fit: StackFit.expand,
        children: [
          navigationShell,
          Align(
            alignment: Alignment.topCenter,
            child: DFConfetti(key: confettiKey),
          ),
        ],
      ),
      bottomNavigationBar: _BottomNav(
        currentIndex: navigationShell.currentIndex,
        onTap: (i) => navigationShell.goBranch(
          i,
          initialLocation: i == navigationShell.currentIndex,
        ),
      ),
    );
  }
}

// ─── Bottom nav ───────────────────────────────────────────────

class _BottomNav extends StatelessWidget {
  const _BottomNav({required this.currentIndex, required this.onTap});
  final int currentIndex;
  final ValueChanged<int> onTap;

  static const _items = [
    _NavItem(Icons.home_outlined, Icons.home_rounded, 'Inicio'),
    _NavItem(Icons.check_box_outline_blank_rounded, Icons.check_box_rounded, 'Tareas'),
    _NavItem(Icons.radio_button_unchecked_rounded, Icons.radio_button_checked_rounded, 'Hábitos'),
    _NavItem(Icons.bar_chart_outlined, Icons.bar_chart_rounded, 'Stats'),
    _NavItem(Icons.more_horiz_rounded, Icons.more_horiz_rounded, 'Más'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimensions.bottomNav + MediaQuery.of(context).padding.bottom,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: List.generate(_items.length, (i) {
          final item = _items[i];
          final active = currentIndex == i;
          return Expanded(
            child: Semantics(
              button: true,
              label: item.label,
              selected: active,
              child: InkWell(
                onTap: () => onTap(i),
                customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      active ? item.activeIcon : item.icon,
                      color: active ? AppColors.blue : AppColors.textMute,
                      size: 22,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.label,
                      style: AppTypography.inter(
                        fontSize: 10.5,
                        fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                        color: active ? AppColors.blue : AppColors.textMute,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _NavItem {
  const _NavItem(this.icon, this.activeIcon, this.label);
  final IconData icon;
  final IconData activeIcon;
  final String label;
}

// ─── Drawer ───────────────────────────────────────────────────

class _DFDrawer extends StatelessWidget {
  const _DFDrawer({required this.ref});
  final WidgetRef ref;

  static const _items = [
    _DrawerItem(Icons.person_outline_rounded, 'Mi perfil', 'Datos personales', null, '/profile'),
    _DrawerItem(Icons.emoji_events_outlined, 'Logros', 'Ver progreso', null, '/achievements'),
    _DrawerItem(Icons.palette_outlined, 'Apariencia', 'Tema oscuro', null, null),
    _DrawerItem(Icons.notifications_outlined, 'Notificaciones', 'Activadas', null, '/notifications'),
    _DrawerItem(Icons.label_outline_rounded, 'Categorías', 'Personal, Académica, Salud', null, null),
    _DrawerItem(Icons.shield_outlined, 'Privacidad y datos', 'Almacenamiento local', null, null),
    _DrawerItem(Icons.help_outline_rounded, 'Ayuda y soporte', 'Centro de ayuda', null, null),
  ];

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authStateProvider).valueOrNull;
    final initials = user?.initials ?? 'U';
    final name = user?.name ?? 'Usuario';
    final email = user?.email ?? '';

    return Drawer(
      backgroundColor: AppColors.bg,
      elevation: 0,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Column(
        children: [
          // Profile header
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + AppDimensions.s8,
              left: AppDimensions.s5,
              right: AppDimensions.s5,
              bottom: AppDimensions.s5,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.surface, AppColors.bg],
              ),
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
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
                      letterSpacing: -0.5,
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
          ),

          // Items
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                vertical: AppDimensions.s2,
                horizontal: AppDimensions.s3,
              ),
              itemCount: _items.length,
              itemBuilder: (_, i) => _drawerTile(context, _items[i]),
            ),
          ),

          // Logout
          Padding(
            padding: EdgeInsets.only(
              left: AppDimensions.s4,
              right: AppDimensions.s4,
              bottom: MediaQuery.of(context).padding.bottom + AppDimensions.s4,
              top: AppDimensions.s2,
            ),
            child: GestureDetector(
              onTap: () async {
                await ref.read(authStateProvider.notifier).logout();
                if (context.mounted) context.go('/splash');
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: AppDimensions.s4),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderStrong),
                  borderRadius: BorderRadius.circular(AppDimensions.rMd),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.logout_rounded, color: AppColors.danger, size: 18),
                    const SizedBox(width: AppDimensions.s2),
                    Text(
                      'Cerrar sesión',
                      style: AppTypography.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.danger,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawerTile(BuildContext context, _DrawerItem item) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop(); // close drawer
          if (item.route != null) context.push(item.route!);
        },
        borderRadius: BorderRadius.circular(AppDimensions.rMd),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.s3,
            vertical: AppDimensions.s3,
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppDimensions.rSm),
                ),
                child: Icon(item.icon, color: AppColors.text, size: 18),
              ),
              const SizedBox(width: AppDimensions.s4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.label,
                      style: AppTypography.inter(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.2,
                      ),
                    ),
                    Text(item.subtitle, style: AppTypography.caption),
                  ],
                ),
              ),
              if (item.badge != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.s2,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.blue,
                    borderRadius: BorderRadius.circular(AppDimensions.rPill),
                  ),
                  child: Text(
                    item.badge!,
                    style: AppTypography.inter(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              const SizedBox(width: AppDimensions.s2),
              const Icon(Icons.chevron_right_rounded, color: AppColors.textMute, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerItem {
  const _DrawerItem(this.icon, this.label, this.subtitle, this.badge, this.route);
  final IconData icon;
  final String label;
  final String subtitle;
  final String? badge;
  final String? route;
}
