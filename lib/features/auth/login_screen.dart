import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimensions.dart';
import '../../core/theme/app_typography.dart';
import '../../presentation/providers/auth_provider.dart';
import '../../presentation/providers/biometric_provider.dart';
import '../../presentation/providers/dependency_providers.dart';
import 'auth_widgets.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscure = true; // ignore: prefer_final_fields

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    await ref.read(authStateProvider.notifier).login(
          _emailCtrl.text.trim(),
          _passwordCtrl.text,
        );

    final auth = ref.read(authStateProvider);
    if (auth.hasValue && auth.value != null && mounted) {
      context.go('/home');
    }
  }

  Future<void> _biometricLogin() async {
    final bioRepo = ref.read(biometricRepositoryProvider);
    final authResult = await bioRepo.authenticate();

    final success = authResult.getOrElse(() => false);
    if (!success || !mounted) return;

    // Get most recent user and restore session
    final userCase = ref.read(getMostRecentUserUseCaseProvider);
    final userResult = await userCase.call();
    final user = userResult.getOrElse(() => null);

    if (user == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No hay usuario registrado')),
      );
      return;
    }

    // Restore session by setting current_user_id in settings
    final db = ref.read(localDatabaseProvider);
    await db.rawQuery(
      'INSERT OR REPLACE INTO settings (key, value) VALUES (?, ?)',
      ['current_user_id', user.id.toString()],
    );

    // Refresh auth state
    await ref.read(authStateProvider.notifier).build();

    if (mounted) context.go('/home');
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
                  '¡Hola de nuevo!',
                  style: AppTypography.inter(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.8,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: AppDimensions.s1 + 2),
                Text(
                  'Inicia sesión para continuar con tu progreso.',
                  style: AppTypography.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textDim,
                  ),
                ),
                const SizedBox(height: AppDimensions.s5),

                DFTextField(
                  label: 'Correo electrónico',
                  controller: _emailCtrl,
                  hint: 'tu@email.com',
                  prefixIcon: Icons.person_outline_rounded,
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
                  obscure: _obscure,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _login(),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'La contraseña es obligatoria';
                    if (v.length < 6) return 'Mínimo 6 caracteres';
                    return null;
                  },
                ),

                const SizedBox(height: AppDimensions.s2),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => context.push('/forgot-password'),
                    child: Text(
                      '¿Olvidaste tu contraseña?',
                      style: AppTypography.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blue,
                      ),
                    ),
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
                  label: 'Iniciar sesión',
                  onTap: _login,
                  isLoading: isLoading,
                ),

                // Biometric login
                Consumer(
                  builder: (context, ref, child) {
                    final bioAsync = ref.watch(biometricsAvailableProvider);
                    return bioAsync.when(
                      loading: () => const SizedBox.shrink(),
                      error: (_, _) => const SizedBox.shrink(),
                      data: (available) {
                        if (!available) return const SizedBox.shrink();
                        return Column(
                          children: [
                            const SizedBox(height: AppDimensions.s3),
                            Center(
                              child: GestureDetector(
                                onTap: _biometricLogin,
                                child: Container(
                                  width: 52,
                                  height: 52,
                                  decoration: BoxDecoration(
                                    color: AppColors.surface,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: AppColors.border),
                                  ),
                                  child: const Icon(
                                    Icons.fingerprint_rounded,
                                    color: AppColors.blue,
                                    size: 26,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: AppDimensions.s1),
                            Text(
                              'Usar biometría',
                              style: AppTypography.inter(
                                fontSize: 12,
                                color: AppColors.textDim,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
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
                        const TextSpan(text: '¿Aún no tienes cuenta? '),
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () => context.go('/register'),
                            child: Text(
                              'Regístrate',
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
