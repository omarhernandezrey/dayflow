import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimensions.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/widgets/df_app_bar.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  static const _notifs = [
    _Notif('Estudiar Matemáticas', 'Comienza en 15 minutos', 'Ahora', Icons.access_time_rounded, AppColors.catAcademic, true),
    _Notif('¡12 días de racha!', 'Has mantenido tu racha de hábitos durante 12 días.', 'Hace 1 h', Icons.local_fire_department_rounded, AppColors.catPersonal, true),
    _Notif('Hábito completado', 'Marcaste «Ejercicio 30 min» como hecho.', 'Hace 3 h', Icons.check_circle_outlined, AppColors.success, false),
    _Notif('Semana al 78%', 'Tu mejor semana del mes hasta ahora.', 'Ayer', Icons.emoji_events_outlined, Color(0xFFF472B6), false),
    _Notif('Entrenamiento', 'Recordatorio: empieza a las 5:30 PM.', 'Ayer', Icons.notifications_outlined, AppColors.textDim, false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: const DFAppBar(
          title: 'Notificaciones', showBack: true, showSettings: true),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppDimensions.s5,
          AppDimensions.s2,
          AppDimensions.s5,
          AppDimensions.s6,
        ),
        children: [
          // Header
          Row(
            children: [
              Text('2 sin leer',
                  style: AppTypography.inter(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textDim,
                  )),
              const Spacer(),
              Text('Marcar todo como leído',
                  style: AppTypography.inter(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blue,
                  )),
            ],
          ),
          const SizedBox(height: AppDimensions.s4),

          ..._notifs.map((n) {
            return Padding(
              padding: const EdgeInsets.only(bottom: AppDimensions.s2 + 2),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppDimensions.s4 - 2),
                    decoration: BoxDecoration(
                      color: n.isNew ? AppColors.surface : Colors.transparent,
                      border: Border.all(
                        color: n.isNew ? AppColors.border : Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(AppDimensions.rMd),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: n.color.withAlpha(34),
                            borderRadius:
                                BorderRadius.circular(AppDimensions.rSm + 2),
                          ),
                          child: Icon(n.icon, size: 20, color: n.color),
                        ),
                        const SizedBox(width: AppDimensions.s3),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Expanded(
                                    child: Text(n.title,
                                        style: AppTypography.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: -0.2,
                                        )),
                                  ),
                                  const SizedBox(width: AppDimensions.s2),
                                  Text(n.time,
                                      style: AppTypography.inter(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.textMute,
                                      )),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(n.body,
                                  style: AppTypography.inter(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textDim,
                                    height: 1.4,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (n.isNew)
                    Positioned(
                      top: 18,
                      right: -2,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.blue,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _Notif {
  const _Notif(this.title, this.body, this.time, this.icon, this.color, this.isNew);
  final String title;
  final String body;
  final String time;
  final IconData icon;
  final Color color;
  final bool isNew;
}
