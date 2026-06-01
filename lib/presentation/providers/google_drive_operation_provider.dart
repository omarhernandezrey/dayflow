import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:path_provider/path_provider.dart';

import 'google_drive_provider.dart';

final googleDriveOperationProvider =
    AsyncNotifierProvider<GoogleDriveOperationNotifier, List<drive.File>>(
        GoogleDriveOperationNotifier.new);

class GoogleDriveOperationNotifier extends AsyncNotifier<List<drive.File>> {
  @override
  Future<List<drive.File>> build() async {
    final repo = ref.read(googleDriveRepositoryProvider);
    final signedIn = await repo.isSignedIn();
    final isSignedIn = signedIn.getOrElse(() => false);
    if (!isSignedIn) return [];

    final result = await repo.listBackups();
    return result.getOrElse(() => []);
  }

  Future<void> uploadBackup(String filePath) async {
    state = const AsyncValue.loading();
    final repo = ref.read(googleDriveRepositoryProvider);
    final result = await repo.uploadBackup(filePath);
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (_) => _refresh(),
    );
  }

  Future<String?> downloadBackup(String fileId) async {
    state = const AsyncValue.loading();
    final repo = ref.read(googleDriveRepositoryProvider);
    final dir = await getApplicationDocumentsDirectory();
    final path = '${dir.path}/restore_${DateTime.now().millisecondsSinceEpoch}.zip';
    final result = await repo.downloadBackup(fileId, path);
    state = result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (_) => const AsyncValue.data([]),
    );
    return result.getOrElse(() => '');
  }

  Future<void> signIn() async {
    final repo = ref.read(googleDriveRepositoryProvider);
    final result = await repo.signIn();
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (_) => _refresh(),
    );
  }

  Future<void> signOut() async {
    final repo = ref.read(googleDriveRepositoryProvider);
    await repo.signOut();
    state = const AsyncValue.data([]);
  }

  Future<void> _refresh() async {
    final repo = ref.read(googleDriveRepositoryProvider);
    final result = await repo.listBackups();
    state = AsyncValue.data(result.getOrElse(() => []));
  }
}
