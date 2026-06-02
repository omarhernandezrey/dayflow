import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimensions.dart';
import '../../core/theme/app_typography.dart';

// ─── Logo ─────────────────────────────────────────────────────
class DFLogo extends StatelessWidget {
  const DFLogo({super.key, required this.size});
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
      child: Icon(Icons.dashboard_rounded, color: Colors.white, size: size * 0.5),
    );
  }
}

// ─── Back button ──────────────────────────────────────────────
class DFBackBtn extends StatelessWidget {
  const DFBackBtn({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Volver',
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.rSm + 2),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.surface,
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(AppDimensions.rSm + 2),
          ),
          child: const Icon(Icons.chevron_left_rounded, color: AppColors.text, size: 20),
        ),
      ),
    );
  }
}

// ─── Text field (REAL editable) ───────────────────────────────
class DFTextField extends StatelessWidget {
  const DFTextField({
    super.key,
    required this.label,
    this.controller,
    this.hint,
    this.prefixIcon,
    this.obscure = false,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.onSubmitted,
    this.autofocus = false,
  });

  final String label;
  final TextEditingController? controller;
  final String? hint;
  final IconData? prefixIcon;
  final bool obscure;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final void Function(String)? onSubmitted;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: AppTypography.inter(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: AppColors.textDim,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: AppDimensions.s2),
        TextFormField(
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          validator: validator,
          onFieldSubmitted: onSubmitted,
          autofocus: autofocus,
          style: AppTypography.inter(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: AppColors.text,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.surface,
            hintText: hint,
            hintStyle: AppTypography.inter(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: AppColors.textMute,
            ),
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, size: 18, color: AppColors.textDim)
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.rSm + 2),
              borderSide: const BorderSide(color: AppColors.border, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.rSm + 2),
              borderSide: const BorderSide(color: AppColors.border, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.rSm + 2),
              borderSide: const BorderSide(color: AppColors.blue, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.rSm + 2),
              borderSide: const BorderSide(color: AppColors.danger, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.rSm + 2),
              borderSide: const BorderSide(color: AppColors.danger, width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.s4,
              vertical: AppDimensions.s3 + 2,
            ),
            errorStyle: AppTypography.inter(
              fontSize: 12,
              color: AppColors.danger,
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Primary button ───────────────────────────────────────────
class DFPrimaryBtn extends StatelessWidget {
  const DFPrimaryBtn({
    super.key,
    required this.label,
    this.onTap,
    this.color,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onTap;
  final Color? color;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.blue;
    return Semantics(
      button: true,
      label: label,
      child: InkWell(
        onTap: isLoading ? null : onTap,
        borderRadius: BorderRadius.circular(AppDimensions.rMd),
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
          child: isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: Colors.white,
                  ),
                )
              : Text(
                  label,
                  style: AppTypography.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.2,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
