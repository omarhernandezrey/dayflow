import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Trigger a celebration confetti animation.
/// Set to true to play, the consumer should reset to false after playing.
final celebrationTriggerProvider = StateProvider<bool>((ref) => false);
