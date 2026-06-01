import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimensions.dart';
import '../../core/theme/app_typography.dart';
import 'auth_widgets.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppDimensions.s6,
            AppDimensions.s3,
            AppDimensions.s6,
            AppDimensions.s6,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DFBackBtn(onTap: () => Navigator.of(context).maybePop()),
              const SizedBox(height: AppDimensions.s5),
              Center(
                child: Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    color: AppColors.blueSoft,
                    borderRadius: BorderRadius.circular(AppDimensions.rXl + 4),
                    border: Border.all(color: AppColors.blue.withAlpha(68)),
                  ),
                  child: const Icon(Icons.shield_outlined, size: 44, color: AppColors.blue),
                ),
              ),
              const SizedBox(height: AppDimensions.s5),
              Center(
                child: Text(
                  'Recupera tu acceso',
                  style: AppTypography.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.6,
                    height: 1.15,
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.s2),
              Center(
                child: Text(
                  'DayFlow funciona de forma offline. Si olvidaste tu contraseña, no podemos enviar un correo de recuperación. Te recomendamos crear una nueva cuenta.',
                  textAlign: TextAlign.center,
                  style: AppTypography.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textDim,
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.s6),
              DFPrimaryBtn(
                label: 'Volver a iniciar sesión',
                onTap: () => context.go('/login'),
              ),
              const SizedBox(height: AppDimensions.s3),
              DFPrimaryBtn(
                label: 'Crear nueva cuenta',
                color: AppColors.surface,
                onTap: () => context.go('/register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
