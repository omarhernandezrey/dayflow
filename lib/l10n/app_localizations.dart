import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    AppLocalizationsDelegate(),
    DefaultMaterialLocalizations.delegate,
    DefaultWidgetsLocalizations.delegate,
  ];

  static const List<Locale> supportedLocales = [
    Locale('es', 'ES'),
    Locale('en', 'US'),
  ];

  static final Map<String, Map<String, String>> _localizedValues = {
    'es': {
      'appName': 'DayFlow',
      'loginTitle': '¡Hola de nuevo!',
      'loginSubtitle': 'Inicia sesión para continuar con tu progreso.',
      'loginButton': 'Iniciar sesión',
      'registerButton': 'Regístrate',
      'forgotPassword': '¿Olvidaste tu contraseña?',
      'biometricPrompt': 'Usar biometría',
      'noUserRegistered': 'No hay usuario registrado',
      'emailLabel': 'Correo electrónico',
      'emailHint': 'tu@email.com',
      'passwordLabel': 'Contraseña',
      'passwordHint': '••••••••',
      'emailRequired': 'El correo es obligatorio',
      'emailInvalid': 'Correo inválido',
      'passwordRequired': 'La contraseña es obligatoria',
      'passwordMinLength': 'Mínimo 6 caracteres',
      'passwordMinLengthDot': 'Mínimo 6 caracteres.',
      'nameLabel': 'Nombre completo',
      'nameRequired': 'El nombre es obligatorio',
      'nameHint': 'Tu nombre',
      'registerTitle': 'Crear cuenta',
      'registerSubtitle': 'Comienza a organizar tu día en menos de un minuto.',
      'alreadyHaveAccount': '¿Aún no tienes cuenta? ',
      'alreadyHaveAccountLogin': '¿Ya tienes cuenta? ',
      'loginLink': 'Inicia sesión',
      'termsAccepted': 'Acepto los términos de servicio y la política de privacidad.',
      'termsRequired': 'Debes aceptar los términos',
      'logoutConfirm': '¿Cerrar sesión?',
      'logoutMessage': 'Perderás el acceso hasta que inicies sesión de nuevo.',
      'cancelButton': 'Cancelar',
      'confirmButton': 'Confirmar',
      'deleteButton': 'Eliminar',
      'saveButton': 'Guardar',
      'homeTab': 'Inicio',
      'tasksTab': 'Tareas',
      'habitsTab': 'Hábitos',
      'statsTab': 'Stats',
      'moreTab': 'Más',
      'helloTitle': '¡Hola!',
      'upcomingActivities': 'Próximas actividades',
      'noActivitiesToday': 'No tienes actividades pendientes hoy',
      'goodJobDay': '¡Buen trabajo! Disfruta tu día.',
      'totalActivities': 'Actividades\ntotales',
      'addTaskTitle': 'Nueva tarea',
      'editTaskTitle': 'Editar tarea',
      'taskTitleLabel': 'Título',
      'taskTitleHint': 'Nombre de la actividad',
      'taskDescLabel': 'Descripción',
      'taskDescHint': 'Descripción opcional…',
      'taskCategoryLabel': 'Categoría',
      'taskDateLabel': 'Fecha',
      'taskTimeLabel': 'Hora',
      'taskReminderLabel': 'Recordatorio',
      'saveTaskCreate': 'Guardar actividad',
      'saveTaskEdit': 'Guardar cambios',
      'taskTitleRequired': 'El título es obligatorio',
      'addHabitTitle': 'Nuevo hábito',
      'editHabitTitle': 'Editar hábito',
      'habitNameLabel': 'Nombre del hábito',
      'habitNameHint': 'Nombre del hábito…',
      'habitGoalLabel': 'Meta diaria',
      'habitUnitLabel': 'Unidad',
      'habitFrequencyLabel': 'Frecuencia',
      'habitIconLabel': 'Icono',
      'saveHabitCreate': 'Crear hábito',
      'saveHabitEdit': 'Guardar cambios',
      'habitNameRequired': 'El nombre es obligatorio',
      'streakLabel': 'Racha',
      'globalStreakLabel': 'Racha global',
      'dailyStreak': 'RACHA DIARIA',
      'daysInARow': 'días seguidos',
      'completedLabel': 'Completado',
      'completedExclamation': '¡Completado!',
      'pendingLabel': 'Pendiente',
      'noTasksTitle': 'No tienes tareas',
      'noTasksSubtitle': 'Agrega tu primera tarea para empezar',
      'noTasksAction': 'Agregar tarea',
      'filterAll': 'Todas',
      'today': 'Hoy',
      'tomorrow': 'Mañana',
      'later': 'Más adelante',
      'taskCompleted': 'Tarea completada',
      'taskMarkComplete': 'Marcar tarea como completada',
      'noHabitsTitle': 'No tienes hábitos para hoy',
      'noHabitsSubtitle': 'Crea un hábito y empieza tu racha',
      'noHabitsAction': 'Crear hábito',
      'todayHabits': 'Hábitos de hoy',
      'allMyHabits': 'Todos mis hábitos',
      'deleteHabit': 'Eliminar hábito',
      'labelPersonal': 'Personal',
      'labelAcademic': 'Académica',
      'labelHealth': 'Salud',
      'frequencyDaily': 'Diario',
      'frequencyWeekly': 'Semanal',
      'frequencyCustom': 'Personalizado',
      'reminder5min': '5 min',
      'reminder15min': '15 min',
      'reminder30min': '30 min',
      'reminder60min': '60 min',
      'timeOnce': 'vez',
      'timeTimes': 'veces',
      'dayMon': 'L',
      'dayTue': 'M',
      'dayWed': 'X',
      'dayThu': 'J',
      'dayFri': 'V',
      'daySat': 'S',
      'daySun': 'D',
      'statsTitle': 'Estadísticas',
      'completedPercent': 'Completado',
      'weeklyStats': 'Cumplimiento semanal',
      'noDataWeek': 'Sin datos esta semana',
      'statsTotal': 'Total',
      'statsWeek': 'Esta semana',
      'achievementsTitle': 'Logros',
      'achievementsUnlocked': 'desbloqueados',
      'achievementsUnlockedTab': 'Desbloqueados',
      'achievementsLockedTab': 'Bloqueados',
      'noAchievementsTitle': 'Sin logros',
      'noAchievementsSubtitle': 'Completa tareas y hábitos para desbloquear logros',
      'moreTitle': 'Más',
      'personalizationSection': 'Personalización',
      'appearanceTitle': 'Apariencia',
      'themeLight': 'Claro',
      'themeDark': 'Oscuro',
      'themeSystem': 'Sistema',
      'themeSheetTitle': 'Tema',
      'dataSection': 'Datos',
      'backupTitle': 'Copia de seguridad',
      'backupSubtitle': 'Exportar y restaurar',
      'exportDataTitle': 'Exportar datos',
      'exportDataSubtitle': 'CSV y PDF',
      'progressSection': 'Progreso',
      'calendarTitle': 'Calendario',
      'calendarSubtitle': 'Vista mensual y semanal',
      'accountSection': 'Cuenta',
      'logoutTitle': 'Cerrar sesión',
      'logoutSubtitle': 'Salir de la aplicación',
      'profileTitle': 'Perfil',
      'recentMember': 'Miembro reciente',
      'currentStreak': 'Racha actual',
      'achievementsCount': 'Logros',
      'settingsShortcut': 'Configuración',
      'privacyShortcut': 'Privacidad',
      'helpShortcut': 'Ayuda',
      'backupLocalSection': 'LOCAL',
      'backupExportAllSubtitle': 'Exporta todas tus tareas y hábitos',
      'backupReportSubtitle': 'Genera un reporte visual',
      'backupFullSubtitle': 'Copia completa de la base de datos',
      'backupDriveSection': 'GOOGLE DRIVE',
      'backupConnectDrive': 'Conectar con Google Drive',
      'backupSyncSubtitle': 'Sincroniza tus backups en la nube',
      'backupUploadDrive': 'Subir backup a Drive',
      'backupUploadSubtitle': 'Crea backup local y súbelo',
      'backupDisconnectDrive': 'Desconectar Google Drive',
      'backupSignOutDrive': 'Cerrar sesión de Google',
      'noDriveBackups': 'No hay backups en Drive',
      'driveBackups': 'Backups en Drive',
      'backupSelectZip': 'Selecciona un archivo .zip',
      'backupDefaultName': 'Backup',
      'exportCsv': 'Exportar a CSV',
      'exportPdf': 'Exportar a PDF',
      'createBackup': 'Crear backup ZIP',
      'restoreBackupLocal': 'Restaurar backup local',
      'taskDetailTitle': 'Detalle',
      'taskDetailReminder': 'minutos antes',
      'taskDetailStatus': 'Estado',
      'taskDetailCompleted': 'Completada ✓',
      'taskDetailEdit': 'Editar',
      'taskDetailComplete': 'Completar',
      'taskDetailCompletedAction': 'Completada',
      'splashTagline': 'Organiza tu día.\nConstruye mejores hábitos.',
      'splashOffline': 'Sin conexión',
      'splashPrivate': '100% privado',
      'splashReminders': 'Recordatorios',
      'splashGetStarted': 'Comenzar',
      'splashHaveAccount': 'Ya tengo una cuenta',
      'splashTermsPrefix': 'Al continuar aceptas los ',
      'splashTermsLink': 'Términos',
      'splashTermsAnd': ' y la ',
      'splashPrivacyLink': 'Política de privacidad',
      'forgotPasswordTitle': 'Recupera tu acceso',
      'forgotPasswordBody': 'DayFlow funciona de forma offline. Si olvidaste tu contraseña, no podemos enviar un correo de recuperación. Te recomendamos crear una nueva cuenta.',
      'forgotPasswordBack': 'Volver a iniciar sesión',
      'forgotPasswordCreateAccount': 'Crear nueva cuenta',
      'backBtn': 'Volver',
      'biometricLoginLabel': 'Iniciar sesión con biometría',
      'navDrawerProfile': 'Mi perfil',
      'navDrawerProfileSub': 'Datos personales',
      'navDrawerAchievements': 'Logros',
      'navDrawerAchievementsSub': 'Ver progreso',
      'navDrawerAppearance': 'Apariencia',
      'navDrawerAppearanceSub': 'Tema oscuro',
      'navDrawerNotifications': 'Notificaciones',
      'navDrawerNotificationsSub': 'Activadas',
      'navDrawerCategories': 'Categorías',
      'navDrawerCategoriesSub': 'Personal, Académica, Salud',
      'navDrawerPrivacy': 'Privacidad y datos',
      'navDrawerPrivacySub': 'Almacenamiento local',
      'navDrawerHelp': 'Ayuda y soporte',
      'navDrawerHelpSub': 'Centro de ayuda',
      'navDrawerLogout': 'Cerrar sesión',
      'pageNotFound': 'Pantalla no encontrada',
      'noPendingTasks': 'Sin tareas pendientes',
      'errorTitle': 'Algo salió mal',
      'retryButton': 'Reintentar',
      'validationNameEmpty': 'El nombre es obligatorio',
      'validationEmailInvalid': 'Correo electrónico inválido',
      'validationPasswordShort': 'La contraseña debe tener al menos 6 caracteres',
      'validationHabitTitle': 'El nombre del hábito es obligatorio',
      'validationHabitGoal': 'La meta debe ser mayor a 0',
      'validationTaskTitle': 'El título es obligatorio',
      'validationTaskDate': 'La fecha y hora son obligatorias',
      'emailInUse': 'Ya existe una cuenta con este correo',
      'invalidCredentials': 'Correo o contraseña incorrectos',
      'sessionRestoreError': 'Error al restaurar sesión',
      'monthJanuary': 'enero',
      'monthFebruary': 'febrero',
      'monthMarch': 'marzo',
      'monthApril': 'abril',
      'monthMay': 'mayo',
      'monthJune': 'junio',
      'monthJuly': 'julio',
      'monthAugust': 'agosto',
      'monthSeptember': 'septiembre',
      'monthOctober': 'octubre',
      'monthNovember': 'noviembre',
      'monthDecember': 'diciembre',
    },
    'en': {
      'appName': 'DayFlow',
      'loginTitle': 'Welcome back!',
      'loginSubtitle': 'Sign in to continue your progress.',
      'loginButton': 'Sign in',
      'registerButton': 'Sign up',
      'forgotPassword': 'Forgot your password?',
      'biometricPrompt': 'Use biometrics',
      'noUserRegistered': 'No registered user',
      'emailLabel': 'Email',
      'emailHint': 'you@email.com',
      'passwordLabel': 'Password',
      'passwordHint': '••••••••',
      'emailRequired': 'Email is required',
      'emailInvalid': 'Invalid email',
      'passwordRequired': 'Password is required',
      'passwordMinLength': 'Minimum 6 characters',
      'passwordMinLengthDot': 'Minimum 6 characters.',
      'nameLabel': 'Full name',
      'nameRequired': 'Name is required',
      'nameHint': 'Your name',
      'registerTitle': 'Create account',
      'registerSubtitle': 'Start organizing your day in less than a minute.',
      'alreadyHaveAccount': "Don't have an account yet? ",
      'alreadyHaveAccountLogin': 'Already have an account? ',
      'loginLink': 'Sign in',
      'termsAccepted': 'I accept the terms of service and privacy policy.',
      'termsRequired': 'You must accept the terms',
      'logoutConfirm': 'Log out?',
      'logoutMessage': 'You will lose access until you sign in again.',
      'cancelButton': 'Cancel',
      'confirmButton': 'Confirm',
      'deleteButton': 'Delete',
      'saveButton': 'Save',
      'homeTab': 'Home',
      'tasksTab': 'Tasks',
      'habitsTab': 'Habits',
      'statsTab': 'Stats',
      'moreTab': 'More',
      'helloTitle': 'Hello!',
      'upcomingActivities': 'Upcoming activities',
      'noActivitiesToday': 'No pending activities today',
      'goodJobDay': 'Great job! Enjoy your day.',
      'totalActivities': 'Total\nactivities',
      'addTaskTitle': 'New task',
      'editTaskTitle': 'Edit task',
      'taskTitleLabel': 'Title',
      'taskTitleHint': 'Activity name',
      'taskDescLabel': 'Description',
      'taskDescHint': 'Optional description…',
      'taskCategoryLabel': 'Category',
      'taskDateLabel': 'Date',
      'taskTimeLabel': 'Time',
      'taskReminderLabel': 'Reminder',
      'saveTaskCreate': 'Save activity',
      'saveTaskEdit': 'Save changes',
      'taskTitleRequired': 'Title is required',
      'addHabitTitle': 'New habit',
      'editHabitTitle': 'Edit habit',
      'habitNameLabel': 'Habit name',
      'habitNameHint': 'Habit name…',
      'habitGoalLabel': 'Daily goal',
      'habitUnitLabel': 'Unit',
      'habitFrequencyLabel': 'Frequency',
      'habitIconLabel': 'Icon',
      'saveHabitCreate': 'Create habit',
      'saveHabitEdit': 'Save changes',
      'habitNameRequired': 'Habit name is required',
      'streakLabel': 'Streak',
      'globalStreakLabel': 'Global streak',
      'dailyStreak': 'DAILY STREAK',
      'daysInARow': 'days in a row',
      'completedLabel': 'Completed',
      'completedExclamation': 'Completed!',
      'pendingLabel': 'Pending',
      'noTasksTitle': 'You have no tasks',
      'noTasksSubtitle': 'Add your first task to get started',
      'noTasksAction': 'Add task',
      'filterAll': 'All',
      'today': 'Today',
      'tomorrow': 'Tomorrow',
      'later': 'Later',
      'taskCompleted': 'Task completed',
      'taskMarkComplete': 'Mark task as complete',
      'noHabitsTitle': 'No habits for today',
      'noHabitsSubtitle': 'Create a habit and start your streak',
      'noHabitsAction': 'Create habit',
      'todayHabits': "Today's habits",
      'allMyHabits': 'All my habits',
      'deleteHabit': 'Delete habit',
      'labelPersonal': 'Personal',
      'labelAcademic': 'Academic',
      'labelHealth': 'Health',
      'frequencyDaily': 'Daily',
      'frequencyWeekly': 'Weekly',
      'frequencyCustom': 'Custom',
      'reminder5min': '5 min',
      'reminder15min': '15 min',
      'reminder30min': '30 min',
      'reminder60min': '60 min',
      'timeOnce': 'time',
      'timeTimes': 'times',
      'dayMon': 'M',
      'dayTue': 'T',
      'dayWed': 'W',
      'dayThu': 'T',
      'dayFri': 'F',
      'daySat': 'S',
      'daySun': 'S',
      'statsTitle': 'Statistics',
      'completedPercent': 'Completed',
      'weeklyStats': 'Weekly completion',
      'noDataWeek': 'No data this week',
      'statsTotal': 'Total',
      'statsWeek': 'This week',
      'achievementsTitle': 'Achievements',
      'achievementsUnlocked': 'unlocked',
      'achievementsUnlockedTab': 'Unlocked',
      'achievementsLockedTab': 'Locked',
      'noAchievementsTitle': 'No achievements',
      'noAchievementsSubtitle': 'Complete tasks and habits to unlock achievements',
      'moreTitle': 'More',
      'personalizationSection': 'Personalization',
      'appearanceTitle': 'Appearance',
      'themeLight': 'Light',
      'themeDark': 'Dark',
      'themeSystem': 'System',
      'themeSheetTitle': 'Theme',
      'dataSection': 'Data',
      'backupTitle': 'Backup',
      'backupSubtitle': 'Export and restore',
      'exportDataTitle': 'Export data',
      'exportDataSubtitle': 'CSV and PDF',
      'progressSection': 'Progress',
      'calendarTitle': 'Calendar',
      'calendarSubtitle': 'Monthly and weekly view',
      'accountSection': 'Account',
      'logoutTitle': 'Log out',
      'logoutSubtitle': 'Leave the app',
      'profileTitle': 'Profile',
      'recentMember': 'Recent member',
      'currentStreak': 'Current streak',
      'achievementsCount': 'Achievements',
      'settingsShortcut': 'Settings',
      'privacyShortcut': 'Privacy',
      'helpShortcut': 'Help',
      'backupLocalSection': 'LOCAL',
      'backupExportAllSubtitle': 'Export all your tasks and habits',
      'backupReportSubtitle': 'Generate a visual report',
      'backupFullSubtitle': 'Full database copy',
      'backupDriveSection': 'GOOGLE DRIVE',
      'backupConnectDrive': 'Connect to Google Drive',
      'backupSyncSubtitle': 'Sync your backups to the cloud',
      'backupUploadDrive': 'Upload backup to Drive',
      'backupUploadSubtitle': 'Create local backup and upload',
      'backupDisconnectDrive': 'Disconnect Google Drive',
      'backupSignOutDrive': 'Sign out of Google',
      'noDriveBackups': 'No backups on Drive',
      'driveBackups': 'Backups on Drive',
      'backupSelectZip': 'Select a .zip file',
      'backupDefaultName': 'Backup',
      'exportCsv': 'Export to CSV',
      'exportPdf': 'Export to PDF',
      'createBackup': 'Create ZIP backup',
      'restoreBackupLocal': 'Restore local backup',
      'taskDetailTitle': 'Detail',
      'taskDetailReminder': 'minutes before',
      'taskDetailStatus': 'Status',
      'taskDetailCompleted': 'Completed ✓',
      'taskDetailEdit': 'Edit',
      'taskDetailComplete': 'Complete',
      'taskDetailCompletedAction': 'Completed',
      'splashTagline': 'Organize your day.\nBuild better habits.',
      'splashOffline': 'Offline',
      'splashPrivate': '100% private',
      'splashReminders': 'Reminders',
      'splashGetStarted': 'Get started',
      'splashHaveAccount': 'I already have an account',
      'splashTermsPrefix': 'By continuing you agree to the ',
      'splashTermsLink': 'Terms',
      'splashTermsAnd': ' and the ',
      'splashPrivacyLink': 'Privacy Policy',
      'forgotPasswordTitle': 'Recover your access',
      'forgotPasswordBody': 'DayFlow works offline. If you forgot your password, we can\'t send a recovery email. We recommend creating a new account.',
      'forgotPasswordBack': 'Sign in again',
      'forgotPasswordCreateAccount': 'Create a new account',
      'backBtn': 'Back',
      'biometricLoginLabel': 'Sign in with biometrics',
      'navDrawerProfile': 'My profile',
      'navDrawerProfileSub': 'Personal data',
      'navDrawerAchievements': 'Achievements',
      'navDrawerAchievementsSub': 'View progress',
      'navDrawerAppearance': 'Appearance',
      'navDrawerAppearanceSub': 'Dark theme',
      'navDrawerNotifications': 'Notifications',
      'navDrawerNotificationsSub': 'Enabled',
      'navDrawerCategories': 'Categories',
      'navDrawerCategoriesSub': 'Personal, Academic, Health',
      'navDrawerPrivacy': 'Privacy & data',
      'navDrawerPrivacySub': 'Local storage',
      'navDrawerHelp': 'Help & support',
      'navDrawerHelpSub': 'Help center',
      'navDrawerLogout': 'Log out',
      'pageNotFound': 'Page not found',
      'noPendingTasks': 'No pending tasks',
      'errorTitle': 'Something went wrong',
      'retryButton': 'Retry',
      'validationNameEmpty': 'Name is required',
      'validationEmailInvalid': 'Invalid email',
      'validationPasswordShort': 'Password must be at least 6 characters',
      'validationHabitTitle': 'Habit name is required',
      'validationHabitGoal': 'Goal must be greater than 0',
      'validationTaskTitle': 'Title is required',
      'validationTaskDate': 'Date and time are required',
      'emailInUse': 'An account with this email already exists',
      'invalidCredentials': 'Incorrect email or password',
      'sessionRestoreError': 'Error restoring session',
      'monthJanuary': 'January',
      'monthFebruary': 'February',
      'monthMarch': 'March',
      'monthApril': 'April',
      'monthMay': 'May',
      'monthJune': 'June',
      'monthJuly': 'July',
      'monthAugust': 'August',
      'monthSeptember': 'September',
      'monthOctober': 'October',
      'monthNovember': 'November',
      'monthDecember': 'December',
    },
  };

  String _resolve(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? _localizedValues['es']![key] ?? key;
  }

  Future<AppLocalizations> load() async {
    return AppLocalizations(locale);
  }

  // --- Simple getters ---

  String get appName => _resolve('appName');
  String get loginTitle => _resolve('loginTitle');
  String get loginSubtitle => _resolve('loginSubtitle');
  String get loginButton => _resolve('loginButton');
  String get registerButton => _resolve('registerButton');
  String get forgotPassword => _resolve('forgotPassword');
  String get biometricPrompt => _resolve('biometricPrompt');
  String get noUserRegistered => _resolve('noUserRegistered');
  String get emailLabel => _resolve('emailLabel');
  String get emailHint => _resolve('emailHint');
  String get passwordLabel => _resolve('passwordLabel');
  String get passwordHint => _resolve('passwordHint');
  String get emailRequired => _resolve('emailRequired');
  String get emailInvalid => _resolve('emailInvalid');
  String get passwordRequired => _resolve('passwordRequired');
  String get passwordMinLength => _resolve('passwordMinLength');
  String get passwordMinLengthDot => _resolve('passwordMinLengthDot');
  String get nameLabel => _resolve('nameLabel');
  String get nameRequired => _resolve('nameRequired');
  String get nameHint => _resolve('nameHint');
  String get registerTitle => _resolve('registerTitle');
  String get registerSubtitle => _resolve('registerSubtitle');
  String get alreadyHaveAccount => _resolve('alreadyHaveAccount');
  String get alreadyHaveAccountLogin => _resolve('alreadyHaveAccountLogin');
  String get loginLink => _resolve('loginLink');
  String get termsAccepted => _resolve('termsAccepted');
  String get termsRequired => _resolve('termsRequired');
  String get logoutConfirm => _resolve('logoutConfirm');
  String get logoutMessage => _resolve('logoutMessage');
  String get cancelButton => _resolve('cancelButton');
  String get confirmButton => _resolve('confirmButton');
  String get deleteButton => _resolve('deleteButton');
  String get saveButton => _resolve('saveButton');
  String get homeTab => _resolve('homeTab');
  String get tasksTab => _resolve('tasksTab');
  String get habitsTab => _resolve('habitsTab');
  String get statsTab => _resolve('statsTab');
  String get moreTab => _resolve('moreTab');
  String get helloTitle => _resolve('helloTitle');
  String get upcomingActivities => _resolve('upcomingActivities');
  String get noActivitiesToday => _resolve('noActivitiesToday');
  String get goodJobDay => _resolve('goodJobDay');
  String get totalActivities => _resolve('totalActivities');
  String get addTaskTitle => _resolve('addTaskTitle');
  String get editTaskTitle => _resolve('editTaskTitle');
  String get taskTitleLabel => _resolve('taskTitleLabel');
  String get taskTitleHint => _resolve('taskTitleHint');
  String get taskDescLabel => _resolve('taskDescLabel');
  String get taskDescHint => _resolve('taskDescHint');
  String get taskCategoryLabel => _resolve('taskCategoryLabel');
  String get taskDateLabel => _resolve('taskDateLabel');
  String get taskTimeLabel => _resolve('taskTimeLabel');
  String get taskReminderLabel => _resolve('taskReminderLabel');
  String get saveTaskCreate => _resolve('saveTaskCreate');
  String get saveTaskEdit => _resolve('saveTaskEdit');
  String get taskTitleRequired => _resolve('taskTitleRequired');
  String get addHabitTitle => _resolve('addHabitTitle');
  String get editHabitTitle => _resolve('editHabitTitle');
  String get habitNameLabel => _resolve('habitNameLabel');
  String get habitNameHint => _resolve('habitNameHint');
  String get habitGoalLabel => _resolve('habitGoalLabel');
  String get habitUnitLabel => _resolve('habitUnitLabel');
  String get habitFrequencyLabel => _resolve('habitFrequencyLabel');
  String get habitIconLabel => _resolve('habitIconLabel');
  String get saveHabitCreate => _resolve('saveHabitCreate');
  String get saveHabitEdit => _resolve('saveHabitEdit');
  String get habitNameRequired => _resolve('habitNameRequired');
  String get streakLabel => _resolve('streakLabel');
  String get globalStreakLabel => _resolve('globalStreakLabel');
  String get dailyStreak => _resolve('dailyStreak');
  String get daysInARow => _resolve('daysInARow');
  String get completedLabel => _resolve('completedLabel');
  String get completedExclamation => _resolve('completedExclamation');
  String get pendingLabel => _resolve('pendingLabel');
  String get noTasksTitle => _resolve('noTasksTitle');
  String get noTasksSubtitle => _resolve('noTasksSubtitle');
  String get noTasksAction => _resolve('noTasksAction');
  String get filterAll => _resolve('filterAll');
  String get today => _resolve('today');
  String get tomorrow => _resolve('tomorrow');
  String get later => _resolve('later');
  String get taskCompleted => _resolve('taskCompleted');
  String get taskMarkComplete => _resolve('taskMarkComplete');
  String get noHabitsTitle => _resolve('noHabitsTitle');
  String get noHabitsSubtitle => _resolve('noHabitsSubtitle');
  String get noHabitsAction => _resolve('noHabitsAction');
  String get todayHabits => _resolve('todayHabits');
  String get allMyHabits => _resolve('allMyHabits');
  String get deleteHabit => _resolve('deleteHabit');
  String get labelPersonal => _resolve('labelPersonal');
  String get labelAcademic => _resolve('labelAcademic');
  String get labelHealth => _resolve('labelHealth');
  String get frequencyDaily => _resolve('frequencyDaily');
  String get frequencyWeekly => _resolve('frequencyWeekly');
  String get frequencyCustom => _resolve('frequencyCustom');
  String get reminder5min => _resolve('reminder5min');
  String get reminder15min => _resolve('reminder15min');
  String get reminder30min => _resolve('reminder30min');
  String get reminder60min => _resolve('reminder60min');
  String get timeOnce => _resolve('timeOnce');
  String get timeTimes => _resolve('timeTimes');
  String get dayMon => _resolve('dayMon');
  String get dayTue => _resolve('dayTue');
  String get dayWed => _resolve('dayWed');
  String get dayThu => _resolve('dayThu');
  String get dayFri => _resolve('dayFri');
  String get daySat => _resolve('daySat');
  String get daySun => _resolve('daySun');
  String get statsTitle => _resolve('statsTitle');
  String get completedPercent => _resolve('completedPercent');
  String get weeklyStats => _resolve('weeklyStats');
  String get noDataWeek => _resolve('noDataWeek');
  String get statsTotal => _resolve('statsTotal');
  String get statsWeek => _resolve('statsWeek');
  String get achievementsTitle => _resolve('achievementsTitle');
  String get achievementsUnlocked => _resolve('achievementsUnlocked');
  String get achievementsUnlockedTab => _resolve('achievementsUnlockedTab');
  String get achievementsLockedTab => _resolve('achievementsLockedTab');
  String get noAchievementsTitle => _resolve('noAchievementsTitle');
  String get noAchievementsSubtitle => _resolve('noAchievementsSubtitle');
  String get moreTitle => _resolve('moreTitle');
  String get personalizationSection => _resolve('personalizationSection');
  String get appearanceTitle => _resolve('appearanceTitle');
  String get themeLight => _resolve('themeLight');
  String get themeDark => _resolve('themeDark');
  String get themeSystem => _resolve('themeSystem');
  String get themeSheetTitle => _resolve('themeSheetTitle');
  String get dataSection => _resolve('dataSection');
  String get backupTitle => _resolve('backupTitle');
  String get backupSubtitle => _resolve('backupSubtitle');
  String get exportDataTitle => _resolve('exportDataTitle');
  String get exportDataSubtitle => _resolve('exportDataSubtitle');
  String get progressSection => _resolve('progressSection');
  String get calendarTitle => _resolve('calendarTitle');
  String get calendarSubtitle => _resolve('calendarSubtitle');
  String get accountSection => _resolve('accountSection');
  String get logoutTitle => _resolve('logoutTitle');
  String get logoutSubtitle => _resolve('logoutSubtitle');
  String get profileTitle => _resolve('profileTitle');
  String get recentMember => _resolve('recentMember');
  String get currentStreak => _resolve('currentStreak');
  String get achievementsCount => _resolve('achievementsCount');
  String get settingsShortcut => _resolve('settingsShortcut');
  String get privacyShortcut => _resolve('privacyShortcut');
  String get helpShortcut => _resolve('helpShortcut');
  String get backupLocalSection => _resolve('backupLocalSection');
  String get backupExportAllSubtitle => _resolve('backupExportAllSubtitle');
  String get backupReportSubtitle => _resolve('backupReportSubtitle');
  String get backupFullSubtitle => _resolve('backupFullSubtitle');
  String get backupDriveSection => _resolve('backupDriveSection');
  String get backupConnectDrive => _resolve('backupConnectDrive');
  String get backupSyncSubtitle => _resolve('backupSyncSubtitle');
  String get backupUploadDrive => _resolve('backupUploadDrive');
  String get backupUploadSubtitle => _resolve('backupUploadSubtitle');
  String get backupDisconnectDrive => _resolve('backupDisconnectDrive');
  String get backupSignOutDrive => _resolve('backupSignOutDrive');
  String get noDriveBackups => _resolve('noDriveBackups');
  String get driveBackups => _resolve('driveBackups');
  String get backupSelectZip => _resolve('backupSelectZip');
  String get backupDefaultName => _resolve('backupDefaultName');
  String get exportCsv => _resolve('exportCsv');
  String get exportPdf => _resolve('exportPdf');
  String get createBackup => _resolve('createBackup');
  String get restoreBackupLocal => _resolve('restoreBackupLocal');
  String get taskDetailTitle => _resolve('taskDetailTitle');
  String get taskDetailReminder => _resolve('taskDetailReminder');
  String get taskDetailStatus => _resolve('taskDetailStatus');
  String get taskDetailCompleted => _resolve('taskDetailCompleted');
  String get taskDetailEdit => _resolve('taskDetailEdit');
  String get taskDetailComplete => _resolve('taskDetailComplete');
  String get taskDetailCompletedAction => _resolve('taskDetailCompletedAction');
  String get splashTagline => _resolve('splashTagline');
  String get splashOffline => _resolve('splashOffline');
  String get splashPrivate => _resolve('splashPrivate');
  String get splashReminders => _resolve('splashReminders');
  String get splashGetStarted => _resolve('splashGetStarted');
  String get splashHaveAccount => _resolve('splashHaveAccount');
  String get splashTermsPrefix => _resolve('splashTermsPrefix');
  String get splashTermsLink => _resolve('splashTermsLink');
  String get splashTermsAnd => _resolve('splashTermsAnd');
  String get splashPrivacyLink => _resolve('splashPrivacyLink');
  String get forgotPasswordTitle => _resolve('forgotPasswordTitle');
  String get forgotPasswordBody => _resolve('forgotPasswordBody');
  String get forgotPasswordBack => _resolve('forgotPasswordBack');
  String get forgotPasswordCreateAccount => _resolve('forgotPasswordCreateAccount');
  String get backBtn => _resolve('backBtn');
  String get biometricLoginLabel => _resolve('biometricLoginLabel');
  String get navDrawerProfile => _resolve('navDrawerProfile');
  String get navDrawerProfileSub => _resolve('navDrawerProfileSub');
  String get navDrawerAchievements => _resolve('navDrawerAchievements');
  String get navDrawerAchievementsSub => _resolve('navDrawerAchievementsSub');
  String get navDrawerAppearance => _resolve('navDrawerAppearance');
  String get navDrawerAppearanceSub => _resolve('navDrawerAppearanceSub');
  String get navDrawerNotifications => _resolve('navDrawerNotifications');
  String get navDrawerNotificationsSub => _resolve('navDrawerNotificationsSub');
  String get navDrawerCategories => _resolve('navDrawerCategories');
  String get navDrawerCategoriesSub => _resolve('navDrawerCategoriesSub');
  String get navDrawerPrivacy => _resolve('navDrawerPrivacy');
  String get navDrawerPrivacySub => _resolve('navDrawerPrivacySub');
  String get navDrawerHelp => _resolve('navDrawerHelp');
  String get navDrawerHelpSub => _resolve('navDrawerHelpSub');
  String get navDrawerLogout => _resolve('navDrawerLogout');
  String get pageNotFound => _resolve('pageNotFound');
  String get noPendingTasks => _resolve('noPendingTasks');
  String get errorTitle => _resolve('errorTitle');
  String get retryButton => _resolve('retryButton');
  String get validationNameEmpty => _resolve('validationNameEmpty');
  String get validationEmailInvalid => _resolve('validationEmailInvalid');
  String get validationPasswordShort => _resolve('validationPasswordShort');
  String get validationHabitTitle => _resolve('validationHabitTitle');
  String get validationHabitGoal => _resolve('validationHabitGoal');
  String get validationTaskTitle => _resolve('validationTaskTitle');
  String get validationTaskDate => _resolve('validationTaskDate');
  String get emailInUse => _resolve('emailInUse');
  String get invalidCredentials => _resolve('invalidCredentials');
  String get sessionRestoreError => _resolve('sessionRestoreError');
  String get monthJanuary => _resolve('monthJanuary');
  String get monthFebruary => _resolve('monthFebruary');
  String get monthMarch => _resolve('monthMarch');
  String get monthApril => _resolve('monthApril');
  String get monthMay => _resolve('monthMay');
  String get monthJune => _resolve('monthJune');
  String get monthJuly => _resolve('monthJuly');
  String get monthAugust => _resolve('monthAugust');
  String get monthSeptember => _resolve('monthSeptember');
  String get monthOctober => _resolve('monthOctober');
  String get monthNovember => _resolve('monthNovember');
  String get monthDecember => _resolve('monthDecember');

  // --- Parameterized methods ---

  String reminderBefore(String minutes) {
    final template = _resolve('reminderBefore');
    return template.replaceAll('{minutes}', minutes);
  }

  String goalLabel(String value, String unit) {
    final template = _resolve('goalLabel');
    return template.replaceAll('{value}', value).replaceAll('{unit}', unit);
  }

  String deleteHabitConfirm(String name) {
    final template = _resolve('deleteHabitConfirm');
    return template.replaceAll('{name}', name);
  }

  String memberSince(String date) {
    final template = _resolve('memberSince');
    return template.replaceAll('{date}', date);
  }

  String backupDownloadedTo(String path) {
    final template = _resolve('backupDownloadedTo');
    return template.replaceAll('{path}', path);
  }

  String backupSavedTo(String path) {
    final template = _resolve('backupSavedTo');
    return template.replaceAll('{path}', path);
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['es', 'en'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return AppLocalizations(locale).load();
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}