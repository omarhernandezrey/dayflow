import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/backup/backup_usecases.dart';
import 'repository_providers.dart';

final exportToCsvUseCaseProvider = Provider((ref) => ExportToCsvUseCase(ref.watch(backupRepositoryProvider)));
final exportToPdfUseCaseProvider = Provider((ref) => ExportToPdfUseCase(ref.watch(backupRepositoryProvider)));
final createBackupUseCaseProvider = Provider((ref) => CreateBackupUseCase(ref.watch(backupRepositoryProvider)));
final restoreBackupUseCaseProvider = Provider((ref) => RestoreBackupUseCase(ref.watch(backupRepositoryProvider)));