import 'package:intl/intl.dart';

final _dateFormat = DateFormat('yyyy-MM-dd');
final _displayFormat = DateFormat('M月d日', 'zh_CN');
final _monthDayFormat = DateFormat('d日', 'zh_CN');

String formatDate(DateTime dt) => _dateFormat.format(dt);

String formatDisplayDate(DateTime dt) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final d = DateTime(dt.year, dt.month, dt.day);
  final diff = today.difference(d).inDays;
  if (diff == 0) return '今天';
  if (diff == 1) return '昨天';
  if (diff == -1) return '明天';
  return _displayFormat.format(dt);
}

String formatShortDate(DateTime dt) => _monthDayFormat.format(dt);

/// Returns the Chinese day-of-week label for the last 7 days ending today.
/// Index 0 = 6 days ago, index 6 = today.
List<String> last7DayLabels() {
  final now = DateTime.now();
  const weekdays = ['一', '二', '三', '四', '五', '六', '日'];
  return List.generate(7, (i) {
    final d = now.subtract(Duration(days: 6 - i));
    if (i == 6) return '今';
    return weekdays[d.weekday - 1];
  });
}

/// Returns the start of the given date (00:00:00).
DateTime startOfDay(DateTime dt) =>
    DateTime(dt.year, dt.month, dt.day);

/// Returns the end of the given date (23:59:59.999).
DateTime endOfDay(DateTime dt) =>
    DateTime(dt.year, dt.month, dt.day, 23, 59, 59, 999);

bool isSameDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;
