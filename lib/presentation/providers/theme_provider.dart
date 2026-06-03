import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ThemeModeOption { light, dark, system }

final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeModeOption>(
  ThemeModeNotifier.new,
);

class ThemeModeNotifier extends Notifier<ThemeModeOption> {
  @override
  ThemeModeOption build() => ThemeModeOption.dark;

  void setMode(ThemeModeOption mode) => state = mode;
}

final effectiveThemeModeProvider = Provider<ThemeMode>((ref) {
  final option = ref.watch(themeModeProvider);
  switch (option) {
    case ThemeModeOption.light:
      return ThemeMode.light;
    case ThemeModeOption.dark:
      return ThemeMode.dark;
    case ThemeModeOption.system:
      return ThemeMode.system;
  }
});