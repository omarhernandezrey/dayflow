import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/file_datasource.dart';
import '../../data/datasources/local_database_impl.dart';
import '../../data/repositories/notification_repository_impl.dart';
import '../../domain/repositories/notification_repository.dart';

final localDatabaseProvider = Provider((ref) => LocalDatabaseImpl());
final fileDatasourceProvider = Provider((ref) => FileDatasource());
final notificationRepositoryProvider = Provider<NotificationRepository>((ref) => NotificationRepositoryImpl());