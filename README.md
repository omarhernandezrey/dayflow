# DayFlow

Aplicación móvil multiplataforma para gestión personal de actividades, hábitos y estadísticas. Desarrollada en Flutter con arquitectura offline-first: todos los datos se almacenan localmente en el dispositivo, sin servidores ni conexión a internet.

> Proyecto académico — Politécnico Grancolombiano · Subgrupo 10

---

## Contenido

- [Descripción](#descripción)
- [Características](#características)
- [Arquitectura](#arquitectura)
- [Stack tecnológico](#stack-tecnológico)
- [Estructura del proyecto](#estructura-del-proyecto)
- [Base de datos](#base-de-datos)
- [Gestión de estado](#gestión-de-estado)
- [Navegación](#navegación)
- [Sistema de diseño](#sistema-de-diseño)
- [Comenzar](#comenzar)
- [Requerimientos](#requerimientos)

---

## Descripción

DayFlow permite al usuario organizar su día registrando actividades con categoría, fecha y hora; construir hábitos saludables con seguimiento de racha diaria; y revisar su desempeño semanal a través de estadísticas y gráficos interactivos. Todo funciona sin conexión a internet — los datos nunca salen del dispositivo.

---

## Características

### Funcionales

| # | Requerimiento | Descripción |
|---|---|---|
| RF1 | Registrar actividad | Crea actividades con título, descripción, categoría (Personal / Académica / Salud), fecha y hora |
| RF2 | Editar actividad | Modifica cualquier campo de una actividad existente |
| RF3 | Eliminar actividad | Elimina actividades con confirmación y cancela el recordatorio asociado |
| RF4 | Notificaciones locales | Recordatorios programados automáticamente 5, 15, 30 o 60 minutos antes de cada actividad |
| RF5 | Cumplimiento de hábitos | Marca hábitos como completados día a día con un toque |
| RF6 | Estadísticas | Donut de porcentaje semanal + barras por día + conteo de completadas/pendientes/omitidas |
| RF7 | Filtrar tareas | Filtra la lista de tareas por categoría: Todas / Personal / Académica / Salud |
| RF8 | Gestionar hábitos | Crea, edita y elimina hábitos con icono, color, frecuencia y días activos configurables |

### No funcionales

| # | Requerimiento | Solución implementada |
|---|---|---|
| RNF1 | Inicio < 5 s | Inicialización mínima en `main()`: solo locale + notificaciones |
| RNF2 | Android API 21+ · iOS 12+ | Configurado en `build.gradle` y `Podfile` |
| RNF3 | Navegación intuitiva | Bottom nav de 5 tabs + drawer lateral + go_router |
| RNF4 | 100% offline | SQLite local, sin backend ni Firebase |
| RNF5 | Datos privados | Almacenamiento exclusivo en el dispositivo del usuario |
| RNF6 | Arquitectura limpia | Riverpod, capas separadas, widgets reutilizables |
| RNF7 | Escalable | Feature-first folder structure, providers desacoplados |

---

## Arquitectura

DayFlow sigue una arquitectura **feature-first con separación de capas**:

```
┌─────────────────────────────────────────┐
│         Presentación (Screens)          │  ConsumerWidget / ConsumerStatefulWidget
├─────────────────────────────────────────┤
│         Providers (Riverpod)            │  AsyncNotifier / FutureProvider / StateProvider
├─────────────────────────────────────────┤
│         Servicios                       │  DatabaseService · NotificationService
├─────────────────────────────────────────┤
│         Persistencia                    │  SQLite (sqflite) · SharedPreferences
└─────────────────────────────────────────┘
```

- Las pantallas **solo leen** del estado a través de `ref.watch()`.
- Los `AsyncNotifier` encapsulan **toda la lógica de negocio** y las mutaciones.
- Los servicios son **singletons** sin dependencia del framework (testeables de forma aislada).
- No existe estado local innecesario: si el dato puede persistirse, vive en SQLite.

---

## Stack tecnológico

| Categoría | Paquete | Versión | Uso |
|---|---|---|---|
| Framework | Flutter | 3.44+ | Base de la aplicación |
| Lenguaje | Dart | 3.12+ | Null-safety, enums mejorados |
| Tipografía | google_fonts | ^6.2 | Inter (UI) + JetBrains Mono (números) |
| Estado | flutter_riverpod | ^2.5 | `AsyncNotifier`, `Provider`, `FutureProvider` |
| Navegación | go_router | ^14.6 | `StatefulShellRoute` con 5 ramas |
| Base de datos | sqflite | ^2.3 | SQLite local — 3 tablas |
| Rutas de archivos | path | ^1.9 | Resolución de ruta de BD |
| Preferencias | shared_preferences | ^2.3 | Ajustes simples del usuario |
| Notificaciones | flutter_local_notifications | ^17.2 | Recordatorios programados |
| Zonas horarias | timezone | ^0.9 | Programación exacta de notificaciones |
| Gráficas | fl_chart | ^0.70 | `PieChart` (donut) + `BarChart` semanal |
| Internacionalización | intl | ^0.19 | Fechas y horas en español (`es`) |

---

## Estructura del proyecto

```
lib/
├── app.dart                              # MaterialApp.router
├── main.dart                             # ProviderScope · initDateFormatting · NotificationService.init
│
├── core/
│   ├── constants/
│   │   └── app_constants.dart            # Canal de notificaciones, claves de SharedPrefs
│   ├── routes/
│   │   └── app_router.dart               # GoRouter + StatefulShellRoute (5 tabs)
│   ├── theme/
│   │   ├── app_colors.dart               # Tokens de color (bg, surface, brand, categorías, semánticos)
│   │   ├── app_dimensions.dart           # Grilla 4pt · radios · alturas de componentes
│   │   ├── app_shadows.dart              # Sombras y glows direccionales
│   │   ├── app_typography.dart           # Escala tipográfica + TextTheme de Material 3
│   │   └── app_theme.dart                # ThemeData oscuro ensamblado
│   └── utils/
│       └── df_date_utils.dart            # isoDate · displayDate · formatTime · startOfWeek
│
├── features/
│   ├── auth/
│   │   ├── splash_screen.dart            # Bienvenida con glow ambient
│   │   ├── login_screen.dart             # Email + contraseña + "Recuérdame"
│   │   ├── register_screen.dart          # Registro con medidor de fortaleza
│   │   ├── forgot_password_screen.dart   # Recuperación con código OTP
│   │   └── auth_widgets.dart             # DFLogo · DFBackBtn · DFField · DFPrimaryBtn
│   │
│   ├── home/
│   │   └── home_screen.dart              # Dashboard: resumen real + próximas actividades
│   │
│   ├── tasks/
│   │   ├── providers/
│   │   │   └── tasks_provider.dart       # tasksProvider · taskFilterProvider · filteredTasksProvider
│   │   ├── tasks_screen.dart             # Lista filtrable + toggle de completado
│   │   ├── add_task_screen.dart          # Formulario real (DatePicker · TimePicker · recordatorio)
│   │   └── task_detail_screen.dart       # Detalle + Completar / Editar / Eliminar
│   │
│   ├── habits/
│   │   ├── providers/
│   │   │   └── habits_provider.dart      # habitsProvider · todayProgressProvider · globalStreakProvider
│   │   ├── habits_screen.dart            # Racha + progreso diario + toggle + gestión
│   │   └── add_habit_screen.dart         # Selector de icono/color · días · frecuencia · meta
│   │
│   ├── stats/
│   │   ├── providers/
│   │   │   └── stats_provider.dart       # weeklyStatsProvider · todayStatsProvider
│   │   └── stats_screen.dart             # PieChart donut + BarChart semanal (fl_chart real)
│   │
│   └── more/
│       ├── more_screen.dart              # Perfil + grupos de ajustes + racha global real
│       ├── notifications_screen.dart     # Historial de notificaciones
│       └── profile_screen.dart           # Avatar + stats personales + logros
│
├── services/
│   ├── database/
│   │   └── database_service.dart         # Singleton SQLite — CRUD · stats semanales · rachas
│   └── notifications/
│       └── notification_service.dart     # zonedSchedule · cancelar por ID · solicitar permisos
│
└── shared/
    ├── models/
    │   ├── task.dart                     # Task + enum TaskCategory (personal/academic/health)
    │   ├── habit.dart                    # Habit + enum HabitFrequency + isActiveOnDay()
    │   └── habit_progress.dart           # HabitProgress (registro diario por hábito)
    └── widgets/
        ├── df_app_bar.dart               # AppBar personalizada (PreferredSizeWidget)
        └── df_nav_shell.dart             # Bottom nav + Drawer lateral (StatefulNavigationShell)
```

---

## Base de datos

Archivo local: `dayflow.db` (SQLite). Ubicado en el directorio de documentos de la aplicación. Foreign keys habilitadas con `PRAGMA foreign_keys = ON`.

### Tabla `tasks`

| Columna | Tipo | Descripción |
|---|---|---|
| `id` | `INTEGER PK` | Autoincremental |
| `title` | `TEXT NOT NULL` | Nombre de la actividad |
| `description` | `TEXT` | Descripción opcional |
| `category` | `TEXT` | `personal` \| `academic` \| `health` |
| `date` | `TEXT` | Fecha ISO: `YYYY-MM-DD` |
| `time` | `TEXT` | Hora: `HH:mm` |
| `reminder_minutes` | `INTEGER` | Minutos antes del recordatorio: 5, 15, 30 o 60 |
| `completed` | `INTEGER` | `0` = pendiente · `1` = completada |

### Tabla `habits`

| Columna | Tipo | Descripción |
|---|---|---|
| `id` | `INTEGER PK` | Autoincremental |
| `title` | `TEXT NOT NULL` | Nombre del hábito |
| `icon` | `TEXT` | Clave: `water` \| `dumbbell` \| `leaf` \| `moon` \| `book` \| `sparkle` |
| `color_hex` | `TEXT` | Color en formato `#RRGGBB` |
| `frequency` | `TEXT` | `daily` \| `weekly` \| `custom` |
| `active_days` | `TEXT` | 7 caracteres (Lun→Dom): `'1'` activo · `'0'` inactivo. Ej: `'1111100'` = Lun–Vie |
| `goal` | `INTEGER` | Número de veces por día |

### Tabla `habit_progress`

| Columna | Tipo | Descripción |
|---|---|---|
| `id` | `INTEGER PK` | Autoincremental |
| `habit_id` | `INTEGER FK` | Referencia a `habits(id)` con `ON DELETE CASCADE` |
| `date` | `TEXT` | Fecha ISO: `YYYY-MM-DD` |
| `completed` | `INTEGER` | `0` = no completado · `1` = completado |
| — | `UNIQUE` | `(habit_id, date)` — un registro por hábito por día |

---

## Gestión de estado

DayFlow usa **Riverpod 2.x** con `AsyncNotifier` como patrón principal. Todos los providers son observados por las pantallas con `ref.watch()` — cuando un notifier actualiza su estado, la UI se reconstruye automáticamente.

```
Provider                       Tipo                           Responsabilidad
──────────────────────────────────────────────────────────────────────────────
dbServiceProvider              Provider<DatabaseService>      Singleton de acceso a SQLite
notificationServiceProvider    Provider<NotificationService>  Singleton de notificaciones
tasksProvider                  AsyncNotifierProvider          CRUD de tareas + recarga automática
taskFilterProvider             StateProvider<String?>         Filtro de categoría activo (null = todas)
filteredTasksProvider          Provider<List<Task>>           Lista derivada con filtro aplicado
habitsProvider                 AsyncNotifierProvider          CRUD de hábitos
todayProgressProvider          AsyncNotifierProvider          Mapa habitId→bool para hoy
globalStreakProvider            FutureProvider<int>            Días consecutivos con actividad global
habitStreakProvider             FutureProvider.family<int>     Racha individual por hábito
weeklyStatsProvider            FutureProvider<Map>            Estadísticas de la semana en curso
todayStatsProvider             FutureProvider<Map>            Resumen de actividades del día actual
```

**Flujo de mutación — ejemplo: completar una tarea:**

```
Usuario toca "Completar"
    → tasksProvider.notifier.toggle(id, true)
        → DatabaseService.toggleTask(id, true)        ← actualiza SQLite
        → NotificationService.cancelReminder(id)      ← cancela la notificación
        → state = await db.getTasks()                 ← recarga completa
    → toda la UI que observe tasksProvider se reconstruye
    → weeklyStatsProvider se invalida y recalcula automáticamente
```

---

## Navegación

Basada en `go_router` con `StatefulShellRoute.indexedStack`. Las 5 pestañas del bottom nav preservan su estado al cambiar entre ellas (no se recrean).

```
/splash           →  SplashScreen
/login            →  LoginScreen
/register         →  RegisterScreen
/forgot-password  →  ForgotPasswordScreen

                      ┌── DFNavShell (bottom nav + drawer lateral)
/home    ─────────────┤  Pestaña 0 — HomeScreen
/tasks   ─────────────┤  Pestaña 1 — TasksScreen
/habits  ─────────────┤  Pestaña 2 — HabitsScreen
/stats   ─────────────┤  Pestaña 3 — StatsScreen
/more    ─────────────┘  Pestaña 4 — MoreScreen

/add-task         →  AddTaskScreen    (extra: Task? — null = nueva, Task = editar)
/task-detail      →  TaskDetailScreen (extra: Task)
/add-habit        →  AddHabitScreen   (extra: Habit? — null = nueva, Habit = editar)
/notifications    →  NotificationsScreen
/profile          →  ProfileScreen
```

---

## Sistema de diseño

### Paleta de colores

| Token | Valor | Uso |
|---|---|---|
| `bg` | `#0E0F13` | Fondo principal |
| `surface` | `#181A20` | Tarjetas y contenedores |
| `surface2` | `#1F222A` | Superficies elevadas |
| `blue` | `#3D7BFF` | Color primario de marca |
| `violet` | `#7C3AED` | Gradiente de acento |
| `catAcademic` | `#3D7BFF` | Categoría Académica |
| `catHealth` | `#22C55E` | Categoría Salud |
| `catPersonal` | `#F59E0B` | Categoría Personal |
| `success` | `#22C55E` | Estados positivos |
| `warning` | `#F59E0B` | Estados de alerta |
| `danger` | `#EF4444` | Acciones destructivas |
| `text` | `#F2F3F7` | Texto principal |
| `textDim` | `#A4A8B3` | Texto secundario |
| `textMute` | `#6B6F7A` | Hints y texto deshabilitado |

### Tipografía

| Estilo | Fuente | Tamaño | Peso | Uso |
|---|---|---|---|---|
| Display | Inter | 56 | 800 | Estadísticas en grande |
| Title | Inter | 24–34 | 800 | Encabezados de pantalla |
| Heading | Inter | 17 | 700 | AppBar title |
| Body Large | Inter | 15 | 500 | Texto principal de formularios |
| Body | Inter | 14 | 500 | Contenido de listas |
| Caption | Inter | 11.5 | 500 | Metadata y subtítulos |
| Numeric | JetBrains Mono | 22 | 700 | Horas, porcentajes, números |

### Grilla de espaciado (base 4 pt)

| Token | Valor |
|---|---|
| `s1` | 4 px |
| `s2` | 8 px |
| `s3` | 12 px |
| `s4` | 16 px |
| `s5` | 20 px |
| `s6` | 24 px |
| `s8` | 32 px |

### Radios de borde

| Token | Valor | Uso típico |
|---|---|---|
| `rXs` | 6 | Chips pequeños, barras |
| `rSm` | 10 | Botones secundarios, íconos |
| `rMd` | 14 | Tarjetas medianas, inputs |
| `rLg` | 18 | Tarjetas grandes |
| `rXl` | 24 | Hero cards, logo |
| `rPill` | 999 | Chips redondeados, pills |

---

## Comenzar

### Prerrequisitos

- **Flutter SDK** `≥ 3.12` — [Instalar Flutter](https://docs.flutter.dev/get-started/install)
- **Android Studio** con emulador API 21+ o dispositivo físico con modo desarrollador activo
- **Xcode 14+** (solo para iOS/macOS)
- En **Windows**: activar Modo Desarrollador en Configuración del sistema para soporte de symlinks

### Instalación

```bash
# Clonar el repositorio
git clone https://github.com/tu-usuario/dayflow.git
cd dayflow

# Instalar dependencias
flutter pub get

# Verificar integridad del código
flutter analyze

# Ejecutar en modo debug
flutter run
```

### Compilar para distribución

```bash
# APK para Android
flutter build apk --release

# App Bundle (Play Store)
flutter build appbundle --release

# iOS (requiere macOS + Xcode)
flutter build ios --release
```

---

## Requerimientos

### Plataformas soportadas

| Plataforma | Versión mínima |
|---|---|
| Android | API 21 — Android 5.0 Lollipop |
| iOS | iOS 12.0 |

### Permisos de Android

Declarados en `android/app/src/main/AndroidManifest.xml`:

| Permiso | Motivo |
|---|---|
| `POST_NOTIFICATIONS` | Mostrar notificaciones de recordatorio (Android 13+) |
| `SCHEDULE_EXACT_ALARM` | Programar notificaciones en hora exacta |
| `USE_EXACT_ALARM` | Variante para API 33+ |
| `RECEIVE_BOOT_COMPLETED` | Restaurar notificaciones programadas tras reinicio |
| `VIBRATE` | Vibración en notificaciones |

---

## Flujos principales

### Crear una tarea con recordatorio

```
AddTaskScreen
  → usuario escribe título, selecciona categoría, elige fecha (DatePicker) y hora (TimePicker)
  → selecciona tiempo de recordatorio: 5 / 15 / 30 / 60 minutos
  → toca "Guardar actividad"
      → tasksProvider.add(task)
          → DatabaseService.insertTask()                     ← persiste en SQLite
          → NotificationService.scheduleTaskReminder(task)   ← zonedSchedule con timezone
      → context.pop()  ← TasksScreen se actualiza automáticamente
```

### Registrar progreso de un hábito

```
HabitsScreen
  → usuario toca el círculo del hábito
      → todayProgressProvider.toggle(habitId, !done)
          → DatabaseService.setHabitProgress()   ← INSERT OR REPLACE en habit_progress
      → UI reconstruye el círculo (vacío → check verde)
      → globalStreakProvider se recalcula
      → weeklyStatsProvider se invalida → gráfico de barras se actualiza
```

### Consultar estadísticas semanales

```
StatsScreen observa weeklyStatsProvider
  → DatabaseService.getWeeklyStats()
      → consulta tareas por cada día de la semana actual (Lun–Dom)
      → calcula % completado por día → lista de barras { day, value, dim }
      → calcula % global de la semana → completionPct
  → PieChart (fl_chart): sección azul = completionPct, gris = restante
  → BarChart (fl_chart): una barra por día, gris si es día futuro
```

---

## Créditos

Desarrollado como proyecto académico para la asignatura de Desarrollo de Aplicaciones Móviles.

**Institución:** Politécnico Grancolombiano  
**Subgrupo:** 10

Diseño de interfaz creado con [Claude AI Design](https://claude.ai/design) e implementado en Flutter con lógica, datos y navegación reales.
