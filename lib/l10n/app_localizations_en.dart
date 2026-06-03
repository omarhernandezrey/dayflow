// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'DayFlow';

  @override
  String get loginTitle => 'Welcome back!';

  @override
  String get loginSubtitle => 'Sign in to continue your progress.';

  @override
  String get loginButton => 'Sign in';

  @override
  String get registerButton => 'Sign up';

  @override
  String get forgotPassword => 'Forgot your password?';

  @override
  String get biometricPrompt => 'Use biometrics';

  @override
  String get noUserRegistered => 'No registered user';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailHint => 'you@email.com';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordHint => '••••••••';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get emailInvalid => 'Invalid email';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get passwordMinLength => 'Minimum 6 characters';

  @override
  String get passwordMinLengthDot => 'Minimum 6 characters.';

  @override
  String get nameLabel => 'Full name';

  @override
  String get nameRequired => 'Name is required';

  @override
  String get nameHint => 'Your name';

  @override
  String get registerTitle => 'Create account';

  @override
  String get registerSubtitle =>
      'Start organizing your day in less than a minute.';

  @override
  String get alreadyHaveAccount => 'Don\'t have an account yet? ';

  @override
  String get alreadyHaveAccountLogin => 'Already have an account? ';

  @override
  String get loginLink => 'Sign in';

  @override
  String get termsAccepted =>
      'I accept the terms of service and privacy policy.';

  @override
  String get termsRequired => 'You must accept the terms';

  @override
  String get logoutConfirm => 'Log out?';

  @override
  String get logoutMessage => 'You will lose access until you sign in again.';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get confirmButton => 'Confirm';

  @override
  String get deleteButton => 'Delete';

  @override
  String get saveButton => 'Save';

  @override
  String get homeTab => 'Home';

  @override
  String get tasksTab => 'Tasks';

  @override
  String get habitsTab => 'Habits';

  @override
  String get statsTab => 'Stats';

  @override
  String get moreTab => 'More';

  @override
  String get helloTitle => 'Hello!';

  @override
  String get upcomingActivities => 'Upcoming activities';

  @override
  String get noActivitiesToday => 'No pending activities today';

  @override
  String get goodJobDay => 'Great job! Enjoy your day.';

  @override
  String get totalActivities => 'Total\nactivities';

  @override
  String get addTaskTitle => 'New task';

  @override
  String get editTaskTitle => 'Edit task';

  @override
  String get taskTitleLabel => 'Title';

  @override
  String get taskTitleHint => 'Activity name';

  @override
  String get taskDescLabel => 'Description';

  @override
  String get taskDescHint => 'Optional description…';

  @override
  String get taskCategoryLabel => 'Category';

  @override
  String get taskDateLabel => 'Date';

  @override
  String get taskTimeLabel => 'Time';

  @override
  String get taskReminderLabel => 'Reminder';

  @override
  String reminderBefore(String minutes) {
    return '$minutes before';
  }

  @override
  String get saveTaskCreate => 'Save activity';

  @override
  String get saveTaskEdit => 'Save changes';

  @override
  String get taskTitleRequired => 'Title is required';

  @override
  String get addHabitTitle => 'New habit';

  @override
  String get editHabitTitle => 'Edit habit';

  @override
  String get habitNameLabel => 'Habit name';

  @override
  String get habitNameHint => 'Habit name…';

  @override
  String get habitGoalLabel => 'Daily goal';

  @override
  String get habitUnitLabel => 'Unit';

  @override
  String get habitFrequencyLabel => 'Frequency';

  @override
  String get habitIconLabel => 'Icon';

  @override
  String get saveHabitCreate => 'Create habit';

  @override
  String get saveHabitEdit => 'Save changes';

  @override
  String get habitNameRequired => 'Habit name is required';

  @override
  String get streakLabel => 'Streak';

  @override
  String get globalStreakLabel => 'Global streak';

  @override
  String get dailyStreak => 'DAILY STREAK';

  @override
  String get daysInARow => 'days in a row';

  @override
  String get completedLabel => 'Completed';

  @override
  String get completedExclamation => 'Completed!';

  @override
  String goalLabel(String value, String unit) {
    return 'Goal: $value $unit';
  }

  @override
  String get pendingLabel => 'Pending';

  @override
  String get noTasksTitle => 'You have no tasks';

  @override
  String get noTasksSubtitle => 'Add your first task to get started';

  @override
  String get noTasksAction => 'Add task';

  @override
  String get filterAll => 'All';

  @override
  String get today => 'Today';

  @override
  String get tomorrow => 'Tomorrow';

  @override
  String get later => 'Later';

  @override
  String get taskCompleted => 'Task completed';

  @override
  String get taskMarkComplete => 'Mark task as complete';

  @override
  String get noHabitsTitle => 'No habits for today';

  @override
  String get noHabitsSubtitle => 'Create a habit and start your streak';

  @override
  String get noHabitsAction => 'Create habit';

  @override
  String get todayHabits => 'Today\'s habits';

  @override
  String get allMyHabits => 'All my habits';

  @override
  String get deleteHabit => 'Delete habit';

  @override
  String deleteHabitConfirm(String name) {
    return 'Delete \"$name\"? This action cannot be undone.';
  }

  @override
  String get labelPersonal => 'Personal';

  @override
  String get labelAcademic => 'Academic';

  @override
  String get labelHealth => 'Health';

  @override
  String get frequencyDaily => 'Daily';

  @override
  String get frequencyWeekly => 'Weekly';

  @override
  String get frequencyCustom => 'Custom';

  @override
  String get reminder5min => '5 min';

  @override
  String get reminder15min => '15 min';

  @override
  String get reminder30min => '30 min';

  @override
  String get reminder60min => '60 min';

  @override
  String get timeOnce => 'time';

  @override
  String get timeTimes => 'times';

  @override
  String get dayMon => 'M';

  @override
  String get dayTue => 'T';

  @override
  String get dayWed => 'W';

  @override
  String get dayThu => 'T';

  @override
  String get dayFri => 'F';

  @override
  String get daySat => 'S';

  @override
  String get daySun => 'S';

  @override
  String get statsTitle => 'Statistics';

  @override
  String get completedPercent => 'Completed';

  @override
  String get weeklyStats => 'Weekly completion';

  @override
  String get noDataWeek => 'No data this week';

  @override
  String get statsTotal => 'Total';

  @override
  String get statsWeek => 'This week';

  @override
  String get achievementsTitle => 'Achievements';

  @override
  String get achievementsUnlocked => 'unlocked';

  @override
  String get achievementsUnlockedTab => 'Unlocked';

  @override
  String get achievementsLockedTab => 'Locked';

  @override
  String get noAchievementsTitle => 'No achievements';

  @override
  String get noAchievementsSubtitle =>
      'Complete tasks and habits to unlock achievements';

  @override
  String get moreTitle => 'More';

  @override
  String get personalizationSection => 'Personalization';

  @override
  String get appearanceTitle => 'Appearance';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSystem => 'System';

  @override
  String get themeSheetTitle => 'Theme';

  @override
  String get dataSection => 'Data';

  @override
  String get backupTitle => 'Backup';

  @override
  String get backupSubtitle => 'Export and restore';

  @override
  String get exportDataTitle => 'Export data';

  @override
  String get exportDataSubtitle => 'CSV and PDF';

  @override
  String get progressSection => 'Progress';

  @override
  String get calendarTitle => 'Calendar';

  @override
  String get calendarSubtitle => 'Monthly and weekly view';

  @override
  String get accountSection => 'Account';

  @override
  String get logoutTitle => 'Log out';

  @override
  String get logoutSubtitle => 'Leave the app';

  @override
  String get profileTitle => 'Profile';

  @override
  String memberSince(String date) {
    return 'Member since $date';
  }

  @override
  String get recentMember => 'Recent member';

  @override
  String get currentStreak => 'Current streak';

  @override
  String get achievementsCount => 'Achievements';

  @override
  String get settingsShortcut => 'Settings';

  @override
  String get privacyShortcut => 'Privacy';

  @override
  String get helpShortcut => 'Help';

  @override
  String get backupLocalSection => 'LOCAL';

  @override
  String get backupExportAllSubtitle => 'Export all your tasks and habits';

  @override
  String get backupReportSubtitle => 'Generate a visual report';

  @override
  String get backupFullSubtitle => 'Full database copy';

  @override
  String get backupDriveSection => 'GOOGLE DRIVE';

  @override
  String get backupConnectDrive => 'Connect to Google Drive';

  @override
  String get backupSyncSubtitle => 'Sync your backups to the cloud';

  @override
  String get backupUploadDrive => 'Upload backup to Drive';

  @override
  String get backupUploadSubtitle => 'Create local backup and upload';

  @override
  String get backupDisconnectDrive => 'Disconnect Google Drive';

  @override
  String get backupSignOutDrive => 'Sign out of Google';

  @override
  String get noDriveBackups => 'No backups on Drive';

  @override
  String get driveBackups => 'Backups on Drive';

  @override
  String get backupSelectZip => 'Select a .zip file';

  @override
  String get backupDefaultName => 'Backup';

  @override
  String backupDownloadedTo(String path) {
    return 'Downloaded to: $path';
  }

  @override
  String get exportCsv => 'Export to CSV';

  @override
  String get exportPdf => 'Export to PDF';

  @override
  String get createBackup => 'Create ZIP backup';

  @override
  String get restoreBackupLocal => 'Restore local backup';

  @override
  String backupSavedTo(String path) {
    return 'Saved:\n$path';
  }

  @override
  String get taskDetailTitle => 'Detail';

  @override
  String get taskDetailReminder => 'minutes before';

  @override
  String get taskDetailStatus => 'Status';

  @override
  String get taskDetailCompleted => 'Completed ✓';

  @override
  String get taskDetailEdit => 'Edit';

  @override
  String get taskDetailComplete => 'Complete';

  @override
  String get taskDetailCompletedAction => 'Completed';

  @override
  String get splashTagline => 'Organize your day.\nBuild better habits.';

  @override
  String get splashOffline => 'Offline';

  @override
  String get splashPrivate => '100% private';

  @override
  String get splashReminders => 'Reminders';

  @override
  String get splashGetStarted => 'Get started';

  @override
  String get splashHaveAccount => 'I already have an account';

  @override
  String get splashTermsPrefix => 'By continuing you agree to the ';

  @override
  String get splashTermsLink => 'Terms';

  @override
  String get splashTermsAnd => ' and the ';

  @override
  String get splashPrivacyLink => 'Privacy Policy';

  @override
  String get forgotPasswordTitle => 'Recover your access';

  @override
  String get forgotPasswordBody =>
      'DayFlow works offline. If you forgot your password, we can\'t send a recovery email. We recommend creating a new account.';

  @override
  String get forgotPasswordBack => 'Sign in again';

  @override
  String get forgotPasswordCreateAccount => 'Create a new account';

  @override
  String get backBtn => 'Back';

  @override
  String get biometricLoginLabel => 'Sign in with biometrics';

  @override
  String get navDrawerProfile => 'My profile';

  @override
  String get navDrawerProfileSub => 'Personal data';

  @override
  String get navDrawerAchievements => 'Achievements';

  @override
  String get navDrawerAchievementsSub => 'View progress';

  @override
  String get navDrawerAppearance => 'Appearance';

  @override
  String get navDrawerAppearanceSub => 'Dark theme';

  @override
  String get navDrawerNotifications => 'Notifications';

  @override
  String get navDrawerNotificationsSub => 'Enabled';

  @override
  String get navDrawerCategories => 'Categories';

  @override
  String get navDrawerCategoriesSub => 'Personal, Academic, Health';

  @override
  String get navDrawerPrivacy => 'Privacy & data';

  @override
  String get navDrawerPrivacySub => 'Local storage';

  @override
  String get navDrawerHelp => 'Help & support';

  @override
  String get navDrawerHelpSub => 'Help center';

  @override
  String get navDrawerLogout => 'Log out';

  @override
  String get pageNotFound => 'Page not found';

  @override
  String get noPendingTasks => 'No pending tasks';

  @override
  String get errorTitle => 'Something went wrong';

  @override
  String get retryButton => 'Retry';

  @override
  String get validationNameEmpty => 'Name is required';

  @override
  String get validationEmailInvalid => 'Invalid email';

  @override
  String get validationPasswordShort =>
      'Password must be at least 6 characters';

  @override
  String get validationHabitTitle => 'Habit name is required';

  @override
  String get validationHabitGoal => 'Goal must be greater than 0';

  @override
  String get validationTaskTitle => 'Title is required';

  @override
  String get validationTaskDate => 'Date and time are required';

  @override
  String get emailInUse => 'An account with this email already exists';

  @override
  String get invalidCredentials => 'Incorrect email or password';

  @override
  String get sessionRestoreError => 'Error restoring session';

  @override
  String get monthJanuary => 'January';

  @override
  String get monthFebruary => 'February';

  @override
  String get monthMarch => 'March';

  @override
  String get monthApril => 'April';

  @override
  String get monthMay => 'May';

  @override
  String get monthJune => 'June';

  @override
  String get monthJuly => 'July';

  @override
  String get monthAugust => 'August';

  @override
  String get monthSeptember => 'September';

  @override
  String get monthOctober => 'October';

  @override
  String get monthNovember => 'November';

  @override
  String get monthDecember => 'December';
}
