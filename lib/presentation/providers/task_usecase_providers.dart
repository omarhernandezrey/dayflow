import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/tasks/add_task.dart';
import '../../domain/usecases/tasks/delete_task.dart';
import '../../domain/usecases/tasks/get_tasks.dart';
import '../../domain/usecases/tasks/search_tasks.dart';
import '../../domain/usecases/tasks/toggle_task.dart';
import '../../domain/usecases/tasks/update_task.dart';
import 'repository_providers.dart';

final getAllTasksUseCaseProvider = Provider((ref) => GetAllTasksUseCase(ref.watch(taskRepositoryProvider)));
final addTaskUseCaseProvider = Provider((ref) => AddTaskUseCase(ref.watch(taskRepositoryProvider)));
final updateTaskUseCaseProvider = Provider((ref) => UpdateTaskUseCase(ref.watch(taskRepositoryProvider)));
final deleteTaskUseCaseProvider = Provider((ref) => DeleteTaskUseCase(ref.watch(taskRepositoryProvider)));
final toggleTaskUseCaseProvider = Provider((ref) => ToggleTaskUseCase(ref.watch(taskRepositoryProvider)));
final searchTasksUseCaseProvider = Provider((ref) => SearchTasksUseCase(ref.watch(taskRepositoryProvider)));