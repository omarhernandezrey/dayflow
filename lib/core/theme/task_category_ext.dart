import 'package:flutter/material.dart';

import '../../domain/entities/task.dart';
import 'app_colors.dart';

extension TaskCategoryX on TaskCategory {
  Color get color {
    switch (this) {
      case TaskCategory.academic:
        return AppColors.catAcademic;
      case TaskCategory.health:
        return AppColors.catHealth;
      case TaskCategory.personal:
        return AppColors.catPersonal;
    }
  }
}