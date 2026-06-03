import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'app.dart';
import 'core/services/home_widget_service.dart';
import 'data/datasources/local_database_impl.dart';
import 'data/repositories/notification_repository_impl.dart';
import 'domain/repositories/notification_repository.dart';
import 'presentation/providers/dependency_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  await initializeDateFormatting('es', null);

  final NotificationRepository notifications = NotificationRepositoryImpl();
  await notifications.init();
  await notifications.requestPermissions();

  try {
    await HomeWidgetService.init();
  } catch (_) {}

  final container = ProviderContainer();
  final db = container.read(localDatabaseProvider);

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const DayFlowApp(),
    ),
  );

  WidgetsBinding.instance.addObserver(_AppLifecycleObserver(db));
}

class _AppLifecycleObserver extends WidgetsBindingObserver {
  final LocalDatabaseImpl _db;

  _AppLifecycleObserver(this._db);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      _db.close();
    }
  }
}