import 'package:riverpod_annotation/riverpod_annotation.dart';

/// Уровни логирования
enum LogLevel { info, warning, error }

/// Абстракция логгера
abstract class Logger {
  void log(
    String message, {
    LogLevel level = LogLevel.info,
    Object? error,
    StackTrace? stackTrace,
  });
  void info(String message) => log(message, level: LogLevel.info);
  void warning(String message) => log(message, level: LogLevel.warning);
  void error(String message, {Object? error, StackTrace? stackTrace}) =>
      log(message, level: LogLevel.error, error: error, stackTrace: stackTrace);
}

/// Реализация Logger с выводом в консоль
class ConsoleLogger implements Logger {
  @override
  void log(
    String message, {
    LogLevel level = LogLevel.info,
    Object? error,
    StackTrace? stackTrace,
  }) {
    final prefix = '[[34m${level.name.toUpperCase()}[0m]';
    final errorStr = error != null ? '\nError: $error' : '';
    final stackStr = stackTrace != null ? '\nStack: $stackTrace' : '';
    // TODO: интеграция с Firebase Analytics
    print('$prefix $message$errorStr$stackStr');
  }

  @override
  void info(String message) => log(message, level: LogLevel.info);

  @override
  void warning(String message) => log(message, level: LogLevel.warning);

  @override
  void error(String message, {Object? error, StackTrace? stackTrace}) =>
      log(message, level: LogLevel.error, error: error, stackTrace: stackTrace);
}

/// Провайдер Logger (singleton)
final loggerProvider = Provider<Logger>((ref) => ConsoleLogger());
