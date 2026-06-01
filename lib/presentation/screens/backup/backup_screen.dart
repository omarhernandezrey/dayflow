import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googleapis/drive/v3.dart' as drive;

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_typography.dart';
import '../../providers/backup_provider.dart';
import '../../providers/google_drive_operation_provider.dart';
import '../../providers/google_drive_provider.dart';
import '../../widgets/df_error.dart';

class BackupScreen extends ConsumerWidget {
  const BackupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backupState = ref.watch(backupOperationProvider);
    final driveAsync = ref.watch(googleDriveOperationProvider);
    final signedInAsync = ref.watch(googleDriveSignedInProvider);

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        foregroundColor: AppColors.text,
        elevation: 0,
        title: Text('Copia de seguridad', style: AppTypography.heading),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppDimensions.s5),
        children: [
          // ── Local backup ─────────────────────────────────────────
          Text('LOCAL', style: _sectionStyle()),
          const SizedBox(height: AppDimensions.s3),
          _ActionCard(
            icon: Icons.file_download_outlined,
            title: 'Exportar a CSV',
            subtitle: 'Exporta todas tus tareas y hábitos',
            onTap: () => ref.read(backupOperationProvider.notifier).exportCsv(),
          ),
          const SizedBox(height: AppDimensions.s3),
          _ActionCard(
            icon: Icons.picture_as_pdf_outlined,
            title: 'Exportar a PDF',
            subtitle: 'Genera un reporte visual',
            onTap: () => ref.read(backupOperationProvider.notifier).exportPdf(),
          ),
          const SizedBox(height: AppDimensions.s3),
          _ActionCard(
            icon: Icons.backup_outlined,
            title: 'Crear backup ZIP',
            subtitle: 'Copia completa de la base de datos',
            onTap: () => ref.read(backupOperationProvider.notifier).createBackup(),
          ),

          // Local result
          if (backupState.hasValue && backupState.value != null) ...[
            const SizedBox(height: AppDimensions.s3),
            Container(
              padding: const EdgeInsets.all(AppDimensions.s4),
              decoration: BoxDecoration(
                color: AppColors.catHealth.withAlpha(26),
                borderRadius: BorderRadius.circular(AppDimensions.rMd),
                border: Border.all(color: AppColors.catHealth.withAlpha(64)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle_rounded, color: AppColors.success),
                  const SizedBox(width: AppDimensions.s3),
                  Expanded(
                    child: Text(
                      'Guardado:\n${backupState.value}',
                      style: AppTypography.inter(fontSize: 12, color: AppColors.text),
                    ),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: AppDimensions.s5),

          // ── Google Drive ───────────────────────────────────────
          Text('GOOGLE DRIVE', style: _sectionStyle()),
          const SizedBox(height: AppDimensions.s3),

          signedInAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => DFError(message: e.toString(), onRetry: () => ref.invalidate(googleDriveSignedInProvider)),
            data: (isSignedIn) {
              if (!isSignedIn) {
                return _ActionCard(
                  icon: Icons.cloud_upload_outlined,
                  title: 'Conectar con Google Drive',
                  subtitle: 'Sincroniza tus backups en la nube',
                  onTap: () => ref.read(googleDriveOperationProvider.notifier).signIn(),
                );
              }

              return Column(
                children: [
                  _ActionCard(
                    icon: Icons.cloud_upload_outlined,
                    title: 'Subir backup a Drive',
                    subtitle: 'Crea backup local y súbelo',
                    onTap: () async {
                      // 1. Create local backup
                      await ref.read(backupOperationProvider.notifier).createBackup();
                      final localPath = ref.read(backupOperationProvider).valueOrNull;
                      if (localPath != null && localPath.isNotEmpty) {
                        // 2. Upload to Drive
                        await ref.read(googleDriveOperationProvider.notifier).uploadBackup(localPath);
                      }
                    },
                  ),
                  const SizedBox(height: AppDimensions.s3),
                  _ActionCard(
                    icon: Icons.cloud_off_outlined,
                    title: 'Desconectar Google Drive',
                    subtitle: 'Cerrar sesión de Google',
                    color: AppColors.danger,
                    onTap: () => ref.read(googleDriveOperationProvider.notifier).signOut(),
                  ),
                  const SizedBox(height: AppDimensions.s4),
                  driveAsync.when(
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (e, _) => DFError(message: e.toString(), onRetry: () => ref.invalidate(googleDriveOperationProvider)),
                    data: (files) {
                      if (files.isEmpty) {
                        return Text(
                          'No hay backups en Drive',
                          style: AppTypography.inter(fontSize: 13, color: AppColors.textDim),
                        );
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Backups en Drive',
                            style: AppTypography.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textDim,
                            ),
                          ),
                          const SizedBox(height: AppDimensions.s2),
                          ...files.map((f) => _DriveFileTile(file: f)),
                        ],
                      );
                    },
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: AppDimensions.s5),

          // ── Restore local ────────────────────────────────────────
          _ActionCard(
            icon: Icons.restore_outlined,
            title: 'Restaurar backup local',
            subtitle: 'Selecciona un archivo .zip',
            color: AppColors.danger,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Selecciona un archivo .zip', style: AppTypography.body)),
              );
            },
          ),
        ],
      ),
    );
  }

  TextStyle _sectionStyle() => AppTypography.inter(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: AppColors.textDim,
        letterSpacing: 0.8,
      );
}

class _DriveFileTile extends ConsumerWidget {
  const _DriveFileTile({required this.file});
  final drive.File file;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = file.name ?? 'Backup';
    final modified = file.modifiedTime;
    final dateStr = modified != null
        ? '${modified.day}/${modified.month}/${modified.year}'
        : '';

    return GestureDetector(
      onTap: () async {
        final path = await ref.read(googleDriveOperationProvider.notifier).downloadBackup(file.id!);
        if (path != null && path.isNotEmpty && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Descargado a: $path')),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: AppDimensions.s2),
        padding: const EdgeInsets.all(AppDimensions.s3),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimensions.rMd),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            const Icon(Icons.cloud_done_outlined, color: AppColors.blue, size: 20),
            const SizedBox(width: AppDimensions.s3),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppTypography.inter(fontSize: 13.5, fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (dateStr.isNotEmpty)
                    Text(
                      dateStr,
                      style: AppTypography.inter(fontSize: 11.5, color: AppColors.textDim),
                    ),
                ],
              ),
            ),
            const Icon(Icons.download_outlined, color: AppColors.textDim, size: 18),
          ],
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.color,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.s4),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimensions.rLg - 2),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: (color ?? AppColors.blue).withAlpha(26),
                borderRadius: BorderRadius.circular(AppDimensions.rSm),
              ),
              child: Icon(icon, color: color ?? AppColors.blue),
            ),
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
            const Icon(Icons.chevron_right_rounded, color: AppColors.textDim),
          ],
        ),
      ),
    );
  }
}
