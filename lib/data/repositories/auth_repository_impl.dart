import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';

import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/validators/validators.dart';
import '../datasources/local_database.dart';
import '../helpers/repository_helper.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final LocalDatabase _db;

  AuthRepositoryImpl(this._db);

  static const String _sessionKey = 'current_user_id';

  String _generateSalt() {
    final random = Random.secure();
    final saltBytes = List<int>.generate(32, (_) => random.nextInt(256));
    return saltBytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }

  String _hashPassword(String password, String salt) {
    final bytes = utf8.encode(salt + password);
    final digest = sha256.convert(bytes);
    return '$salt:${digest.toString()}';
  }

  bool _verifyPassword(String password, String storedHash) {
    if (storedHash.contains(':')) {
      final colonIndex = storedHash.indexOf(':');
      final salt = storedHash.substring(0, colonIndex);
      final hash = storedHash.substring(colonIndex + 1);
      final computedHash =
          sha256.convert(utf8.encode(salt + password)).toString();
      return hash == computedHash;
    } else {
      final hash = sha256.convert(utf8.encode(password)).toString();
      return storedHash == hash;
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      if (!Validators.isNotEmpty(name)) {
        return const Left(ValidationFailure('El nombre es obligatorio'));
      }
      if (!Validators.isValidEmail(email)) {
        return const Left(ValidationFailure('Correo electrónico inválido'));
      }
      if (!Validators.isValidPassword(password)) {
        return const Left(
            ValidationFailure('La contraseña debe tener al menos 6 caracteres'));
      }

      final existing = await _db
          .queryUsers(where: 'email = ?', whereArgs: [email.trim().toLowerCase()]);
      if (existing.isNotEmpty) {
        return const Left(
            ValidationFailure('Ya existe una cuenta con este correo'));
      }

      final salt = _generateSalt();
      final hash = _hashPassword(password, salt);
      final model = UserModel(
        name: name.trim(),
        email: email.trim().toLowerCase(),
        passwordHash: hash,
        createdAt: DateTime.now().toIso8601String(),
      );

      final id = await _db.insertUser(model.toMap()..remove('id'));
      final user = model.copyWith(id: id);

      await _db.rawQuery(
        'INSERT OR REPLACE INTO settings (key, value) VALUES (?, ?)',
        [_sessionKey, id.toString()],
      );

      return Right(user.toEntity());
    } on AppException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e, st) {
      return Left(UnexpectedFailure(e.toString(), stackTrace: st));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final rows = await _db.queryUsers(
        where: 'email = ?',
        whereArgs: [email.trim().toLowerCase()],
      );
      if (rows.isEmpty) {
        return const Left(
            ValidationFailure('Correo o contraseña incorrectos'));
      }

      final user = UserModel.fromMap(rows.first);
      if (!_verifyPassword(password, user.passwordHash)) {
        return const Left(
            ValidationFailure('Correo o contraseña incorrectos'));
      }

      if (!user.passwordHash.contains(':')) {
        final salt = _generateSalt();
        final newHash = _hashPassword(password, salt);
        await _db.rawQuery(
          'UPDATE users SET password_hash = ? WHERE id = ?',
          [newHash, user.id],
        );
      }

      await _db.rawQuery(
        'INSERT OR REPLACE INTO settings (key, value) VALUES (?, ?)',
        [_sessionKey, user.id.toString()],
      );

      return Right(user.toEntity());
    } on AppException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e, st) {
      return Left(UnexpectedFailure(e.toString(), stackTrace: st));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _db
          .rawQuery('DELETE FROM settings WHERE key = ?', [_sessionKey]);
      return const Right(null);
    } on AppException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e, st) {
      return Left(UnexpectedFailure(e.toString(), stackTrace: st));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    try {
      final session = await _db.rawQuery(
        'SELECT value FROM settings WHERE key = ?',
        [_sessionKey],
      );
      if (session.isEmpty) return const Right(null);

      final userId = int.tryParse(session.first['value'] as String);
      if (userId == null) return const Right(null);

      final rows =
          await _db.queryUsers(where: 'id = ?', whereArgs: [userId]);
      if (rows.isEmpty) return const Right(null);

      return Right(UserModel.fromMap(rows.first).toEntity());
    } on AppException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e, st) {
      return Left(UnexpectedFailure(e.toString(), stackTrace: st));
    }
  }

  @override
  Future<Either<Failure, bool>> isAuthenticated() async {
    try {
      final session = await _db.rawQuery(
        'SELECT value FROM settings WHERE key = ?',
        [_sessionKey],
      );
      return Right(session.isNotEmpty);
    } on AppException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e, st) {
      return Left(UnexpectedFailure(e.toString(), stackTrace: st));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getMostRecentUser() async {
    try {
      final rows = await _db.queryUsers(orderBy: 'id DESC', limit: 1);
      if (rows.isEmpty) return const Right(null);
      return Right(UserModel.fromMap(rows.first).toEntity());
    } on AppException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e, st) {
      return Left(UnexpectedFailure(e.toString(), stackTrace: st));
    }
  }

  @override
  Future<Either<Failure, void>> restoreSession(int userId) async {
    try {
      await _db.rawQuery(
        'INSERT OR REPLACE INTO settings (key, value) VALUES (?, ?)',
        [_sessionKey, userId.toString()],
      );
      return const Right(null);
    } on AppException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e, st) {
      return Left(UnexpectedFailure(e.toString(), stackTrace: st));
    }
  }
}