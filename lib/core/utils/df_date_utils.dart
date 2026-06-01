import 'package:intl/intl.dart';

abstract final class DFDateUtils {
  static final _isoFmt = DateFormat('yyyy-MM-dd');
  static final _displayDateFmt = DateFormat("EEEE, d 'de' MMMM", 'es');
  static final _shortDateFmt = DateFormat('d MMM', 'es');
  static final _timeFmt = DateFormat('h:mm a', 'es');

  static String isoDate(DateTime d) => _isoFmt.format(d);

  static String today() => isoDate(DateTime.now());

  static String displayDate(String iso) {
    try {
      return _displayDateFmt.format(_isoFmt.parse(iso));
    } catch (_) {
      return iso;
    }
  }

  static String shortDate(String iso) {
    try {
      return _shortDateFmt.format(_isoFmt.parse(iso));
    } catch (_) {
      return iso;
    }
  }

  static DateTime parseIso(String iso) => _isoFmt.parse(iso);

  /// '14:30' → '2:30 PM'
  static String formatTime(String hhmm) {
    try {
      final parts = hhmm.split(':');
      final dt = DateTime(0, 1, 1, int.parse(parts[0]), int.parse(parts[1]));
      return _timeFmt.format(dt);
    } catch (_) {
      return hhmm;
    }
  }

  /// TimeOfDay → 'HH:mm'
  static String timeToString(int hour, int minute) =>
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';

  static String dayLabel(int weekday) {
    const days = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];
    return days[(weekday - 1).clamp(0, 6)];
  }

  static DateTime startOfWeek(DateTime d) =>
      d.subtract(Duration(days: d.weekday - 1));
}
