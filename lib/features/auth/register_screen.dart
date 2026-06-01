import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimensions.dart';
import '../../core/theme/app_typography.dart';
import '../../presentation/providers/auth_provider.dart';
import 'auth_widgets.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _accepted = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_accepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debes aceptar los términos')),
      );
      return;
    }

    await ref.read(authStateProvider.notifier).register(
          _nameCtrl.text.trim(),
          _emailCtrl.text.trim(),
          _passwordCtrl.text,
        );

    final auth = ref.read(authStateProvider);
    if (auth.hasValue && auth.value != null && mounted) {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authStateProvider);
    final isLoading = auth.isLoading;

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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DFBackBtn(onTap: () => Navigator.of(context).maybePop()),
                const SizedBox(height: AppDimensions.s3),
                const DFLogo(size: 48),
                const SizedBox(height: AppDimensions.s5),
                Text(
                  'Crea tu cuenta',
                  style: AppTypography.inter(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.8,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: AppDimensions.s1 + 2),
                Text(
                  'Comienza a organizar tu día en menos de un minuto.',
                  style: AppTypography.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textDim,
                  ),
                ),
                const SizedBox(height: AppDimensions.s5),

                DFTextField(
                  label: 'Nombre completo',
                  controller: _nameCtrl,
                  hint: 'Tu nombre',
                  prefixIcon: Icons.person_outline_rounded,
                  textInputAction: TextInputAction.next,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'El nombre es obligatorio';
                    return null;
                  },
                ),
                const SizedBox(height: AppDimensions.s3 - 2),
                DFTextField(
                  label: 'Correo electrónico',
                  controller: _emailCtrl,
                  hint: 'tu@email.com',
                  prefixIcon: Icons.mail_outline_rounded,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'El correo es obligatorio';
                    if (!v.contains('@')) return 'Correo inválido';
                    return null;
                  },
                ),
                const SizedBox(height: AppDimensions.s3 - 2),
                DFTextField(
                  label: 'Contraseña',
                  controller: _passwordCtrl,
                  hint: '••••••••',
                  prefixIcon: Icons.shield_outlined,
                  obscure: true,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _register(),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'La contraseña es obligatoria';
                    if (v.length < 6) return 'Mínimo 6 caracteres';
                    return null;
                  },
                ),
                const SizedBox(height: AppDimensions.s2),
                Text(
                  'Mínimo 6 caracteres.',
                  style: AppTypography.inter(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textMute,
                  ),
                ),

                const SizedBox(height: AppDimensions.s4),
                GestureDetector(
                  onTap: () => setState(() => _accepted = !_accepted),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 2),
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          color: _accepted ? AppColors.blue : Colors.transparent,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: _accepted ? AppColors.blue : AppColors.borderStrong,
                            width: 1.5,
                          ),
                        ),
                        child: _accepted
                            ? const Icon(Icons.check_rounded, size: 12, color: Colors.white)
                            : null,
                      ),
                      const SizedBox(width: AppDimensions.s2 + 2),
                      Expanded(
                        child: Text(
                          'Acepto los términos de servicio y la política de privacidad.',
                          style: AppTypography.inter(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textDim,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppDimensions.s5),

                if (auth.hasError) ...[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppDimensions.s3),
                    decoration: BoxDecoration(
                      color: AppColors.danger.withAlpha(26),
                      borderRadius: BorderRadius.circular(AppDimensions.rSm),
                      border: Border.all(color: AppColors.danger.withAlpha(64)),
                    ),
                    child: Text(
                      auth.error.toString(),
                      style: AppTypography.inter(
                        fontSize: 13,
                        color: AppColors.danger,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppDimensions.s3),
                ],

                DFPrimaryBtn(
                  label: 'Crear cuenta',
                  onTap: _register,
                  isLoading: isLoading,
                ),

                const SizedBox(height: AppDimensions.s5),
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: AppTypography.inter(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textDim,
                      ),
                      children: [
                        const TextSpan(text: '¿Ya tienes cuenta? '),
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () => context.go('/login'),
                            child: Text(
                              'Inicia sesión',
                              style: AppTypography.inter(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w700,
                                color: AppColors.blue,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
