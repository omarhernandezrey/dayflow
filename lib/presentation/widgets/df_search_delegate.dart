import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// Global search delegate for tasks and habits.
class DFSearchDelegate extends SearchDelegate<String> {
  final WidgetRef ref;

  DFSearchDelegate(this.ref);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      scaffoldBackgroundColor: AppColors.bg,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.bg,
        foregroundColor: AppColors.text,
        elevation: 0,
        titleTextStyle: AppTypography.inter(
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: AppTypography.inter(
          fontSize: 17,
          color: AppColors.textMute,
        ),
        border: InputBorder.none,
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear_rounded),
          tooltip: 'Limpiar',
          onPressed: () => query = '',
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_rounded),
      tooltip: 'Cerrar',
      onPressed: () => close(context, ''),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _SearchResults(query: query, ref: ref);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.trim().length < 2) {
      return Center(
        child: Text(
          'Escribe al menos 2 caracteres para buscar',
          style: AppTypography.inter(
            fontSize: 14,
            color: AppColors.textMute,
          ),
        ),
      );
    }
    return _SearchResults(query: query, ref: ref);
  }
}

class _SearchResults extends ConsumerWidget {
  const _SearchResults({required this.query, required this.ref});
  final String query;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement search results using search provider
    return Center(
      child: Text(
        'Buscando "$query"...',
        style: AppTypography.inter(color: AppColors.textDim),
      ),
    );
  }
}
