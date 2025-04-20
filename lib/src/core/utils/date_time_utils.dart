/// Вспомогательные методы для работы с датой и временем
class DateTimeUtils {
  /// Форматирует дату в строку ГГГГ-ММ-ДД
  static String formatDate(DateTime date) {
    return '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  /// Проверяет, является ли дата сегодняшним днём
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return now.year == date.year &&
        now.month == date.month &&
        now.day == date.day;
  }

  /// Возвращает разницу в днях между двумя датами
  static int daysBetween(DateTime from, DateTime to) {
    return to.difference(from).inDays;
  }

  /// Преобразует строку ГГГГ-ММ-ДД в DateTime
  static DateTime? parseDate(String? dateStr) {
    if (dateStr == null) return null;
    try {
      final parts = dateStr.split('-');
      if (parts.length != 3) return null;
      return DateTime(
        int.parse(parts[0]),
        int.parse(parts[1]),
        int.parse(parts[2]),
      );
    } catch (_) {
      return null;
    }
  }
}
