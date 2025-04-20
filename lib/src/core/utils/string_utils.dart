/// Вспомогательные методы для работы со строками
class StringUtils {
  /// Делает первую букву строки заглавной
  static String capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }

  /// Обрезает строку до maxLength символов, добавляя ... если нужно
  static String truncate(String s, int maxLength) {
    if (s.length <= maxLength) return s;
    return s.substring(0, maxLength) + '...';
  }

  /// Проверяет, что строка пуста или null
  static bool isNullOrEmpty(String? s) => s == null || s.isEmpty;
}
