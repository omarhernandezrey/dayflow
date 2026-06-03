import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @appName.
  ///
  /// In es, this message translates to:
  /// **'DayFlow'**
  String get appName;

  /// No description provided for @loginTitle.
  ///
  /// In es, this message translates to:
  /// **'¡Hola de nuevo!'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Inicia sesión para continuar con tu progreso.'**
  String get loginSubtitle;

  /// No description provided for @loginButton.
  ///
  /// In es, this message translates to:
  /// **'Iniciar sesión'**
  String get loginButton;

  /// No description provided for @registerButton.
  ///
  /// In es, this message translates to:
  /// **'Regístrate'**
  String get registerButton;

  /// No description provided for @forgotPassword.
  ///
  /// In es, this message translates to:
  /// **'¿Olvidaste tu contraseña?'**
  String get forgotPassword;

  /// No description provided for @biometricPrompt.
  ///
  /// In es, this message translates to:
  /// **'Usar biometría'**
  String get biometricPrompt;

  /// No description provided for @noUserRegistered.
  ///
  /// In es, this message translates to:
  /// **'No hay usuario registrado'**
  String get noUserRegistered;

  /// No description provided for @emailLabel.
  ///
  /// In es, this message translates to:
  /// **'Correo electrónico'**
  String get emailLabel;

  /// No description provided for @emailHint.
  ///
  /// In es, this message translates to:
  /// **'tu@email.com'**
  String get emailHint;

  /// No description provided for @passwordLabel.
  ///
  /// In es, this message translates to:
  /// **'Contraseña'**
  String get passwordLabel;

  /// No description provided for @passwordHint.
  ///
  /// In es, this message translates to:
  /// **'••••••••'**
  String get passwordHint;

  /// No description provided for @emailRequired.
  ///
  /// In es, this message translates to:
  /// **'El correo es obligatorio'**
  String get emailRequired;

  /// No description provided for @emailInvalid.
  ///
  /// In es, this message translates to:
  /// **'Correo inválido'**
  String get emailInvalid;

  /// No description provided for @passwordRequired.
  ///
  /// In es, this message translates to:
  /// **'La contraseña es obligatoria'**
  String get passwordRequired;

  /// No description provided for @passwordMinLength.
  ///
  /// In es, this message translates to:
  /// **'Mínimo 6 caracteres'**
  String get passwordMinLength;

  /// No description provided for @passwordMinLengthDot.
  ///
  /// In es, this message translates to:
  /// **'Mínimo 6 caracteres.'**
  String get passwordMinLengthDot;

  /// No description provided for @nameLabel.
  ///
  /// In es, this message translates to:
  /// **'Nombre completo'**
  String get nameLabel;

  /// No description provided for @nameRequired.
  ///
  /// In es, this message translates to:
  /// **'El nombre es obligatorio'**
  String get nameRequired;

  /// No description provided for @nameHint.
  ///
  /// In es, this message translates to:
  /// **'Tu nombre'**
  String get nameHint;

  /// No description provided for @registerTitle.
  ///
  /// In es, this message translates to:
  /// **'Crear cuenta'**
  String get registerTitle;

  /// No description provided for @registerSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Comienza a organizar tu día en menos de un minuto.'**
  String get registerSubtitle;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In es, this message translates to:
  /// **'¿Aún no tienes cuenta? '**
  String get alreadyHaveAccount;

  /// No description provided for @alreadyHaveAccountLogin.
  ///
  /// In es, this message translates to:
  /// **'¿Ya tienes cuenta? '**
  String get alreadyHaveAccountLogin;

  /// No description provided for @loginLink.
  ///
  /// In es, this message translates to:
  /// **'Inicia sesión'**
  String get loginLink;

  /// No description provided for @termsAccepted.
  ///
  /// In es, this message translates to:
  /// **'Acepto los términos de servicio y la política de privacidad.'**
  String get termsAccepted;

  /// No description provided for @termsRequired.
  ///
  /// In es, this message translates to:
  /// **'Debes aceptar los términos'**
  String get termsRequired;

  /// No description provided for @logoutConfirm.
  ///
  /// In es, this message translates to:
  /// **'¿Cerrar sesión?'**
  String get logoutConfirm;

  /// No description provided for @logoutMessage.
  ///
  /// In es, this message translates to:
  /// **'Perderás el acceso hasta que inicies sesión de nuevo.'**
  String get logoutMessage;

  /// No description provided for @cancelButton.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get cancelButton;

  /// No description provided for @confirmButton.
  ///
  /// In es, this message translates to:
  /// **'Confirmar'**
  String get confirmButton;

  /// No description provided for @deleteButton.
  ///
  /// In es, this message translates to:
  /// **'Eliminar'**
  String get deleteButton;

  /// No description provided for @saveButton.
  ///
  /// In es, this message translates to:
  /// **'Guardar'**
  String get saveButton;

  /// No description provided for @homeTab.
  ///
  /// In es, this message translates to:
  /// **'Inicio'**
  String get homeTab;

  /// No description provided for @tasksTab.
  ///
  /// In es, this message translates to:
  /// **'Tareas'**
  String get tasksTab;

  /// No description provided for @habitsTab.
  ///
  /// In es, this message translates to:
  /// **'Hábitos'**
  String get habitsTab;

  /// No description provided for @statsTab.
  ///
  /// In es, this message translates to:
  /// **'Stats'**
  String get statsTab;

  /// No description provided for @moreTab.
  ///
  /// In es, this message translates to:
  /// **'Más'**
  String get moreTab;

  /// No description provided for @helloTitle.
  ///
  /// In es, this message translates to:
  /// **'¡Hola!'**
  String get helloTitle;

  /// No description provided for @upcomingActivities.
  ///
  /// In es, this message translates to:
  /// **'Próximas actividades'**
  String get upcomingActivities;

  /// No description provided for @noActivitiesToday.
  ///
  /// In es, this message translates to:
  /// **'No tienes actividades pendientes hoy'**
  String get noActivitiesToday;

  /// No description provided for @goodJobDay.
  ///
  /// In es, this message translates to:
  /// **'¡Buen trabajo! Disfruta tu día.'**
  String get goodJobDay;

  /// No description provided for @totalActivities.
  ///
  /// In es, this message translates to:
  /// **'Actividades\ntotales'**
  String get totalActivities;

  /// No description provided for @addTaskTitle.
  ///
  /// In es, this message translates to:
  /// **'Nueva tarea'**
  String get addTaskTitle;

  /// No description provided for @editTaskTitle.
  ///
  /// In es, this message translates to:
  /// **'Editar tarea'**
  String get editTaskTitle;

  /// No description provided for @taskTitleLabel.
  ///
  /// In es, this message translates to:
  /// **'Título'**
  String get taskTitleLabel;

  /// No description provided for @taskTitleHint.
  ///
  /// In es, this message translates to:
  /// **'Nombre de la actividad'**
  String get taskTitleHint;

  /// No description provided for @taskDescLabel.
  ///
  /// In es, this message translates to:
  /// **'Descripción'**
  String get taskDescLabel;

  /// No description provided for @taskDescHint.
  ///
  /// In es, this message translates to:
  /// **'Descripción opcional…'**
  String get taskDescHint;

  /// No description provided for @taskCategoryLabel.
  ///
  /// In es, this message translates to:
  /// **'Categoría'**
  String get taskCategoryLabel;

  /// No description provided for @taskDateLabel.
  ///
  /// In es, this message translates to:
  /// **'Fecha'**
  String get taskDateLabel;

  /// No description provided for @taskTimeLabel.
  ///
  /// In es, this message translates to:
  /// **'Hora'**
  String get taskTimeLabel;

  /// No description provided for @taskReminderLabel.
  ///
  /// In es, this message translates to:
  /// **'Recordatorio'**
  String get taskReminderLabel;

  /// No description provided for @reminderBefore.
  ///
  /// In es, this message translates to:
  /// **'{minutes} antes'**
  String reminderBefore(String minutes);

  /// No description provided for @saveTaskCreate.
  ///
  /// In es, this message translates to:
  /// **'Guardar actividad'**
  String get saveTaskCreate;

  /// No description provided for @saveTaskEdit.
  ///
  /// In es, this message translates to:
  /// **'Guardar cambios'**
  String get saveTaskEdit;

  /// No description provided for @taskTitleRequired.
  ///
  /// In es, this message translates to:
  /// **'El título es obligatorio'**
  String get taskTitleRequired;

  /// No description provided for @addHabitTitle.
  ///
  /// In es, this message translates to:
  /// **'Nuevo hábito'**
  String get addHabitTitle;

  /// No description provided for @editHabitTitle.
  ///
  /// In es, this message translates to:
  /// **'Editar hábito'**
  String get editHabitTitle;

  /// No description provided for @habitNameLabel.
  ///
  /// In es, this message translates to:
  /// **'Nombre del hábito'**
  String get habitNameLabel;

  /// No description provided for @habitNameHint.
  ///
  /// In es, this message translates to:
  /// **'Nombre del hábito…'**
  String get habitNameHint;

  /// No description provided for @habitGoalLabel.
  ///
  /// In es, this message translates to:
  /// **'Meta diaria'**
  String get habitGoalLabel;

  /// No description provided for @habitUnitLabel.
  ///
  /// In es, this message translates to:
  /// **'Unidad'**
  String get habitUnitLabel;

  /// No description provided for @habitFrequencyLabel.
  ///
  /// In es, this message translates to:
  /// **'Frecuencia'**
  String get habitFrequencyLabel;

  /// No description provided for @habitIconLabel.
  ///
  /// In es, this message translates to:
  /// **'Icono'**
  String get habitIconLabel;

  /// No description provided for @saveHabitCreate.
  ///
  /// In es, this message translates to:
  /// **'Crear hábito'**
  String get saveHabitCreate;

  /// No description provided for @saveHabitEdit.
  ///
  /// In es, this message translates to:
  /// **'Guardar cambios'**
  String get saveHabitEdit;

  /// No description provided for @habitNameRequired.
  ///
  /// In es, this message translates to:
  /// **'El nombre es obligatorio'**
  String get habitNameRequired;

  /// No description provided for @streakLabel.
  ///
  /// In es, this message translates to:
  /// **'Racha'**
  String get streakLabel;

  /// No description provided for @globalStreakLabel.
  ///
  /// In es, this message translates to:
  /// **'Racha global'**
  String get globalStreakLabel;

  /// No description provided for @dailyStreak.
  ///
  /// In es, this message translates to:
  /// **'RACHA DIARIA'**
  String get dailyStreak;

  /// No description provided for @daysInARow.
  ///
  /// In es, this message translates to:
  /// **'días seguidos'**
  String get daysInARow;

  /// No description provided for @completedLabel.
  ///
  /// In es, this message translates to:
  /// **'Completado'**
  String get completedLabel;

  /// No description provided for @completedExclamation.
  ///
  /// In es, this message translates to:
  /// **'¡Completado!'**
  String get completedExclamation;

  /// No description provided for @goalLabel.
  ///
  /// In es, this message translates to:
  /// **'Meta: {value} {unit}'**
  String goalLabel(String value, String unit);

  /// No description provided for @pendingLabel.
  ///
  /// In es, this message translates to:
  /// **'Pendiente'**
  String get pendingLabel;

  /// No description provided for @noTasksTitle.
  ///
  /// In es, this message translates to:
  /// **'No tienes tareas'**
  String get noTasksTitle;

  /// No description provided for @noTasksSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Agrega tu primera tarea para empezar'**
  String get noTasksSubtitle;

  /// No description provided for @noTasksAction.
  ///
  /// In es, this message translates to:
  /// **'Agregar tarea'**
  String get noTasksAction;

  /// No description provided for @filterAll.
  ///
  /// In es, this message translates to:
  /// **'Todas'**
  String get filterAll;

  /// No description provided for @today.
  ///
  /// In es, this message translates to:
  /// **'Hoy'**
  String get today;

  /// No description provided for @tomorrow.
  ///
  /// In es, this message translates to:
  /// **'Mañana'**
  String get tomorrow;

  /// No description provided for @later.
  ///
  /// In es, this message translates to:
  /// **'Más adelante'**
  String get later;

  /// No description provided for @taskCompleted.
  ///
  /// In es, this message translates to:
  /// **'Tarea completada'**
  String get taskCompleted;

  /// No description provided for @taskMarkComplete.
  ///
  /// In es, this message translates to:
  /// **'Marcar tarea como completada'**
  String get taskMarkComplete;

  /// No description provided for @noHabitsTitle.
  ///
  /// In es, this message translates to:
  /// **'No tienes hábitos para hoy'**
  String get noHabitsTitle;

  /// No description provided for @noHabitsSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Crea un hábito y empieza tu racha'**
  String get noHabitsSubtitle;

  /// No description provided for @noHabitsAction.
  ///
  /// In es, this message translates to:
  /// **'Crear hábito'**
  String get noHabitsAction;

  /// No description provided for @todayHabits.
  ///
  /// In es, this message translates to:
  /// **'Hábitos de hoy'**
  String get todayHabits;

  /// No description provided for @allMyHabits.
  ///
  /// In es, this message translates to:
  /// **'Todos mis hábitos'**
  String get allMyHabits;

  /// No description provided for @deleteHabit.
  ///
  /// In es, this message translates to:
  /// **'Eliminar hábito'**
  String get deleteHabit;

  /// No description provided for @deleteHabitConfirm.
  ///
  /// In es, this message translates to:
  /// **'¿Eliminar \"{name}\"? Esta acción no se puede deshacer.'**
  String deleteHabitConfirm(String name);

  /// No description provided for @labelPersonal.
  ///
  /// In es, this message translates to:
  /// **'Personal'**
  String get labelPersonal;

  /// No description provided for @labelAcademic.
  ///
  /// In es, this message translates to:
  /// **'Académica'**
  String get labelAcademic;

  /// No description provided for @labelHealth.
  ///
  /// In es, this message translates to:
  /// **'Salud'**
  String get labelHealth;

  /// No description provided for @frequencyDaily.
  ///
  /// In es, this message translates to:
  /// **'Diario'**
  String get frequencyDaily;

  /// No description provided for @frequencyWeekly.
  ///
  /// In es, this message translates to:
  /// **'Semanal'**
  String get frequencyWeekly;

  /// No description provided for @frequencyCustom.
  ///
  /// In es, this message translates to:
  /// **'Personalizado'**
  String get frequencyCustom;

  /// No description provided for @reminder5min.
  ///
  /// In es, this message translates to:
  /// **'5 min'**
  String get reminder5min;

  /// No description provided for @reminder15min.
  ///
  /// In es, this message translates to:
  /// **'15 min'**
  String get reminder15min;

  /// No description provided for @reminder30min.
  ///
  /// In es, this message translates to:
  /// **'30 min'**
  String get reminder30min;

  /// No description provided for @reminder60min.
  ///
  /// In es, this message translates to:
  /// **'60 min'**
  String get reminder60min;

  /// No description provided for @timeOnce.
  ///
  /// In es, this message translates to:
  /// **'vez'**
  String get timeOnce;

  /// No description provided for @timeTimes.
  ///
  /// In es, this message translates to:
  /// **'veces'**
  String get timeTimes;

  /// No description provided for @dayMon.
  ///
  /// In es, this message translates to:
  /// **'L'**
  String get dayMon;

  /// No description provided for @dayTue.
  ///
  /// In es, this message translates to:
  /// **'M'**
  String get dayTue;

  /// No description provided for @dayWed.
  ///
  /// In es, this message translates to:
  /// **'X'**
  String get dayWed;

  /// No description provided for @dayThu.
  ///
  /// In es, this message translates to:
  /// **'J'**
  String get dayThu;

  /// No description provided for @dayFri.
  ///
  /// In es, this message translates to:
  /// **'V'**
  String get dayFri;

  /// No description provided for @daySat.
  ///
  /// In es, this message translates to:
  /// **'S'**
  String get daySat;

  /// No description provided for @daySun.
  ///
  /// In es, this message translates to:
  /// **'D'**
  String get daySun;

  /// No description provided for @statsTitle.
  ///
  /// In es, this message translates to:
  /// **'Estadísticas'**
  String get statsTitle;

  /// No description provided for @completedPercent.
  ///
  /// In es, this message translates to:
  /// **'Completado'**
  String get completedPercent;

  /// No description provided for @weeklyStats.
  ///
  /// In es, this message translates to:
  /// **'Cumplimiento semanal'**
  String get weeklyStats;

  /// No description provided for @noDataWeek.
  ///
  /// In es, this message translates to:
  /// **'Sin datos esta semana'**
  String get noDataWeek;

  /// No description provided for @statsTotal.
  ///
  /// In es, this message translates to:
  /// **'Total'**
  String get statsTotal;

  /// No description provided for @statsWeek.
  ///
  /// In es, this message translates to:
  /// **'Esta semana'**
  String get statsWeek;

  /// No description provided for @achievementsTitle.
  ///
  /// In es, this message translates to:
  /// **'Logros'**
  String get achievementsTitle;

  /// No description provided for @achievementsUnlocked.
  ///
  /// In es, this message translates to:
  /// **'desbloqueados'**
  String get achievementsUnlocked;

  /// No description provided for @achievementsUnlockedTab.
  ///
  /// In es, this message translates to:
  /// **'Desbloqueados'**
  String get achievementsUnlockedTab;

  /// No description provided for @achievementsLockedTab.
  ///
  /// In es, this message translates to:
  /// **'Bloqueados'**
  String get achievementsLockedTab;

  /// No description provided for @noAchievementsTitle.
  ///
  /// In es, this message translates to:
  /// **'Sin logros'**
  String get noAchievementsTitle;

  /// No description provided for @noAchievementsSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Completa tareas y hábitos para desbloquear logros'**
  String get noAchievementsSubtitle;

  /// No description provided for @moreTitle.
  ///
  /// In es, this message translates to:
  /// **'Más'**
  String get moreTitle;

  /// No description provided for @personalizationSection.
  ///
  /// In es, this message translates to:
  /// **'Personalización'**
  String get personalizationSection;

  /// No description provided for @appearanceTitle.
  ///
  /// In es, this message translates to:
  /// **'Apariencia'**
  String get appearanceTitle;

  /// No description provided for @themeLight.
  ///
  /// In es, this message translates to:
  /// **'Claro'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In es, this message translates to:
  /// **'Oscuro'**
  String get themeDark;

  /// No description provided for @themeSystem.
  ///
  /// In es, this message translates to:
  /// **'Sistema'**
  String get themeSystem;

  /// No description provided for @themeSheetTitle.
  ///
  /// In es, this message translates to:
  /// **'Tema'**
  String get themeSheetTitle;

  /// No description provided for @dataSection.
  ///
  /// In es, this message translates to:
  /// **'Datos'**
  String get dataSection;

  /// No description provided for @backupTitle.
  ///
  /// In es, this message translates to:
  /// **'Copia de seguridad'**
  String get backupTitle;

  /// No description provided for @backupSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Exportar y restaurar'**
  String get backupSubtitle;

  /// No description provided for @exportDataTitle.
  ///
  /// In es, this message translates to:
  /// **'Exportar datos'**
  String get exportDataTitle;

  /// No description provided for @exportDataSubtitle.
  ///
  /// In es, this message translates to:
  /// **'CSV y PDF'**
  String get exportDataSubtitle;

  /// No description provided for @progressSection.
  ///
  /// In es, this message translates to:
  /// **'Progreso'**
  String get progressSection;

  /// No description provided for @calendarTitle.
  ///
  /// In es, this message translates to:
  /// **'Calendario'**
  String get calendarTitle;

  /// No description provided for @calendarSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Vista mensual y semanal'**
  String get calendarSubtitle;

  /// No description provided for @accountSection.
  ///
  /// In es, this message translates to:
  /// **'Cuenta'**
  String get accountSection;

  /// No description provided for @logoutTitle.
  ///
  /// In es, this message translates to:
  /// **'Cerrar sesión'**
  String get logoutTitle;

  /// No description provided for @logoutSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Salir de la aplicación'**
  String get logoutSubtitle;

  /// No description provided for @profileTitle.
  ///
  /// In es, this message translates to:
  /// **'Perfil'**
  String get profileTitle;

  /// No description provided for @memberSince.
  ///
  /// In es, this message translates to:
  /// **'Miembro desde {date}'**
  String memberSince(String date);

  /// No description provided for @recentMember.
  ///
  /// In es, this message translates to:
  /// **'Miembro reciente'**
  String get recentMember;

  /// No description provided for @currentStreak.
  ///
  /// In es, this message translates to:
  /// **'Racha actual'**
  String get currentStreak;

  /// No description provided for @achievementsCount.
  ///
  /// In es, this message translates to:
  /// **'Logros'**
  String get achievementsCount;

  /// No description provided for @settingsShortcut.
  ///
  /// In es, this message translates to:
  /// **'Configuración'**
  String get settingsShortcut;

  /// No description provided for @privacyShortcut.
  ///
  /// In es, this message translates to:
  /// **'Privacidad'**
  String get privacyShortcut;

  /// No description provided for @helpShortcut.
  ///
  /// In es, this message translates to:
  /// **'Ayuda'**
  String get helpShortcut;

  /// No description provided for @backupLocalSection.
  ///
  /// In es, this message translates to:
  /// **'LOCAL'**
  String get backupLocalSection;

  /// No description provided for @backupExportAllSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Exporta todas tus tareas y hábitos'**
  String get backupExportAllSubtitle;

  /// No description provided for @backupReportSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Genera un reporte visual'**
  String get backupReportSubtitle;

  /// No description provided for @backupFullSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Copia completa de la base de datos'**
  String get backupFullSubtitle;

  /// No description provided for @backupDriveSection.
  ///
  /// In es, this message translates to:
  /// **'GOOGLE DRIVE'**
  String get backupDriveSection;

  /// No description provided for @backupConnectDrive.
  ///
  /// In es, this message translates to:
  /// **'Conectar con Google Drive'**
  String get backupConnectDrive;

  /// No description provided for @backupSyncSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Sincroniza tus backups en la nube'**
  String get backupSyncSubtitle;

  /// No description provided for @backupUploadDrive.
  ///
  /// In es, this message translates to:
  /// **'Subir backup a Drive'**
  String get backupUploadDrive;

  /// No description provided for @backupUploadSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Crea backup local y súbelo'**
  String get backupUploadSubtitle;

  /// No description provided for @backupDisconnectDrive.
  ///
  /// In es, this message translates to:
  /// **'Desconectar Google Drive'**
  String get backupDisconnectDrive;

  /// No description provided for @backupSignOutDrive.
  ///
  /// In es, this message translates to:
  /// **'Cerrar sesión de Google'**
  String get backupSignOutDrive;

  /// No description provided for @noDriveBackups.
  ///
  /// In es, this message translates to:
  /// **'No hay backups en Drive'**
  String get noDriveBackups;

  /// No description provided for @driveBackups.
  ///
  /// In es, this message translates to:
  /// **'Backups en Drive'**
  String get driveBackups;

  /// No description provided for @backupSelectZip.
  ///
  /// In es, this message translates to:
  /// **'Selecciona un archivo .zip'**
  String get backupSelectZip;

  /// No description provided for @backupDefaultName.
  ///
  /// In es, this message translates to:
  /// **'Backup'**
  String get backupDefaultName;

  /// No description provided for @backupDownloadedTo.
  ///
  /// In es, this message translates to:
  /// **'Descargado a: {path}'**
  String backupDownloadedTo(String path);

  /// No description provided for @exportCsv.
  ///
  /// In es, this message translates to:
  /// **'Exportar a CSV'**
  String get exportCsv;

  /// No description provided for @exportPdf.
  ///
  /// In es, this message translates to:
  /// **'Exportar a PDF'**
  String get exportPdf;

  /// No description provided for @createBackup.
  ///
  /// In es, this message translates to:
  /// **'Crear backup ZIP'**
  String get createBackup;

  /// No description provided for @restoreBackupLocal.
  ///
  /// In es, this message translates to:
  /// **'Restaurar backup local'**
  String get restoreBackupLocal;

  /// No description provided for @backupSavedTo.
  ///
  /// In es, this message translates to:
  /// **'Guardado:\n{path}'**
  String backupSavedTo(String path);

  /// No description provided for @taskDetailTitle.
  ///
  /// In es, this message translates to:
  /// **'Detalle'**
  String get taskDetailTitle;

  /// No description provided for @taskDetailReminder.
  ///
  /// In es, this message translates to:
  /// **'minutos antes'**
  String get taskDetailReminder;

  /// No description provided for @taskDetailStatus.
  ///
  /// In es, this message translates to:
  /// **'Estado'**
  String get taskDetailStatus;

  /// No description provided for @taskDetailCompleted.
  ///
  /// In es, this message translates to:
  /// **'Completada ✓'**
  String get taskDetailCompleted;

  /// No description provided for @taskDetailEdit.
  ///
  /// In es, this message translates to:
  /// **'Editar'**
  String get taskDetailEdit;

  /// No description provided for @taskDetailComplete.
  ///
  /// In es, this message translates to:
  /// **'Completar'**
  String get taskDetailComplete;

  /// No description provided for @taskDetailCompletedAction.
  ///
  /// In es, this message translates to:
  /// **'Completada'**
  String get taskDetailCompletedAction;

  /// No description provided for @splashTagline.
  ///
  /// In es, this message translates to:
  /// **'Organiza tu día.\nConstruye mejores hábitos.'**
  String get splashTagline;

  /// No description provided for @splashOffline.
  ///
  /// In es, this message translates to:
  /// **'Sin conexión'**
  String get splashOffline;

  /// No description provided for @splashPrivate.
  ///
  /// In es, this message translates to:
  /// **'100% privado'**
  String get splashPrivate;

  /// No description provided for @splashReminders.
  ///
  /// In es, this message translates to:
  /// **'Recordatorios'**
  String get splashReminders;

  /// No description provided for @splashGetStarted.
  ///
  /// In es, this message translates to:
  /// **'Comenzar'**
  String get splashGetStarted;

  /// No description provided for @splashHaveAccount.
  ///
  /// In es, this message translates to:
  /// **'Ya tengo una cuenta'**
  String get splashHaveAccount;

  /// No description provided for @splashTermsPrefix.
  ///
  /// In es, this message translates to:
  /// **'Al continuar aceptas los '**
  String get splashTermsPrefix;

  /// No description provided for @splashTermsLink.
  ///
  /// In es, this message translates to:
  /// **'Términos'**
  String get splashTermsLink;

  /// No description provided for @splashTermsAnd.
  ///
  /// In es, this message translates to:
  /// **' y la '**
  String get splashTermsAnd;

  /// No description provided for @splashPrivacyLink.
  ///
  /// In es, this message translates to:
  /// **'Política de privacidad'**
  String get splashPrivacyLink;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In es, this message translates to:
  /// **'Recupera tu acceso'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordBody.
  ///
  /// In es, this message translates to:
  /// **'DayFlow funciona de forma offline. Si olvidaste tu contraseña, no podemos enviar un correo de recuperación. Te recomendamos crear una nueva cuenta.'**
  String get forgotPasswordBody;

  /// No description provided for @forgotPasswordBack.
  ///
  /// In es, this message translates to:
  /// **'Volver a iniciar sesión'**
  String get forgotPasswordBack;

  /// No description provided for @forgotPasswordCreateAccount.
  ///
  /// In es, this message translates to:
  /// **'Crear nueva cuenta'**
  String get forgotPasswordCreateAccount;

  /// No description provided for @backBtn.
  ///
  /// In es, this message translates to:
  /// **'Volver'**
  String get backBtn;

  /// No description provided for @biometricLoginLabel.
  ///
  /// In es, this message translates to:
  /// **'Iniciar sesión con biometría'**
  String get biometricLoginLabel;

  /// No description provided for @navDrawerProfile.
  ///
  /// In es, this message translates to:
  /// **'Mi perfil'**
  String get navDrawerProfile;

  /// No description provided for @navDrawerProfileSub.
  ///
  /// In es, this message translates to:
  /// **'Datos personales'**
  String get navDrawerProfileSub;

  /// No description provided for @navDrawerAchievements.
  ///
  /// In es, this message translates to:
  /// **'Logros'**
  String get navDrawerAchievements;

  /// No description provided for @navDrawerAchievementsSub.
  ///
  /// In es, this message translates to:
  /// **'Ver progreso'**
  String get navDrawerAchievementsSub;

  /// No description provided for @navDrawerAppearance.
  ///
  /// In es, this message translates to:
  /// **'Apariencia'**
  String get navDrawerAppearance;

  /// No description provided for @navDrawerAppearanceSub.
  ///
  /// In es, this message translates to:
  /// **'Tema oscuro'**
  String get navDrawerAppearanceSub;

  /// No description provided for @navDrawerNotifications.
  ///
  /// In es, this message translates to:
  /// **'Notificaciones'**
  String get navDrawerNotifications;

  /// No description provided for @navDrawerNotificationsSub.
  ///
  /// In es, this message translates to:
  /// **'Activadas'**
  String get navDrawerNotificationsSub;

  /// No description provided for @navDrawerCategories.
  ///
  /// In es, this message translates to:
  /// **'Categorías'**
  String get navDrawerCategories;

  /// No description provided for @navDrawerCategoriesSub.
  ///
  /// In es, this message translates to:
  /// **'Personal, Académica, Salud'**
  String get navDrawerCategoriesSub;

  /// No description provided for @navDrawerPrivacy.
  ///
  /// In es, this message translates to:
  /// **'Privacidad y datos'**
  String get navDrawerPrivacy;

  /// No description provided for @navDrawerPrivacySub.
  ///
  /// In es, this message translates to:
  /// **'Almacenamiento local'**
  String get navDrawerPrivacySub;

  /// No description provided for @navDrawerHelp.
  ///
  /// In es, this message translates to:
  /// **'Ayuda y soporte'**
  String get navDrawerHelp;

  /// No description provided for @navDrawerHelpSub.
  ///
  /// In es, this message translates to:
  /// **'Centro de ayuda'**
  String get navDrawerHelpSub;

  /// No description provided for @navDrawerLogout.
  ///
  /// In es, this message translates to:
  /// **'Cerrar sesión'**
  String get navDrawerLogout;

  /// No description provided for @pageNotFound.
  ///
  /// In es, this message translates to:
  /// **'Pantalla no encontrada'**
  String get pageNotFound;

  /// No description provided for @noPendingTasks.
  ///
  /// In es, this message translates to:
  /// **'Sin tareas pendientes'**
  String get noPendingTasks;

  /// No description provided for @errorTitle.
  ///
  /// In es, this message translates to:
  /// **'Algo salió mal'**
  String get errorTitle;

  /// No description provided for @retryButton.
  ///
  /// In es, this message translates to:
  /// **'Reintentar'**
  String get retryButton;

  /// No description provided for @validationNameEmpty.
  ///
  /// In es, this message translates to:
  /// **'El nombre es obligatorio'**
  String get validationNameEmpty;

  /// No description provided for @validationEmailInvalid.
  ///
  /// In es, this message translates to:
  /// **'Correo electrónico inválido'**
  String get validationEmailInvalid;

  /// No description provided for @validationPasswordShort.
  ///
  /// In es, this message translates to:
  /// **'La contraseña debe tener al menos 6 caracteres'**
  String get validationPasswordShort;

  /// No description provided for @validationHabitTitle.
  ///
  /// In es, this message translates to:
  /// **'El nombre del hábito es obligatorio'**
  String get validationHabitTitle;

  /// No description provided for @validationHabitGoal.
  ///
  /// In es, this message translates to:
  /// **'La meta debe ser mayor a 0'**
  String get validationHabitGoal;

  /// No description provided for @validationTaskTitle.
  ///
  /// In es, this message translates to:
  /// **'El título es obligatorio'**
  String get validationTaskTitle;

  /// No description provided for @validationTaskDate.
  ///
  /// In es, this message translates to:
  /// **'La fecha y hora son obligatorias'**
  String get validationTaskDate;

  /// No description provided for @emailInUse.
  ///
  /// In es, this message translates to:
  /// **'Ya existe una cuenta con este correo'**
  String get emailInUse;

  /// No description provided for @invalidCredentials.
  ///
  /// In es, this message translates to:
  /// **'Correo o contraseña incorrectos'**
  String get invalidCredentials;

  /// No description provided for @sessionRestoreError.
  ///
  /// In es, this message translates to:
  /// **'Error al restaurar sesión'**
  String get sessionRestoreError;

  /// No description provided for @monthJanuary.
  ///
  /// In es, this message translates to:
  /// **'enero'**
  String get monthJanuary;

  /// No description provided for @monthFebruary.
  ///
  /// In es, this message translates to:
  /// **'febrero'**
  String get monthFebruary;

  /// No description provided for @monthMarch.
  ///
  /// In es, this message translates to:
  /// **'marzo'**
  String get monthMarch;

  /// No description provided for @monthApril.
  ///
  /// In es, this message translates to:
  /// **'abril'**
  String get monthApril;

  /// No description provided for @monthMay.
  ///
  /// In es, this message translates to:
  /// **'mayo'**
  String get monthMay;

  /// No description provided for @monthJune.
  ///
  /// In es, this message translates to:
  /// **'junio'**
  String get monthJune;

  /// No description provided for @monthJuly.
  ///
  /// In es, this message translates to:
  /// **'julio'**
  String get monthJuly;

  /// No description provided for @monthAugust.
  ///
  /// In es, this message translates to:
  /// **'agosto'**
  String get monthAugust;

  /// No description provided for @monthSeptember.
  ///
  /// In es, this message translates to:
  /// **'septiembre'**
  String get monthSeptember;

  /// No description provided for @monthOctober.
  ///
  /// In es, this message translates to:
  /// **'octubre'**
  String get monthOctober;

  /// No description provided for @monthNovember.
  ///
  /// In es, this message translates to:
  /// **'noviembre'**
  String get monthNovember;

  /// No description provided for @monthDecember.
  ///
  /// In es, this message translates to:
  /// **'diciembre'**
  String get monthDecember;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
