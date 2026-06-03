import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googleapis/drive/v3.dart' as drive;

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_typography.dart';
import '../../../l10n/app_localizations.dart';
import '../../providers/backup_provider.dart';
import '../../providers/google_drive_operation_provider.dart';
import '../../providers/google_drive_provider.dart';
import '../../widgets/df_error.dart';

class BackupScreen extends ConsumerWidget {
  const BackupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final backupState = ref.watch(backupOperationProvider);
    final driveAsync = ref.watch(googleDriveOperationProvider);
    final signedInAsync = ref.watch(googleDriveSignedInProvider);

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        foregroundColor: AppColors.text,
        elevation: 0,
        title: Text(l10n.backupTitle, style: AppTypography.heading),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppDimensions.s5),
        children: [
          // ── Local backup ─────────────────────────────────────────
          Text(l10n.backupLocalSection, style: _sectionStyle()),
          const SizedBox(height: AppDimensions.s3),
          _ActionCard(
            icon: Icons.file_download_outlined,
            title: l10n.exportCsv,
            subtitle: l10n.backupExportAllSubtitle,
            onTap: () => ref.read(backupOperationProvider.notifier).exportCsv(),
          ),
          const SizedBox(height: AppDimensions.s3),
          _ActionCard(
            icon: Icons.picture_as_pdf_outlined,
            title: l10n.exportPdf,
            subtitle: l10n.backupReportSubtitle,
            onTap: () => ref.read(backupOperationProvider.notifier).exportPdf(),
          ),
          const SizedBox(height: AppDimensions.s3),
          _ActionCard(
            icon: Icons.backup_outlined,
            title: l10n.createBackup,
            subtitle: l10n.backupFullSubtitle,
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
                      l10n.backupSavedTo(backupState.value!),
                      style: AppTypography.inter(fontSize: 12, color: AppColors.text),
                    ),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: AppDimensions.s5),

          // ── Google Drive ───────────────────────────────────────
          Text(l10n.backupDriveSection, style: _sectionStyle()),
          const SizedBox(height: AppDimensions.s3),

          signedInAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => DFError(message: e.toString(), onRetry: () => ref.invalidate(googleDriveSignedInProvider)),
            data: (isSignedIn) {
              if (!isSignedIn) {
                return _ActionCard(
                  icon: Icons.cloud_upload_outlined,
                  title: l10n.backupConnectDrive,
                  subtitle: l10n.backupSyncSubtitle,
                  onTap: () => ref.read(googleDriveOperationProvider.notifier).signIn(),
                );
              }

              return Column(
                children: [
                  _ActionCard(
                    icon: Icons.cloud_upload_outlined,
                    title: l10n.backupUploadDrive,
                    subtitle: l10n.backupUploadSubtitle,
                    onTap: () async {
                      await ref.read(backupOperationProvider.notifier).createBackup();
                      final localPath = ref.read(backupOperationProvider).valueOrNull;
                      if (localPath != null && localPath.isNotEmpty) {
                        await ref.read(googleDriveOperationProvider.notifier).uploadBackup(localPath);
                      }
                    },
                  ),
                  const SizedBox(height: AppDimensions.s3),
                  _ActionCard(
                    icon: Icons.cloud_off_outlined,
                    title: l10n.backupDisconnectDrive,
                    subtitle: l10n.backupSignOutDrive,
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
                          l10n.noDriveBackups,
                          style: AppTypography.inter(fontSize: 13, color: AppColors.textDim),
                        );
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.driveBackups,
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
            title: l10n.restoreBackupLocal,
            subtitle: l10n.backupSelectZip,
            color: AppColors.danger,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.backupSelectZip, style: AppTypography.body)),
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
    final l10n = AppLocalizations.of(context)!;
    final name = file.name ?? l10n.backupDefaultName;
    final modified = file.modifiedTime;
    final dateStr = modified != null
        ? '${modified.day}/${modified.month}/${modified.year}'
        : '';

    return GestureDetector(
      onTap: () async {
        final path = await ref.read(googleDriveOperationProvider.notifier).downloadBackup(file.id!);
        if (path != null && path.isNotEmpty && context.mounted) {
          final l10n = AppLocalizations.of(context)!;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.backupDownloadedTo(path))),
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