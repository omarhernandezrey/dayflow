import 'dart:io';

import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:path/path.dart' as p;

/// Datasource for syncing backups with Google Drive.
class GoogleDriveDatasource {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [drive.DriveApi.driveFileScope],
  );

  drive.DriveApi? _driveApi;

  Future<bool> isSignedIn() async => _googleSignIn.isSignedIn();

  Future<void> signIn() async {
    final account = await _googleSignIn.signIn();
    if (account == null) throw Exception('Google Sign-In cancelado');
    final authClient = await _googleSignIn.authenticatedClient();
    if (authClient == null) throw Exception('No se pudo obtener cliente autenticado');
    _driveApi = drive.DriveApi(authClient);
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    _driveApi = null;
  }

  Future<String> uploadBackup(String filePath) async {
    if (_driveApi == null) await signIn();

    final file = File(filePath);
    final bytes = await file.readAsBytes();
    final name = p.basename(filePath);

    // Check if file already exists
    final existing = await _driveApi!.files.list(
      q: "name = '$name' and trashed = false",
      spaces: 'drive',
    );

    final media = drive.Media(Stream.fromIterable([bytes]), bytes.length);

    if (existing.files != null && existing.files!.isNotEmpty) {
      // Update existing
      final fileId = existing.files!.first.id!;
      await _driveApi!.files.update(
        drive.File(),
        fileId,
        uploadMedia: media,
      );
      return fileId;
    } else {
      // Create new
      final driveFile = drive.File()..name = name;
      final result = await _driveApi!.files.create(
        driveFile,
        uploadMedia: media,
      );
      return result.id!;
    }
  }

  Future<String> downloadBackup(String fileId, String destinationPath) async {
    if (_driveApi == null) await signIn();

    final media = await _driveApi!.files.get(
      fileId,
      downloadOptions: drive.DownloadOptions.fullMedia,
    ) as drive.Media;

    final file = File(destinationPath);
    final sink = file.openWrite();
    await media.stream.pipe(sink);
    await sink.close();

    return destinationPath;
  }

  Future<List<drive.File>> listBackups() async {
    if (_driveApi == null) await signIn();

    final result = await _driveApi!.files.list(
      q: "name contains 'dayflow_backup' and trashed = false",
      spaces: 'drive',
      orderBy: 'modifiedTime desc',
      pageSize: 10,
    );

    return result.files ?? [];
  }
}
