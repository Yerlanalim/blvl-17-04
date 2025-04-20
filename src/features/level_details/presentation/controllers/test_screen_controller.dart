import 'package:flutter/material.dart';

/// Контроллер для управления состоянием прохождения теста
class TestScreenController extends ChangeNotifier {
  // TODO: добавить поля для текущего вопроса, ответов, состояния теста

  /// Переход к следующему вопросу
  void nextQuestion() {
    // TODO: реализовать переход
    notifyListeners();
  }

  /// Переход к предыдущему вопросу
  void previousQuestion() {
    // TODO: реализовать переход
    notifyListeners();
  }

  /// Сохранение ответа пользователя
  void saveAnswer(dynamic answer) {
    // TODO: реализовать сохранение ответа
    notifyListeners();
  }

  /// Завершение теста
  void finishTest() {
    // TODO: реализовать завершение теста
    notifyListeners();
  }
}
