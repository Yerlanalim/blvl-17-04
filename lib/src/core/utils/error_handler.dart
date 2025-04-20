import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

/// Типы ошибок приложения
enum AppErrorType { network, authentication, data, business, unknown }

/// Класс ошибки приложения
class AppException implements Exception {
  final AppErrorType type;
  final String message;
  final Object? original;

  AppException(this.type, this.message, {this.original});

  @override
  String toString() => '[$type] $message';
}

/// Интерфейс обработчика ошибок
abstract class ErrorHandler {
  AppException handle(Object error, [StackTrace? stackTrace]);
  String formatMessage(AppException exception);
}

/// Реализация ErrorHandler
class ErrorHandlerImpl implements ErrorHandler {
  @override
  AppException handle(Object error, [StackTrace? stackTrace]) {
    if (error is AppException) return error;
    if (error is Exception) {
      // Примеры классификации
      if (error.toString().contains('SocketException')) {
        return AppException(
          AppErrorType.network,
          'Нет подключения к интернету',
          original: error,
        );
      }
      if (error.toString().contains('FirebaseAuthException')) {
        return AppException(
          AppErrorType.authentication,
          'Ошибка аутентификации',
          original: error,
        );
      }
      if (error.toString().contains('FirebaseException')) {
        return AppException(
          AppErrorType.data,
          'Ошибка доступа к данным',
          original: error,
        );
      }
      // Можно добавить другие правила
    }
    return AppException(
      AppErrorType.unknown,
      'Неизвестная ошибка',
      original: error,
    );
  }

  @override
  String formatMessage(AppException exception) {
    switch (exception.type) {
      case AppErrorType.network:
        return 'Проверьте подключение к интернету.';
      case AppErrorType.authentication:
        return 'Ошибка входа. Попробуйте снова.';
      case AppErrorType.data:
        return 'Ошибка загрузки данных.';
      case AppErrorType.business:
        return exception.message;
      case AppErrorType.unknown:
      default:
        return 'Произошла неизвестная ошибка.';
    }
  }
}

/// Провайдер ErrorHandler (singleton)
final errorHandlerProvider = Provider<ErrorHandler>(
  (ref) => ErrorHandlerImpl(),
);
