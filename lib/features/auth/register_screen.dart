import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimensions.dart';
import '../../core/theme/app_typography.dart';
import '../../l10n/app_localizations.dart';
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
        SnackBar(content: Text(AppLocalizations.of(context)!.termsRequired)),
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
    final l10n = AppLocalizations.of(context)!;
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
                  l10n.registerTitle,
                  style: AppTypography.inter(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.8,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: AppDimensions.s1 + 2),
                Text(
                  l10n.registerSubtitle,
                  style: AppTypography.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textDim,
                  ),
                ),
                const SizedBox(height: AppDimensions.s5),

                DFTextField(
                  label: l10n.nameLabel,
                  controller: _nameCtrl,
                  hint: l10n.nameHint,
                  prefixIcon: Icons.person_outline_rounded,
                  textInputAction: TextInputAction.next,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return l10n.nameRequired;
                    return null;
                  },
                ),
                const SizedBox(height: AppDimensions.s3 - 2),
                DFTextField(
                  label: l10n.emailLabel,
                  controller: _emailCtrl,
                  hint: l10n.emailHint,
                  prefixIcon: Icons.mail_outline_rounded,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return l10n.emailRequired;
                    if (!v.contains('@')) return l10n.emailInvalid;
                    return null;
                  },
                ),
                const SizedBox(height: AppDimensions.s3 - 2),
                DFTextField(
                  label: l10n.passwordLabel,
                  controller: _passwordCtrl,
                  hint: '••••••••',
                  prefixIcon: Icons.shield_outlined,
                  obscure: true,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _register(),
                  validator: (v) {
                    if (v == null || v.isEmpty) return l10n.passwordRequired;
                    if (v.length < 6) return l10n.passwordMinLength;
                    return null;
                  },
                ),
                const SizedBox(height: AppDimensions.s2),
                Text(
                  l10n.passwordMinLengthDot,
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
                          l10n.termsAccepted,
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
                  label: l10n.registerButton,
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
                        TextSpan(text: l10n.alreadyHaveAccountLogin),
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () => context.go('/login'),
                            child: Text(
                              l10n.loginLink,
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
