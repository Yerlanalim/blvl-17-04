/// Вспомогательные методы для валидации данных
class ValidationUtils {
  /// Проверяет, что строка не пуста
  static bool isNotEmpty(String? value) =>
      value != null && value.trim().isNotEmpty;

  /// Проверяет валидность email
  static bool isValidEmail(String? email) {
    if (email == null) return false;
    final regex = RegExp(r'^[\w\.-]+@[\w\.-]+\.[a-zA-Z]{2,}[0m');
    return regex.hasMatch(email);
  }

  /// Проверяет валидность пароля (минимум 6 символов)
  static bool isValidPassword(String? password) {
    return password != null && password.length >= 6;
  }
}
