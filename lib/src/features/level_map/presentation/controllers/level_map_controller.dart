import 'package:flutter/material.dart';

class LevelMapController extends ChangeNotifier {
  double scale = 1.0;
  Offset offset = Offset.zero;

  void updateScale(double newScale) {
    scale = newScale;
    notifyListeners();
  }

  void updateOffset(Offset newOffset) {
    offset = newOffset;
    notifyListeners();
  }

  // Добавить методы для анимаций, выделения, переходов и т.д.
}
