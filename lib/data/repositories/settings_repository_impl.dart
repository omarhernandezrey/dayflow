import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/local_database.dart';
import '../helpers/repository_helper.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final LocalDatabase _db;

  SettingsRepositoryImpl(this._db);

  @override
  Future<Either<Failure, String?>> getString(String key) =>
      executeOrFailure(() async {
        final rows = await _db.rawQuery(
          'SELECT value FROM settings WHERE key = ?',
          [key],
        );
        if (rows.isEmpty) return null;
        return rows.first['value'] as String?;
      });

  @override
  Future<Either<Failure, bool?>> getBool(String key) async {
    final result = await getString(key);
    return result.map((v) => v == null ? null : v == 'true');
  }

  @override
  Future<Either<Failure, int?>> getInt(String key) async {
    final result = await getString(key);
    return result.map((v) => v == null ? null : int.tryParse(v!));
  }

  @override
  Future<Either<Failure, void>> setString(String key, String value) =>
      executeOrFailure(() => _db.rawQuery(
            'INSERT OR REPLACE INTO settings (key, value) VALUES (?, ?)',
            [key, value],
          ));

  @override
  Future<Either<Failure, void>> setBool(String key, bool value) =>
      setString(key, value.toString());

  @override
  Future<Either<Failure, void>> setInt(String key, int value) =>
      setString(key, value.toString());

  @override
  Future<Either<Failure, void>> remove(String key) =>
      executeOrFailure(() => _db.rawQuery('DELETE FROM settings WHERE key = ?', [key]));
}