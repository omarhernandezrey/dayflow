import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'app.dart';
import 'core/services/home_widget_service.dart';
import 'data/repositories/notification_repository_impl.dart';
import 'domain/repositories/notification_repository.dart';

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

  // Initialize home screen widget (safe if native config missing)
  try {
    await HomeWidgetService.init();
  } catch (_) {}

  runApp(
    const ProviderScope(
      child: DayFlowApp(),
    ),
  );
}
