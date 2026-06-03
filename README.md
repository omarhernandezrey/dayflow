<div align="center">

# DayFlow

**Gestor personal de actividades, hábitos y estadísticas — 100 % offline-first**

[![Flutter](https://img.shields.io/badge/Flutter-3.44+-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.4+-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Android](https://img.shields.io/badge/Android-API%2021+-3DDC84?logo=android&logoColor=white)](https://developer.android.com)
[![iOS](https://img.shields.io/badge/iOS-12.0+-000000?logo=apple&logoColor=white)](https://developer.apple.com)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

*Organiza tu día, construye hábitos, mide tu progreso. Sin servidores, sin nube, sin distracciones.*

</div>

---

## Tabla de contenido

- [Descripción](#descripción)
- [Capturas de pantalla](#capturas-de-pantalla)
- [Características](#características)
- [Arquitectura](#arquitectura)
- [Stack tecnológico](#stack-tecnológico)
- [Estructura del proyecto](#estructura-del-proyecto)
- [Base de datos](#base-de-datos)
- [Gestión de estado](#gestión-de-estado)
- [Navegación](#navegación)
- [Internacionalización (i18n)](#internacionalización-i18n)
- [Sistema de diseño](#sistema-de-diseño)
- [Instalación y ejecución](#instalación-y-ejecución)
- [Compilar para distribución](#compilar-para-distribución)
- [Requerimientos](#requerimientos)
- [Roadmap](#roadmap)
- [Créditos](#créditos)

---

## Descripción

**DayFlow** es una aplicación móvil multiplataforma desarrollada en Flutter que permite al usuario:

- **Registrar actividades** con categoría (Personal / Académica / Salud), fecha, hora y recordatorio automático.
- **Construir hábitos** con seguimiento cuantificable, metas configurables y racha diaria.
- **Revisar estadísticas** semanales y mensuales a través de gráficas interactivas.
- **Exportar y respaldar** sus datos en CSV, PDF o ZIP cifrado, con sincronización opcional a Google Drive.
- **Autenticarse localmente** con correo/contraseña o biometría (huella / Face ID).

Todos los datos se almacenan en SQLite local — **ningún dato sale del dispositivo** salvo que el usuario lo exporte explícitamente.

> Proyecto académico — Politécnico Grancolombiano · Subgrupo 10

---

## Capturas de pantalla

> *Las capturas se agregarán una vez finalizado el diseño visual.*

---

## Características

### Funcionales

| # | Módulo | Descripción |
|---|---|---|
| RF-01 | Actividades | Crear, editar y eliminar tareas con título, descripción, categoría, fecha, hora y recordatorio |
| RF-02 | Notificaciones | Recordatorios locales programados 5, 15, 30 o 60 min antes de cada actividad |
| RF-03 | Hábitos | Crear hábitos con icono, color, frecuencia (diaria/semanal/personalizada), días activos y meta cuantificable |
| RF-04 | Progreso de hábitos | Incrementar progreso por unidad, barra de avance animada, confeti al completar |
| RF-05 | Racha diaria | Cálculo automático de racha global y por hábito individual |
| RF-06 | Estadísticas diarias | Resumen de actividades completadas, pendientes y porcentaje de cumplimiento |
| RF-07 | Estadísticas semanales | Gráfico de barras por día + donut de porcentaje semanal |
| RF-08 | Estadísticas mensuales | Tasa de completitud diaria, mejor racha y racha actual del mes |
| RF-09 | Filtrado y búsqueda | Filtrar tareas por categoría y búsqueda global de tareas y hábitos |
| RF-10 | Logros | Sistema de achievements desbloqueables por hitos de productividad |
| RF-11 | Autenticación | Registro e inicio de sesión local con hash SHA-256+salt, sesión persistente |
| RF-12 | Biometría | Inicio de sesión con huella dactilar o Face ID (restaura sesión sin exponer contraseña) |
| RF-13 | Exportación | Exportar datos a CSV y PDF; crear/restaurar backup en ZIP |
| RF-14 | Google Drive | Sincronización opcional del backup cifrado con Google Drive personal |
| RF-15 | Temas | Tema oscuro y claro conmutables, con soporte a preferencia del sistema |
| RF-16 | Widget de pantalla principal | Home screen widget de Android con resumen del día |
| RF-17 | Calendario | Vista de actividades en calendario mensual |
| RF-18 | Internacionalización | Soporte completo EN/ES con 145+ claves traducidas |

### No funcionales

| # | Atributo | Implementación |
|---|---|---|
| RNF-01 | Inicio rápido | Inicialización mínima en `main()`: locale + notificaciones + home widget |
| RNF-02 | Compatibilidad | Android API 21+ · iOS 12+ · Windows · Linux · macOS |
| RNF-03 | 100 % offline | SQLite local — sin backend, sin Firebase, sin telemetría |
| RNF-04 | Privacidad | Datos exclusivamente en el dispositivo; exportación siempre bajo control del usuario |
| RNF-05 | Seguridad | Contraseñas con hash SHA-256 + salt aleatorio; migración automática de hashes legacy |
| RNF-06 | Arquitectura limpia | Clean Architecture: domain / data / presentation completamente desacopladas |
| RNF-07 | Fuentes bundled | Inter y JetBrains Mono como assets — sin dependencia de red para tipografía |
| RNF-08 | Accesibilidad | Semantics labels en widgets interactivos; InkWell con feedback táctil |
| RNF-09 | Validación de dominio | Validators centralizados en capa de dominio (email, contraseña, nombre) |

---

## Arquitectura

DayFlow implementa **Clean Architecture** con separación estricta en tres capas, más una capa de features para código específico de pantalla:

```
┌──────────────────────────────────────────────────────────────────┐
│                    PRESENTATION LAYER                            │
│   Screens (ConsumerWidget)  ·  Providers (Riverpod Notifier)     │
│   Widgets reutilizables  ·  Tema y navegación  ·  L10n          │
├──────────────────────────────────────────────────────────────────┤
│                      DOMAIN LAYER                                │
│   Entities (clases puras Dart, sin Flutter)                      │
│   Repository interfaces (contratos abstractos)                   │
│   Use Cases (lógica de negocio atómica)                           │
│   Validators (validación de email, contraseña, nombre)           │
├──────────────────────────────────────────────────────────────────┤
│                       DATA LAYER                                 │
│   Repository implementations                                     │
│   Data sources (LocalDatabase, FileDatasource, BiometricDs…)    │
│   Models (toMap / fromMap ↔ SQLite)                              │
│   Helpers (executeOrFailure — boilerplate reduction)              │
└──────────────────────────────────────────────────────────────────┘
```

**Principios clave:**

- Las pantallas **solo leen** estado mediante `ref.watch()` con selectores cuando es posible — nunca acceden directamente a datos.
- Los `AsyncNotifier` encapsulan toda la lógica de mutación y orquestan repositorios.
- El dominio **no depende de Flutter** — solo de Dart puro y `dartz` para `Either<Failure, T>`.
- Los repositorios convierten excepciones de infraestructura en `Failure` tipados vía `executeOrFailure()`.
- Todos los `CREATE TABLE` usan `IF NOT EXISTS` — el esquema es idempotente.

---

## Stack tecnológico

### Core

| Paquete | Version | Uso |
|---|---|---|
| `flutter` | 3.44+ | Framework principal |
| `dart` | 3.4+ | Null-safety, enums, records |
| `flutter_riverpod` | ^2.5 | Gestión de estado (`AsyncNotifier`, `FutureProvider`) |
| `go_router` | ^14.6 | Navigation declarativa con `StatefulShellRoute` |
| `dartz` | ^0.10 | Programmation fonctionnelle — `Either<Failure, T>` |
| `equatable` | ^2.0 | Comparaison par valeur en entités |
| `flutter_localizations` | SDK | Generation de l10n (145+ claves EN/ES) |

### Persistencia

| Paquete | Version | Uso |
|---|---|---|
| `sqflite` | ^2.3 | SQLite local — 6 tablas relationales |
| `sqflite_common_ffi` | ^2.3 | Soporte SQLite en Windows / Linux / macOS |
| `shared_preferences` | ^2.3 | Preferencias simples del usuario |
| `path` | ^1.9 | Resolución de rutas del sistema de archivos |
| `path_provider` | ^2.1 | Directorio de documentos para exportaciones |

### Autenticación y seguridad

| Paquete | Version | Uso |
|---|---|---|
| `crypto` | ^3.0 | Hash SHA-256 + salt de contraseñas |
| `local_auth` | ^2.3 | Biometría (huella / Face ID) |
| `local_auth_android` | ^1.0 | API específica de Android |
| `local_auth_darwin` | ^1.6 | API específica de iOS/macOS |

### Exportación y backup

| Paquete | Version | Uso |
|---|---|---|
| `csv` | ^6.0 | Generación de archivos CSV |
| `pdf` | ^3.10 | Generación de reportes PDF |
| `archive` | ^3.6 | Compresión ZIP para backups |
| `google_sign_in` | ^6.2 | OAuth2 con Google |
| `googleapis` | ^13.2 | API de Google Drive |
| `extension_google_sign_in_as_googleapis_auth` | ^2.0 | Autenticación de googleapis via google_sign_in |

### UI y animaciones

| Paquete | Version | Uso |
|---|---|---|
| `fl_chart` | ^0.70 | `PieChart` (donut) + `BarChart` semanal |
| `flutter_animate` | ^4.5 | Animaciones declarativas de entrada/salida |
| `confetti` | ^0.8 | Lluvia de confeti al completar hábitos |
| `shimmer` | ^3.0 | Skeleton loader en listas |
| `table_calendar` | ^3.0 | Vista de calendario mensual |

**Tipografía bundled:** Inter (Regular + Italic) y JetBrains Mono (Regular + Bold) como assets — sin dependencia de `google_fonts` ni red.

### Otras

| Paquete | Version | Uso |
|---|---|---|
| `flutter_local_notifications` | ^17.2 | Notificaciones locales programadas |
| `timezone` | ^0.9 | `zonedSchedule` exacto para notificaciones |
| `home_widget` | ^0.7 | Widget en pantalla de inicio (Android/iOS) |
| `intl` | ^0.20 | Fechas y horas localizadas |

### Testing

| Paquete | Version | Uso |
|---|---|---|
| `flutter_test` | SDK | Tests unitarios y de widgets |
| `mocktail` | ^1.0.4 | Mocks para tests de use cases y repositorios |

---

## Estructura del proyecto

```
dayflow/
├── android/                          # Configuración Android (Gradle, Manifests)
├── ios/                              # Configuración iOS (Xcode, Info.plist)
├── assets/
│   └── fonts/                        # Inter + JetBrains Mono (bundled offline)
├── lib/
│   ├── main.dart                     # Punto de entrada — FFI init, locale, notificaciones
│   ├── app.dart                      # MaterialApp.router con tema, l10n y rutas
│   │
│   ├── core/                         # Infraestructura transversal
│   │   ├── constants/                # Constantes globales de la app
│   │   ├── errors/
│   │   │   ├── exceptions.dart       # AppException y subclases
│   │   │   └── failures.dart         # Failures tipados
│   │   ├── routes/
│   │   │   └── app_router.dart       # GoRouter — todas las rutas
│   │   ├── services/
│   │   │   └── home_widget_service.dart
│   │   ├── theme/
│   │   │   ├── app_colors.dart       # Tokens de color (dark palette)
│   │   │   ├── app_dimensions.dart   # Grilla 4pt — spacing, radii, heights
│   │   │   ├── app_light_theme.dart  # ThemeData claro
│   │   │   ├── app_shadows.dart      # Sombras y glows direccionales
│   │   │   ├── app_theme.dart        # ThemeData oscuro
│   │   │   ├── app_typography.dart   # Escala tipográfica + Material 3 TextTheme
│   │   │   └── task_category_ext.dart # Mapeo de colores por categoría (extensión)
│   │   ├── utils/
│   │   │   └── df_date_utils.dart    # isoDate · displayDate · formatTime · today
│   │   └── widgets/                  # Widgets de sistema reutilizables
│   │
│   ├── domain/                        # Lógica de negocio pura (sin Flutter)
│   │   ├── entities/                 # Task, Habit, User, Achievement, DailySummary…
│   │   ├── repositories/             # Interfaces abstractas de repositorios
│   │   ├── usecases/                  # Un use case por operación de negocio
│   │   │   ├── auth/                  # Login, Register, Logout, IsAuthenticated, RestoreSession
│   │   │   ├── habits/               # AddHabit, UpdateHabit, GetHabitStreak, GetGlobalStreak…
│   │   │   ├── tasks/                # AddTask, ToggleTask, SearchTasks…
│   │   │   ├── stats/                # GetTodayStats, GetWeeklyStats, GetMonthlyStats
│   │   │   ├── backup/               # ExportCsv, ExportPdf, CreateBackup, RestoreBackup
│   │   │   └── achievements/         # GetAchievements, CheckAchievements
│   │   └── validators/               # Validators (email, contraseña, nombre)
│   │
│   ├── data/                          # Implementaciones de infraestructura
│   │   ├── datasources/
│   │   │   ├── local_database.dart         # Contrato abstracto + databaseName getter
│   │   │   ├── local_database_impl.dart    # SQLite — esquema v3 con 6 tablas
│   │   │   ├── file_datasource.dart        # CSV, PDF, ZIP
│   │   │   ├── biometric_datasource.dart   # LocalAuthentication
│   │   │   └── google_drive_datasource.dart
│   │   ├── helpers/
│   │   │   └── repository_helper.dart     # executeOrFailure<T>() — boilerplate reduction
│   │   ├── models/                    # Conversión entity ↔ Map<String,dynamic>
│   │   └── repositories/             # Implementan interfaces del dominio
│   │
│   ├── l10n/                          # Internacionalización
│   │   ├── app_es.arb                 # 145+ claves en español (template)
│   │   ├── app_en.arb                 # 145+ claves en inglés
│   │   ├── app_localizations.dart     # Generado por flutter gen-l10n
│   │   ├── app_localizations_es.dart
│   │   └── app_localizations_en.dart
│   │
│   ├── presentation/                  # UI de la capa de presentación
│   │   ├── providers/                 # Riverpod providers y notifiers
│   │   │   ├── datasource_providers.dart   # LocalDatabase, FileDatasource
│   │   │   ├── repository_providers.dart   # 7 repos con DI
│   │   │   ├── task_usecase_providers.dart  # 6 use cases de tareas
│   │   │   ├── habit_usecase_providers.dart # 7 use cases de hábitos
│   │   │   ├── stats_usecase_providers.dart # 3 use cases de estadísticas
│   │   │   ├── achievement_usecase_providers.dart
│   │   │   ├── auth_usecase_providers.dart   # 7 use cases de autenticación
│   │   │   ├── backup_usecase_providers.dart # 4 use cases de backup
│   │   │   ├── dependency_providers.dart     # Barrel export de todos los providers
│   │   │   ├── auth_provider.dart
│   │   │   ├── habits_provider.dart
│   │   │   ├── tasks_provider.dart           # + todayUpcomingTasksProvider
│   │   │   ├── stats_provider.dart
│   │   │   ├── achievements_provider.dart
│   │   │   ├── backup_provider.dart
│   │   │   ├── theme_provider.dart           # Notifier<ThemeModeOption>
│   │   │   ├── biometric_provider.dart
│   │   │   ├── google_drive_provider.dart
│   │   │   ├── celebration_provider.dart
│   │   │   └── home_widget_updater_provider.dart  # Con debounce 500ms
│   │   ├── screens/                   # Pantallas por módulo
│   │   └── widgets/                   # Widgets de presentación reutilizables
│   │
│   ├── features/                      # Código específico de features complejas
│   │   ├── auth/                      # Splash, Login, Register, ForgotPassword
│   │   ├── habits/                    # AddHabitScreen (selector icono/color/días)
│   │   ├── tasks/                    # AddTaskScreen, TaskDetailScreen
│   │   └── more/                      # ProfileScreen, NotificationsScreen
│   │
│   └── shared/
│       └── widgets/
│           ├── df_app_bar.dart         # AppBar personalizada
│           └── df_nav_shell.dart       # Bottom nav + 5 ramas con estado preservado
│
├── test/                              # Tests unitarios
│   ├── data/repositories/             # AuthHashing tests
│   ├── domain/entities/              # Task, Habit, User entity tests
│   ├── domain/usecases/auth/         # Login, Register use case tests
│   ├── domain/usecases/habits/
│   ├── domain/usecases/tasks/
│   └── helpers/mocks.dart            # Mocktail mocks
│
├── pubspec.yaml
├── l10n.yaml                          # Config de flutter gen-l10n
└── README.md
```

---

## Base de datos

Archivo local: `dayflow.db` (SQLite, versión de esquema 3). `PRAGMA foreign_keys = ON` activo. Todos los `CREATE TABLE` usan `IF NOT EXISTS` para garantizar idempotencia.

### Tabla `tasks`

| Columna | Tipo | Descripción |
|---|---|---|
| `id` | `INTEGER PK AUTOINCREMENT` | Identificador único |
| `title` | `TEXT NOT NULL` | Título de la actividad |
| `description` | `TEXT NOT NULL DEFAULT ''` | Descripción opcional |
| `category` | `TEXT NOT NULL DEFAULT 'personal'` | `personal` · `academic` · `health` |
| `date` | `TEXT NOT NULL` | Fecha ISO `YYYY-MM-DD` |
| `time` | `TEXT NOT NULL` | Hora `HH:mm` |
| `reminder_minutes` | `INTEGER NOT NULL DEFAULT 15` | Minutos antes del recordatorio |
| `completed` | `INTEGER NOT NULL DEFAULT 0` | `0` = pendiente · `1` = completada |

### Tabla `habits`

| Columna | Tipo | Descripción |
|---|---|---|
| `id` | `INTEGER PK AUTOINCREMENT` | Identificador único |
| `title` | `TEXT NOT NULL` | Nombre del hábito |
| `icon` | `TEXT NOT NULL DEFAULT 'water'` | `water` · `dumbbell` · `leaf` · `moon` · `book` · `sparkle` |
| `color_hex` | `TEXT NOT NULL DEFAULT '#3D7BFF'` | Color en formato `#RRGGBB` |
| `frequency` | `TEXT NOT NULL DEFAULT 'daily'` | `daily` · `weekly` · `custom` |
| `active_days` | `TEXT NOT NULL DEFAULT '1111100'` | 7 chars Lun→Dom: `'1'` = activo · `'0'` = inactivo |
| `goal` | `REAL NOT NULL DEFAULT 1.0` | Meta diaria (unidades) |
| `unit` | `TEXT NOT NULL DEFAULT 'count'` | Etiqueta de la unidad |

### Tabla `habit_progress`

| Columna | Tipo | Descripción |
|---|---|---|
| `id` | `INTEGER PK AUTOINCREMENT` | Identificador único |
| `habit_id` | `INTEGER NOT NULL` | FK → `habits(id) ON DELETE CASCADE` |
| `date` | `TEXT NOT NULL` | Fecha ISO `YYYY-MM-DD` |
| `current_value` | `REAL NOT NULL DEFAULT 0` | Progreso actual del día |
| `target_value` | `REAL NOT NULL DEFAULT 1` | Meta del día (snapshot de `habits.goal`) |
| `unit` | `TEXT NOT NULL DEFAULT 'count'` | Unidad del progreso |
| — | `UNIQUE(habit_id, date)` | Un registro por hábito por día |

### Tabla `achievements`

| Columna | Tipo | Descripción |
|---|---|---|
| `id` | `INTEGER PK AUTOINCREMENT` | Identificador único |
| `key` | `TEXT NOT NULL UNIQUE` | Clave del logro (`first_task`, `streak_7`…) |
| `title` | `TEXT NOT NULL` | Nombre del logro |
| `description` | `TEXT NOT NULL` | Descripción |
| `icon` | `TEXT NOT NULL` | Ícono del logro |
| `unlocked_at` | `TEXT` | ISO timestamp de desbloqueo, `NULL` = bloqueado |
| `progress` | `INTEGER NOT NULL DEFAULT 0` | Progreso actual hacia la meta |
| `target` | `INTEGER NOT NULL DEFAULT 1` | Meta para desbloquear |

### Tabla `settings`

| Columna | Tipo | Descripción |
|---|---|---|
| `key` | `TEXT PK` | Clave de configuración |
| `value` | `TEXT NOT NULL` | Valor serializado |

### Tabla `users`

| Columna | Tipo | Descripción |
|---|---|---|
| `id` | `INTEGER PK AUTOINCREMENT` | Identificador único |
| `name` | `TEXT NOT NULL` | Nombre completo |
| `email` | `TEXT NOT NULL UNIQUE` | Correo electrónico (minúsculas) |
| `password_hash` | `TEXT NOT NULL` | SHA-256 con salt (formato: `hash$salt`) |
| `created_at` | `TEXT` | ISO timestamp de creación |

> **Nota:** El hash de contraseña usa formato `hash$salt` con migración automática de hashes legacy (sin salt). La entidad de dominio `UserEntity` no expone `passwordHash`.

---

## Gestión de estado

DayFlow usa **Riverpod 2.x** como sistema de gestión de estado. La inyección de dependencias se organiza en módulos por feature (ver `presentation/providers/`).

```
Provider                           Tipo                        Responsabilidad
────────────────────────────────────────────────────────────────────────────────────
Datasource providers
  localDatabaseProvider            Provider<LocalDatabase>     Singleton SQLite
  fileDatasourceProvider           Provider<FileDatasource>    CSV, PDF, ZIP

Repository providers
  taskRepositoryProvider           Provider<TaskRepository>    Tareas + notificaciones
  habitRepositoryProvider          Provider<HabitRepository>   Hábitos CRUD
  statsRepositoryProvider          Provider<StatsRepository>   Estadísticas
  achievementRepositoryProvider    Provider<AchievementRepo>   Logros
  authRepositoryProvider            Provider<AuthRepository>    Auth + hash con salt
  settingsRepositoryProvider       Provider<SettingsRepo>      Preferencias
  backupRepositoryProvider          Provider<BackupRepository>  Export/Import

State providers
  authStateProvider                 AsyncNotifier<AuthUser?>     Sesión del usuario
  habitsProvider                    AsyncNotifier<List<Habit>>  CRUD de hábitos
  todayProgressProvider            AsyncNotifier<Map<int, HP>>  Progreso de hoy
  globalStreakProvider             FutureProvider<int>          Racha global
  tasksProvider                     AsyncNotifier<List<Task>>   CRUD de tareas
  todayUpcomingTasksProvider        Provider<AsyncValue<List>>  Tareas pendientes de hoy
  filteredTasksProvider            Provider<AsyncValue<List>>   Tareas filtradas por categoría
  themeModeProvider                 Notifier<ThemeModeOption>   Modo de tema
  homeWidgetUpdaterProvider        Provider<void>              Home widget (debounced 500ms)
```

---

## Navegación

Implementada con `go_router` y `StatefulShellRoute.indexedStack`. Las 5 ramas del bottom nav **preservan su estado** al cambiar entre ellas.

```
/splash               →  SplashScreen (decide: auth → /home, no auth → /login)
/login                →  LoginScreen
/register             →  RegisterScreen
/forgot-password      →  ForgotPasswordScreen

Shell (DFNavShell — bottom nav 5 pestañas)
├── /home             →  HomeScreen        (Dashboard + actividades próximas)
├── /tasks            →  TasksScreen       (Lista filtrable + búsqueda)
├── /habits           →  HabitsScreen      (Racha + progreso diario + gestión)
├── /stats            →  StatsScreen       (Gráficas semanales y mensuales)
└── /more             →  MoreScreen        (Perfil + ajustes + backup)

Rutas adicionales (fuera del shell)
├── /add-task         →  AddTaskScreen     (extra: TaskEntity? — null = nueva)
├── /task-detail      →  TaskDetailScreen  (extra: TaskEntity)
├── /add-habit        →  AddHabitScreen    (extra: HabitEntity? — null = nueva)
├── /calendar         →  CalendarScreen
├── /achievements     →  AchievementsScreen
├── /backup           →  BackupScreen
├── /notifications    →  NotificationsScreen
└── /profile          →  ProfileScreen
```

---

## Internacionalización (i18n)

DayFlow soporta **español (es_ES)** e **inglés (en_US)** con 145+ claves traducidas, generadas por `flutter gen-l10n`.

- Archivos ARB: `lib/l10n/app_es.arb` (template) y `lib/l10n/app_en.arb`
- Generados: `lib/l10n/app_localizations.dart`, `app_localizations_es.dart`, `app_localizations_en.dart`
- Uso en código: `final l10n = AppLocalizations.of(context)!;` → `l10n.helloTitle`, `l10n.loginButton`, etc.
- Locale por defecto: `es_ES`
- Strings parametrizados: `l10n.goalLabel(value, unit)`, `l10n.memberSince(date)`, `l10n.deleteHabitConfirm(name)`

Todos los strings de UI en las 15+ pantallas usan `AppLocalizations`. Los providers sin `BuildContext` (como `homeWidgetUpdaterProvider`) mantienen strings hardcodeados.

---

## Sistema de diseño

### Paleta de colores (tema oscuro)

| Token | Hex | Uso |
|---|---|---|
| `bg` | `#0E0F13` | Fondo de scaffolds |
| `surface` | `#181A20` | Tarjetas y contenedores |
| `surface2` | `#1F222A` | Superficies elevadas (modales) |
| `surfaceHi` | `#262A33` | Hover / pressed state |
| `blue` | `#3D7BFF` | Primario de marca |
| `blueDeep` | `#2A5BC8` | Pressed / variante oscura del primario |
| `blueSoft` | `#3D7BFF26` | Fondo de acciones azules (15% opacidad) |
| `violet` | `#7C3AED` | Acentos secundario |
| `catAcademic` | `#3D7BFF` | Categoría Académica |
| `catHealth` | `#22C55E` | Categoría Salud |
| `catPersonal` | `#F59E0B` | Categoría Personal |
| `success` | `#22C55E` | Estados positivos |
| `warning` | `#F59E0B` | Estados de alerta |
| `danger` | `#EF4444` | Acciones destructivas |
| `text` | `#F2F3F7` | Texto principal |
| `textDim` | `#A4A8B3` | Texto secundario |
| `textMute` | `#6B6F7A` | Hints y placeholders |

### Tipografía (bundled — sin `google_fonts`)

| Estilo | Fuente | Tamaño | Peso | Uso |
|---|---|---|---|---|
| `display` | Inter | 56 | 800 | Números grandes de estadísticas |
| `titleXl` | Inter | 34 | 800 | Encabezados de sección |
| `title` | Inter | 24 | 800 | Títulos de pantalla |
| `heading` | Inter | 17 | 700 | AppBar, subtítulos |
| `bodyLg` | Inter | 15 | 500 | Cuerpo principal |
| `body` | Inter | 14 | 500 | Listas y contenido |
| `label` | Inter | 12 | 700 | Etiquetas en mayúsculas |
| `caption` | Inter | 11.5 | 500 | Metadata, timestamps |
| `numeric` | JetBrains Mono | 22 | 700 | Horas, porcentajes, contadores |

### Espaciado (grilla de 4pt)

| Token | px | Token | px |
|---|---|---|---|
| `s1` | 4 | `s6` | 24 |
| `s2` | 8 | `s8` | 32 |
| `s3` | 12 | `s10` | 40 |
| `s4` | 16 | `s12` | 48 |
| `s5` | 20 | | |

### Radios de borde

| Token | px | Uso típico |
|---|---|---|
| `rXs` | 6 | Chips, indicadores |
| `rSm` | 10 | Botones secundarios, iconos |
| `rMd` | 14 | Inputs, tarjetas medianas |
| `rLg` | 18 | Tarjetas grandes |
| `rXl` | 24 | Hero cards, modales |
| `rPill` | 999 | Chips redondeados, badges |

---

## Instalación y ejecución

### Prerrequisitos

| Herramienta | Versión mínima | Enlace |
|---|---|---|
| Flutter SDK | 3.4+ | [flutter.dev](https://flutter.dev/docs/get-started/install) |
| Dart SDK | 3.4+ | incluido con Flutter |
| Android Studio | Hedgehog+ | [developer.android.com](https://developer.android.com/studio) |
| Xcode | 14+ | solo para iOS/macOS |
| Git | cualquiera | [git-scm.com](https://git-scm.com) |

### Clonar y ejecutar

```bash
# 1. Clonar el repositorio
git clone https://github.com/omarhernandezrey/dayflow.git
cd dayflow

# 2. Instalar dependencias
flutter pub get

# 3. Generar archivos de localización
flutter gen-l10n

# 4. Verificar que el código está limpio
flutter analyze

# 5. Ejecutar en modo debug (conectar dispositivo o iniciar emulador primero)
flutter run

# Para un dispositivo específico
flutter run -d <device-id>

# Listar dispositivos disponibles
flutter devices
```

> **Windows / Linux / macOS:** sqflite usa FFI automáticamente (configurado en `main.dart`).
> **Web:** sqflite no es compatible con Chrome — usar Android o desktop.

---

## Compilar para distribución

```bash
# Android — APK universal
flutter build apk --release

# Android — App Bundle (recomendado para Play Store)
flutter build appbundle --release

# iOS (requiere macOS + Xcode firmado)
flutter build ios --release

# Windows
flutter build windows --release

# macOS
flutter build macos --release
```

---

## Requerimientos

### Plataformas soportadas

| Plataforma | Versión mínima | Estado |
|---|---|---|
| Android | API 21 (Android 5.0) | ✅ Principal |
| iOS | iOS 12.0 | ✅ Soportado |
| Windows | Windows 10+ | ✅ Con FFI |
| Linux | Ubuntu 20.04+ | ✅ Con FFI |
| macOS | macOS 10.15+ | ✅ Con FFI |
| Web (Chrome) | — | ❌ sqflite no compatible |

### Permisos Android (`AndroidManifest.xml`)

| Permiso | Motivo |
|---|---|
| `POST_NOTIFICATIONS` | Notificaciones de recordatorio (Android 13+) |
| `SCHEDULE_EXACT_ALARM` | Recordatorios en hora exacta |
| `USE_EXACT_ALARM` | Variante para API 33+ |
| `RECEIVE_BOOT_COMPLETED` | Restaurar notificaciones tras reinicio |
| `VIBRATE` | Vibración en notificaciones |
| `USE_BIOMETRIC` | Autenticación biométrica |
| `USE_FINGERPRINT` | Huella dactilar (API < 28) |
| `INTERNET` | Sincronización opcional con Google Drive |

---

## Roadmap

- [x] Internacionalización EN/ES completa con `flutter_localizations` (145+ claves)
- [x] Tests unitarios de use cases y entidades del dominio
- [x] Seguridad: hash SHA-256 + salt para contraseñas
- [x] Accesibilidad: Semantics labels + InkWell en widgets críticos
- [x] Fuentes bundled (offline-first) en vez de google_fonts
- [x] Providers organizados por feature en módulos separados
- [x] Debounce en home widget updater (500ms)
- [x] Validadores de dominio centralizados
- [ ] Sincronización automática en background con Google Drive
- [ ] Widget de pantalla de inicio completamente funcional (Android/iOS)
- [ ] Exportación a iCloud Drive (iOS)
- [ ] Modo multiscreensize (tablets y foldables)
- [ ] Tests de integración con `integration_test`
- [ ] Flavors: `dev` / `staging` / `production`

---

## Créditos

Desarrollado como proyecto académico para la asignatura de **Desarrollo de Aplicaciones Móviles**.

| | |
|---|---|
| **Institución** | Politécnico Grancolombiano |
| **Subgrupo** | 10 |
| **Desarrollador** | Omar Hernández Rey |
| **Repositorio** | [github.com/omarhernandezrey/dayflow](https://github.com/omarhernandezrey/dayflow) |

Interfaz diseñada con [Claude AI](https://claude.ai) e implementada en Flutter con arquitectura Clean, lógica de negocio real y persistencia local completa.

---

<div align="center">

Hecho con Flutter · SQLite · Riverpod

</div>