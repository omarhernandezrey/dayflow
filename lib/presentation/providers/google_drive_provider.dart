import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/google_drive_datasource.dart';
import '../../data/repositories/google_drive_repository.dart';

final googleDriveDatasourceProvider = Provider((ref) => GoogleDriveDatasource());

final googleDriveRepositoryProvider = Provider(
  (ref) => GoogleDriveRepository(ref.watch(googleDriveDatasourceProvider)),
);

final googleDriveSignedInProvider = FutureProvider<bool>((ref) async {
  final repo = ref.watch(googleDriveRepositoryProvider);
  final result = await repo.isSignedIn();
  return result.getOrElse(() => false);
});
