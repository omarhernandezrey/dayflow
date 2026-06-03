// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'DayFlow';

  @override
  String get loginTitle => '¡Hola de nuevo!';

  @override
  String get loginSubtitle => 'Inicia sesión para continuar con tu progreso.';

  @override
  String get loginButton => 'Iniciar sesión';

  @override
  String get registerButton => 'Regístrate';

  @override
  String get forgotPassword => '¿Olvidaste tu contraseña?';

  @override
  String get biometricPrompt => 'Usar biometría';

  @override
  String get noUserRegistered => 'No hay usuario registrado';

  @override
  String get emailLabel => 'Correo electrónico';

  @override
  String get emailHint => 'tu@email.com';

  @override
  String get passwordLabel => 'Contraseña';

  @override
  String get passwordHint => '••••••••';

  @override
  String get emailRequired => 'El correo es obligatorio';

  @override
  String get emailInvalid => 'Correo inválido';

  @override
  String get passwordRequired => 'La contraseña es obligatoria';

  @override
  String get passwordMinLength => 'Mínimo 6 caracteres';

  @override
  String get passwordMinLengthDot => 'Mínimo 6 caracteres.';

  @override
  String get nameLabel => 'Nombre completo';

  @override
  String get nameRequired => 'El nombre es obligatorio';

  @override
  String get nameHint => 'Tu nombre';

  @override
  String get registerTitle => 'Crear cuenta';

  @override
  String get registerSubtitle =>
      'Comienza a organizar tu día en menos de un minuto.';

  @override
  String get alreadyHaveAccount => '¿Aún no tienes cuenta? ';

  @override
  String get alreadyHaveAccountLogin => '¿Ya tienes cuenta? ';

  @override
  String get loginLink => 'Inicia sesión';

  @override
  String get termsAccepted =>
      'Acepto los términos de servicio y la política de privacidad.';

  @override
  String get termsRequired => 'Debes aceptar los términos';

  @override
  String get logoutConfirm => '¿Cerrar sesión?';

  @override
  String get logoutMessage =>
      'Perderás el acceso hasta que inicies sesión de nuevo.';

  @override
  String get cancelButton => 'Cancelar';

  @override
  String get confirmButton => 'Confirmar';

  @override
  String get deleteButton => 'Eliminar';

  @override
  String get saveButton => 'Guardar';

  @override
  String get homeTab => 'Inicio';

  @override
  String get tasksTab => 'Tareas';

  @override
  String get habitsTab => 'Hábitos';

  @override
  String get statsTab => 'Stats';

  @override
  String get moreTab => 'Más';

  @override
  String get helloTitle => '¡Hola!';

  @override
  String get upcomingActivities => 'Próximas actividades';

  @override
  String get noActivitiesToday => 'No tienes actividades pendientes hoy';

  @override
  String get goodJobDay => '¡Buen trabajo! Disfruta tu día.';

  @override
  String get totalActivities => 'Actividades\ntotales';

  @override
  String get addTaskTitle => 'Nueva tarea';

  @override
  String get editTaskTitle => 'Editar tarea';

  @override
  String get taskTitleLabel => 'Título';

  @override
  String get taskTitleHint => 'Nombre de la actividad';

  @override
  String get taskDescLabel => 'Descripción';

  @override
  String get taskDescHint => 'Descripción opcional…';

  @override
  String get taskCategoryLabel => 'Categoría';

  @override
  String get taskDateLabel => 'Fecha';

  @override
  String get taskTimeLabel => 'Hora';

  @override
  String get taskReminderLabel => 'Recordatorio';

  @override
  String reminderBefore(String minutes) {
    return '$minutes antes';
  }

  @override
  String get saveTaskCreate => 'Guardar actividad';

  @override
  String get saveTaskEdit => 'Guardar cambios';

  @override
  String get taskTitleRequired => 'El título es obligatorio';

  @override
  String get addHabitTitle => 'Nuevo hábito';

  @override
  String get editHabitTitle => 'Editar hábito';

  @override
  String get habitNameLabel => 'Nombre del hábito';

  @override
  String get habitNameHint => 'Nombre del hábito…';

  @override
  String get habitGoalLabel => 'Meta diaria';

  @override
  String get habitUnitLabel => 'Unidad';

  @override
  String get habitFrequencyLabel => 'Frecuencia';

  @override
  String get habitIconLabel => 'Icono';

  @override
  String get saveHabitCreate => 'Crear hábito';

  @override
  String get saveHabitEdit => 'Guardar cambios';

  @override
  String get habitNameRequired => 'El nombre es obligatorio';

  @override
  String get streakLabel => 'Racha';

  @override
  String get globalStreakLabel => 'Racha global';

  @override
  String get dailyStreak => 'RACHA DIARIA';

  @override
  String get daysInARow => 'días seguidos';

  @override
  String get completedLabel => 'Completado';

  @override
  String get completedExclamation => '¡Completado!';

  @override
  String goalLabel(String value, String unit) {
    return 'Meta: $value $unit';
  }

  @override
  String get pendingLabel => 'Pendiente';

  @override
  String get noTasksTitle => 'No tienes tareas';

  @override
  String get noTasksSubtitle => 'Agrega tu primera tarea para empezar';

  @override
  String get noTasksAction => 'Agregar tarea';

  @override
  String get filterAll => 'Todas';

  @override
  String get today => 'Hoy';

  @override
  String get tomorrow => 'Mañana';

  @override
  String get later => 'Más adelante';

  @override
  String get taskCompleted => 'Tarea completada';

  @override
  String get taskMarkComplete => 'Marcar tarea como completada';

  @override
  String get noHabitsTitle => 'No tienes hábitos para hoy';

  @override
  String get noHabitsSubtitle => 'Crea un hábito y empieza tu racha';

  @override
  String get noHabitsAction => 'Crear hábito';

  @override
  String get todayHabits => 'Hábitos de hoy';

  @override
  String get allMyHabits => 'Todos mis hábitos';

  @override
  String get deleteHabit => 'Eliminar hábito';

  @override
  String deleteHabitConfirm(String name) {
    return '¿Eliminar \"$name\"? Esta acción no se puede deshacer.';
  }

  @override
  String get labelPersonal => 'Personal';

  @override
  String get labelAcademic => 'Académica';

  @override
  String get labelHealth => 'Salud';

  @override
  String get frequencyDaily => 'Diario';

  @override
  String get frequencyWeekly => 'Semanal';

  @override
  String get frequencyCustom => 'Personalizado';

  @override
  String get reminder5min => '5 min';

  @override
  String get reminder15min => '15 min';

  @override
  String get reminder30min => '30 min';

  @override
  String get reminder60min => '60 min';

  @override
  String get timeOnce => 'vez';

  @override
  String get timeTimes => 'veces';

  @override
  String get dayMon => 'L';

  @override
  String get dayTue => 'M';

  @override
  String get dayWed => 'X';

  @override
  String get dayThu => 'J';

  @override
  String get dayFri => 'V';

  @override
  String get daySat => 'S';

  @override
  String get daySun => 'D';

  @override
  String get statsTitle => 'Estadísticas';

  @override
  String get completedPercent => 'Completado';

  @override
  String get weeklyStats => 'Cumplimiento semanal';

  @override
  String get noDataWeek => 'Sin datos esta semana';

  @override
  String get statsTotal => 'Total';

  @override
  String get statsWeek => 'Esta semana';

  @override
  String get achievementsTitle => 'Logros';

  @override
  String get achievementsUnlocked => 'desbloqueados';

  @override
  String get achievementsUnlockedTab => 'Desbloqueados';

  @override
  String get achievementsLockedTab => 'Bloqueados';

  @override
  String get noAchievementsTitle => 'Sin logros';

  @override
  String get noAchievementsSubtitle =>
      'Completa tareas y hábitos para desbloquear logros';

  @override
  String get moreTitle => 'Más';

  @override
  String get personalizationSection => 'Personalización';

  @override
  String get appearanceTitle => 'Apariencia';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeSheetTitle => 'Tema';

  @override
  String get dataSection => 'Datos';

  @override
  String get backupTitle => 'Copia de seguridad';

  @override
  String get backupSubtitle => 'Exportar y restaurar';

  @override
  String get exportDataTitle => 'Exportar datos';

  @override
  String get exportDataSubtitle => 'CSV y PDF';

  @override
  String get progressSection => 'Progreso';

  @override
  String get calendarTitle => 'Calendario';

  @override
  String get calendarSubtitle => 'Vista mensual y semanal';

  @override
  String get accountSection => 'Cuenta';

  @override
  String get logoutTitle => 'Cerrar sesión';

  @override
  String get logoutSubtitle => 'Salir de la aplicación';

  @override
  String get profileTitle => 'Perfil';

  @override
  String memberSince(String date) {
    return 'Miembro desde $date';
  }

  @override
  String get recentMember => 'Miembro reciente';

  @override
  String get currentStreak => 'Racha actual';

  @override
  String get achievementsCount => 'Logros';

  @override
  String get settingsShortcut => 'Configuración';

  @override
  String get privacyShortcut => 'Privacidad';

  @override
  String get helpShortcut => 'Ayuda';

  @override
  String get backupLocalSection => 'LOCAL';

  @override
  String get backupExportAllSubtitle => 'Exporta todas tus tareas y hábitos';

  @override
  String get backupReportSubtitle => 'Genera un reporte visual';

  @override
  String get backupFullSubtitle => 'Copia completa de la base de datos';

  @override
  String get backupDriveSection => 'GOOGLE DRIVE';

  @override
  String get backupConnectDrive => 'Conectar con Google Drive';

  @override
  String get backupSyncSubtitle => 'Sincroniza tus backups en la nube';

  @override
  String get backupUploadDrive => 'Subir backup a Drive';

  @override
  String get backupUploadSubtitle => 'Crea backup local y súbelo';

  @override
  String get backupDisconnectDrive => 'Desconectar Google Drive';

  @override
  String get backupSignOutDrive => 'Cerrar sesión de Google';

  @override
  String get noDriveBackups => 'No hay backups en Drive';

  @override
  String get driveBackups => 'Backups en Drive';

  @override
  String get backupSelectZip => 'Selecciona un archivo .zip';

  @override
  String get backupDefaultName => 'Backup';

  @override
  String backupDownloadedTo(String path) {
    return 'Descargado a: $path';
  }

  @override
  String get exportCsv => 'Exportar a CSV';

  @override
  String get exportPdf => 'Exportar a PDF';

  @override
  String get createBackup => 'Crear backup ZIP';

  @override
  String get restoreBackupLocal => 'Restaurar backup local';

  @override
  String backupSavedTo(String path) {
    return 'Guardado:\n$path';
  }

  @override
  String get taskDetailTitle => 'Detalle';

  @override
  String get taskDetailReminder => 'minutos antes';

  @override
  String get taskDetailStatus => 'Estado';

  @override
  String get taskDetailCompleted => 'Completada ✓';

  @override
  String get taskDetailEdit => 'Editar';

  @override
  String get taskDetailComplete => 'Completar';

  @override
  String get taskDetailCompletedAction => 'Completada';

  @override
  String get splashTagline => 'Organiza tu día.\nConstruye mejores hábitos.';

  @override
  String get splashOffline => 'Sin conexión';

  @override
  String get splashPrivate => '100% privado';

  @override
  String get splashReminders => 'Recordatorios';

  @override
  String get splashGetStarted => 'Comenzar';

  @override
  String get splashHaveAccount => 'Ya tengo una cuenta';

  @override
  String get splashTermsPrefix => 'Al continuar aceptas los ';

  @override
  String get splashTermsLink => 'Términos';

  @override
  String get splashTermsAnd => ' y la ';

  @override
  String get splashPrivacyLink => 'Política de privacidad';

  @override
  String get forgotPasswordTitle => 'Recupera tu acceso';

  @override
  String get forgotPasswordBody =>
      'DayFlow funciona de forma offline. Si olvidaste tu contraseña, no podemos enviar un correo de recuperación. Te recomendamos crear una nueva cuenta.';

  @override
  String get forgotPasswordBack => 'Volver a iniciar sesión';

  @override
  String get forgotPasswordCreateAccount => 'Crear nueva cuenta';

  @override
  String get backBtn => 'Volver';

  @override
  String get biometricLoginLabel => 'Iniciar sesión con biometría';

  @override
  String get navDrawerProfile => 'Mi perfil';

  @override
  String get navDrawerProfileSub => 'Datos personales';

  @override
  String get navDrawerAchievements => 'Logros';

  @override
  String get navDrawerAchievementsSub => 'Ver progreso';

  @override
  String get navDrawerAppearance => 'Apariencia';

  @override
  String get navDrawerAppearanceSub => 'Tema oscuro';

  @override
  String get navDrawerNotifications => 'Notificaciones';

  @override
  String get navDrawerNotificationsSub => 'Activadas';

  @override
  String get navDrawerCategories => 'Categorías';

  @override
  String get navDrawerCategoriesSub => 'Personal, Académica, Salud';

  @override
  String get navDrawerPrivacy => 'Privacidad y datos';

  @override
  String get navDrawerPrivacySub => 'Almacenamiento local';

  @override
  String get navDrawerHelp => 'Ayuda y soporte';

  @override
  String get navDrawerHelpSub => 'Centro de ayuda';

  @override
  String get navDrawerLogout => 'Cerrar sesión';

  @override
  String get pageNotFound => 'Pantalla no encontrada';

  @override
  String get noPendingTasks => 'Sin tareas pendientes';

  @override
  String get errorTitle => 'Algo salió mal';

  @override
  String get retryButton => 'Reintentar';

  @override
  String get validationNameEmpty => 'El nombre es obligatorio';

  @override
  String get validationEmailInvalid => 'Correo electrónico inválido';

  @override
  String get validationPasswordShort =>
      'La contraseña debe tener al menos 6 caracteres';

  @override
  String get validationHabitTitle => 'El nombre del hábito es obligatorio';

  @override
  String get validationHabitGoal => 'La meta debe ser mayor a 0';

  @override
  String get validationTaskTitle => 'El título es obligatorio';

  @override
  String get validationTaskDate => 'La fecha y hora son obligatorias';

  @override
  String get emailInUse => 'Ya existe una cuenta con este correo';

  @override
  String get invalidCredentials => 'Correo o contraseña incorrectos';

  @override
  String get sessionRestoreError => 'Error al restaurar sesión';

  @override
  String get monthJanuary => 'enero';

  @override
  String get monthFebruary => 'febrero';

  @override
  String get monthMarch => 'marzo';

  @override
  String get monthApril => 'abril';

  @override
  String get monthMay => 'mayo';

  @override
  String get monthJune => 'junio';

  @override
  String get monthJuly => 'julio';

  @override
  String get monthAugust => 'agosto';

  @override
  String get monthSeptember => 'septiembre';

  @override
  String get monthOctober => 'octubre';

  @override
  String get monthNovember => 'noviembre';

  @override
  String get monthDecember => 'diciembre';
}
