import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimensions.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/widgets/df_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const _achievements = [
    _Achievement(Icons.local_fire_department_rounded, 'Racha de 10 días', AppColors.catPersonal, true),
    _Achievement(Icons.emoji_events_outlined, 'Semana perfecta', Color(0xFFF472B6), true),
    _Achievement(Icons.water_drop_outlined, 'Hidratado', Color(0xFF38BDF8), true),
    _Achievement(Icons.menu_book_outlined, 'Lector ávido', AppColors.catAcademic, true),
    _Achievement(Icons.fitness_center_rounded, '30 entrenos', AppColors.catHealth, false),
    _Achievement(Icons.auto_awesome_outlined, 'Madrugador', Color(0xFFFBBF24), false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: const DFAppBar(
          title: 'Mi perfil', showBack: true, showSettings: true),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppDimensions.s5,
          AppDimensions.s2,
          AppDimensions.s5,
          AppDimensions.s6,
        ),
        children: [
          // Avatar
          Center(
            child: Column(
              children: [
                Container(
                  width: 86,
                  height: 86,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.blue, Color(0xFFA78BFA)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x663D7BFF),
                        blurRadius: 32,
                        offset: Offset(0, 12),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text('JD',
                      style: AppTypography.inter(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.6,
                        color: Colors.white,
                      )),
                ),
                const SizedBox(height: AppDimensions.s3),
                Text('Juan David Quiceno',
                    style: AppTypography.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3,
                    )),
                const SizedBox(height: 2),
                Text('Miembro desde marzo 2026',
                    style: AppTypography.caption),
              ],
            ),
          ),

          const SizedBox(height: AppDimensions.s5),

          // Stats strip
          Row(
            children: const [
              _StatTile('42', 'Hábitos hechos'),
              SizedBox(width: AppDimensions.s2 + 2),
              _StatTile('12', 'Racha actual'),
              SizedBox(width: AppDimensions.s2 + 2),
              _StatTile('78%', 'Esta semana'),
            ],
          ),

          const SizedBox(height: AppDimensions.s5),

          // Achievements header
          Row(
            children: [
              Expanded(
                child: Text('Logros',
                    style: AppTypography.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.2,
                    )),
              ),
              Text('4 / 6',
                  style: AppTypography.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDim,
                  )),
            ],
          ),
          const SizedBox(height: AppDimensions.s3),

          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            crossAxisSpacing: AppDimensions.s2 + 2,
            mainAxisSpacing: AppDimensions.s2 + 2,
            childAspectRatio: 0.85,
            children: _achievements.map((a) {
              return Opacity(
                opacity: a.unlocked ? 1.0 : 0.45,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppDimensions.s4 - 2,
                    horizontal: AppDimensions.s2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(AppDimensions.rMd),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: a.unlocked
                              ? a.color.withAlpha(34)
                              : AppColors.surface2,
                          borderRadius:
                              BorderRadius.circular(AppDimensions.rSm + 2),
                        ),
                        child: Icon(a.icon,
                            size: 22,
                            color: a.unlocked ? a.color : AppColors.textMute),
                      ),
                      const SizedBox(height: AppDimensions.s2),
                      Text(a.title,
                          style: AppTypography.inter(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.1,
                            height: 1.2,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: AppDimensions.s5),

          // Settings shortcuts
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(AppDimensions.rLg - 2),
            ),
            child: Column(
              children: [
                _ShortcutTile(
                    icon: Icons.settings_outlined, label: 'Configuración'),
                _ShortcutTile(icon: Icons.shield_outlined, label: 'Privacidad'),
                _ShortcutTile(
                    icon: Icons.help_outline_rounded,
                    label: 'Ayuda',
                    last: true),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile(this.value, this.label);
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppDimensions.s4 - 2,
          horizontal: AppDimensions.s2,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(AppDimensions.rMd),
        ),
        child: Column(
          children: [
            Text(value,
                style: AppTypography.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.4,
                  height: 1,
                )),
            const SizedBox(height: AppDimensions.s1 + 2),
            Text(label,
                style: AppTypography.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textDim,
                  letterSpacing: -0.1,
                ),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _ShortcutTile extends StatelessWidget {
  const _ShortcutTile({required this.icon, required this.label, this.last = false});
  final IconData icon;
  final String label;
  final bool last;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.s4,
        vertical: AppDimensions.s4 - 2,
      ),
      decoration: BoxDecoration(
        border: last
            ? null
            : const Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.textDim),
          const SizedBox(width: AppDimensions.s4 - 2),
          Expanded(
            child: Text(label,
                style: AppTypography.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.2,
                )),
          ),
          const Icon(Icons.chevron_right_rounded,
              color: AppColors.textMute, size: 16),
        ],
      ),
    );
  }
}

class _Achievement {
  const _Achievement(this.icon, this.title, this.color, this.unlocked);
  final IconData icon;
  final String title;
  final Color color;
  final bool unlocked;
}
