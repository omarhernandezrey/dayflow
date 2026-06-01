import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimensions.dart';
import '../../core/theme/app_typography.dart';
import '../../presentation/providers/auth_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool _checked = false;

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;

    final auth = ref.read(authStateProvider);
    if (auth.hasValue && auth.value != null) {
      if (mounted) context.go('/home');
      return;
    }

    setState(() => _checked = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          // Ambient glow — blue
          Positioned(
            top: MediaQuery.of(context).size.height * 0.15,
            left: MediaQuery.of(context).size.width / 2 - 160,
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.blue.withAlpha(51),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Ambient glow — violet
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.20,
            right: -MediaQuery.of(context).size.width * 0.10,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.violet.withAlpha(51),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Content
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _DayFlowLogo(size: 96),
                      const SizedBox(height: AppDimensions.s5),
                      Text('DayFlow',
                          style: AppTypography.inter(
                            fontSize: 40,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -1.5,
                          )),
                      const SizedBox(height: AppDimensions.s3),
                      Text(
                        'Organiza tu día.\nConstruye mejores hábitos.',
                        textAlign: TextAlign.center,
                        style: AppTypography.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textDim,
                          letterSpacing: -0.1,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.s5),
                      Wrap(
                        spacing: AppDimensions.s2,
                        runSpacing: AppDimensions.s2,
                        alignment: WrapAlignment.center,
                        children: const [
                          _FeaturePill(
                            icon: Icons.check_rounded,
                            label: 'Sin conexión',
                            color: AppColors.catHealth,
                          ),
                          _FeaturePill(
                            icon: Icons.shield_outlined,
                            label: '100% privado',
                            color: AppColors.blue,
                          ),
                          _FeaturePill(
                            icon: Icons.notifications_outlined,
                            label: 'Recordatorios',
                            color: AppColors.catPersonal,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                if (_checked)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppDimensions.s5,
                      0,
                      AppDimensions.s5,
                      AppDimensions.s6,
                    ),
                    child: Column(
                      children: [
                        _PrimaryBtn(
                          label: 'Comenzar',
                          onTap: () => context.go('/register'),
                        ),
                        const SizedBox(height: AppDimensions.s3),
                        GestureDetector(
                          onTap: () => context.go('/login'),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.borderStrong, width: 1.5),
                              borderRadius: BorderRadius.circular(AppDimensions.rMd),
                            ),
                            alignment: Alignment.center,
                            child: Text('Ya tengo una cuenta',
                                style: AppTypography.inter(
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w600,
                                )),
                          ),
                        ),
                        const SizedBox(height: AppDimensions.s3),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: AppTypography.inter(
                              fontSize: 11.5,
                              color: AppColors.textMute,
                            ),
                            children: [
                              const TextSpan(text: 'Al continuar aceptas los '),
                              TextSpan(
                                  text: 'Términos',
                                  style: AppTypography.inter(
                                    fontSize: 11.5,
                                    color: AppColors.blue,
                                  )),
                              const TextSpan(text: ' y la '),
                              TextSpan(
                                  text: 'Política de privacidad',
                                  style: AppTypography.inter(
                                    fontSize: 11.5,
                                    color: AppColors.blue,
                                  )),
                              const TextSpan(text: '.'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  const Padding(
                    padding: EdgeInsets.only(bottom: AppDimensions.s6),
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DayFlowLogo extends StatelessWidget {
  const _DayFlowLogo({required this.size});
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * 0.28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.blue, AppColors.violet],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.blue.withAlpha(80),
            blurRadius: 32,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Center(
        child: CustomPaint(
          size: Size(size * 0.6, size * 0.6),
          painter: _LogoPainter(),
        ),
      ),
    );
  }
}

class _LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(size.width * 0.21, size.height * 0.17);
    path.lineTo(size.width * 0.21 + size.width * 0.29, size.height * 0.17);
    path.arcToPoint(
      Offset(size.width * 0.21 + size.width * 0.29, size.height * 0.83),
      radius: Radius.circular(size.height * 0.33),
    );
    path.lineTo(size.width * 0.21, size.height * 0.83);
    path.close();
    canvas.drawPath(path, Paint()..color = Colors.white);
    canvas.drawCircle(
      Offset(size.width * 0.71, size.height * 0.5),
      size.width * 0.09,
      Paint()..color = AppColors.blue,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _FeaturePill extends StatelessWidget {
  const _FeaturePill({
    required this.icon,
    required this.label,
    required this.color,
  });
  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.s3,
        vertical: AppDimensions.s1 + 2,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(AppDimensions.rPill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: AppDimensions.s1 + 2),
          Text(label,
              style: AppTypography.inter(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: color,
              )),
        ],
      ),
    );
  }
}

class _PrimaryBtn extends StatelessWidget {
  const _PrimaryBtn({required this.label, this.onTap});
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    const c = AppColors.blue;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: c,
          borderRadius: BorderRadius.circular(AppDimensions.rMd),
          boxShadow: [
            BoxShadow(
              color: c.withAlpha(64),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(label,
            style: AppTypography.inter(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.2,
              color: Colors.white,
            )),
      ),
    );
  }
}
