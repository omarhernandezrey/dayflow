import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dependency_providers.dart';

final backupOperationProvider =
    AsyncNotifierProvider<BackupOperationNotifier, String?>(BackupOperationNotifier.new);

class BackupOperationNotifier extends AsyncNotifier<String?> {
  @override
  Future<String?> build() async => null;

  Future<void> exportCsv() async {
    state = const AsyncValue.loading();
    final useCase = ref.read(exportToCsvUseCaseProvider);
    final result = await useCase.call();
    state = result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (path) => AsyncValue.data(path),
    );
  }

  Future<void> exportPdf() async {
    state = const AsyncValue.loading();
    final useCase = ref.read(exportToPdfUseCaseProvider);
    final result = await useCase.call();
    state = result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (path) => AsyncValue.data(path),
    );
  }

  Future<void> createBackup() async {
    state = const AsyncValue.loading();
    final useCase = ref.read(createBackupUseCaseProvider);
    final result = await useCase.call();
    state = result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (path) => AsyncValue.data(path),
    );
  }

  Future<void> restoreBackup(String filePath) async {
    state = const AsyncValue.loading();
    final useCase = ref.read(restoreBackupUseCaseProvider);
    final result = await useCase.call(filePath);
    state = result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (_) => const AsyncValue.data(null),
    );
  }
}
