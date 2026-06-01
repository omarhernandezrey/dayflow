import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:csv/csv.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../core/errors/exceptions.dart';

/// Datasource for file operations: CSV export, PDF export, backup ZIP.
class FileDatasource {
  Future<String> exportToCsv({
    required List<Map<String, dynamic>> tasks,
    required List<Map<String, dynamic>> habits,
    required List<Map<String, dynamic>> progress,
  }) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File(join(dir.path, 'dayflow_export_${_timestamp()}.csv'));

      final rows = <List<String>>[
        ['Tipo', 'ID', 'Titulo', 'Categoria/Fecha', 'Estado/Valor', 'Fecha'],
      ];

      for (final t in tasks) {
        rows.add([
          'Tarea',
          t['id'].toString(),
          t['title']?.toString() ?? '',
          t['category']?.toString() ?? '',
          (t['completed'] == 1) ? 'Completada' : 'Pendiente',
          '${t['date']} ${t['time']}',
        ]);
      }

      for (final h in habits) {
        rows.add([
          'Habito',
          h['id'].toString(),
          h['title']?.toString() ?? '',
          h['frequency']?.toString() ?? '',
          'Meta: ${h['goal']}',
          '-',
        ]);
      }

      final csv = const ListToCsvConverter().convert(rows);
      await file.writeAsString(csv);
      return file.path;
    } catch (e, st) {
      throw ExportException('CSV export failed: $e', stackTrace: st);
    }
  }

  Future<String> exportToPdf({
    required List<Map<String, dynamic>> tasks,
    required List<Map<String, dynamic>> habits,
    required List<Map<String, dynamic>> progress,
  }) async {
    try {
      final pdf = pw.Document();
      final completedTasks = tasks.where((t) => t['completed'] == 1).length;
      final totalTasks = tasks.length;

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (context) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('DayFlow — Reporte', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 8),
              pw.Text('Generado: ${_formatDate(DateTime.now())}'),
              pw.SizedBox(height: 16),
              pw.Text('Resumen', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
              pw.Text('Tareas: $completedTasks / $totalTasks completadas'),
              pw.Text('Hábitos: ${habits.length}'),
              pw.SizedBox(height: 16),
              if (tasks.isNotEmpty) ...[
                pw.Text('Tareas', style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 8),
                pw.TableHelper.fromTextArray(
                  headers: ['Titulo', 'Categoria', 'Fecha', 'Estado'],
                  data: tasks.map((t) => [
                    t['title']?.toString() ?? '',
                    t['category']?.toString() ?? '',
                    '${t['date']} ${t['time']}',
                    (t['completed'] == 1) ? 'Completada' : 'Pendiente',
                  ]).toList(),
                ),
              ],
            ],
          ),
        ),
      );

      final dir = await getApplicationDocumentsDirectory();
      final file = File(join(dir.path, 'dayflow_report_${_timestamp()}.pdf'));
      await file.writeAsBytes(await pdf.save());
      return file.path;
    } catch (e, st) {
      throw ExportException('PDF export failed: $e', stackTrace: st);
    }
  }

  Future<String> createBackupZip({
    required String dbFilePath,
    required int timestamp,
  }) async {
    try {
      final dbFile = File(dbFilePath);
      if (!await dbFile.exists()) {
        throw ExportException('Database file not found');
      }

      final dir = await getApplicationDocumentsDirectory();
      final zipPath = join(dir.path, 'dayflow_backup_$timestamp.zip');

      final archive = Archive();
      final dbBytes = await dbFile.readAsBytes();
      archive.addFile(ArchiveFile('dayflow.db', dbBytes.length, dbBytes));

      // Add manifest
      final manifest = '{"version":2,"timestamp":$timestamp,"app":"dayflow"}';
      final manifestBytes = manifest.codeUnits;
      archive.addFile(ArchiveFile('manifest.json', manifestBytes.length, manifestBytes));

      final zipData = ZipEncoder().encode(archive);
      if (zipData == null) throw ExportException('Failed to encode ZIP');

      final zipFile = File(zipPath);
      await zipFile.writeAsBytes(zipData);
      return zipPath;
    } catch (e, st) {
      throw ExportException('Backup creation failed: $e', stackTrace: st);
    }
  }

  Future<void> restoreBackupZip({
    required String backupFilePath,
    required String targetDbPath,
  }) async {
    try {
      final backupFile = File(backupFilePath);
      if (!await backupFile.exists()) {
        throw ImportException('Backup file not found');
      }

      final bytes = await backupFile.readAsBytes();
      final archive = ZipDecoder().decodeBytes(bytes);

      final manifest = archive.findFile('manifest.json');
      if (manifest == null) {
        throw ImportException('Invalid backup: manifest.json missing');
      }

      final dbFile = archive.findFile('dayflow.db');
      if (dbFile == null) {
        throw ImportException('Invalid backup: database file missing');
      }

      // Write restored database
      final targetFile = File(targetDbPath);
      await targetFile.writeAsBytes(dbFile.content as List<int>);
    } catch (e, st) {
      throw ImportException('Restore failed: $e', stackTrace: st);
    }
  }

  static String _timestamp() =>
      DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());

  static String _formatDate(DateTime d) =>
      DateFormat('dd/MM/yyyy HH:mm').format(d);
}
