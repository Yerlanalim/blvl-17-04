import 'package:flutter/material.dart';

class SkillsVisualizationController extends ChangeNotifier {
  String? _selectedSkill;
  int? _selectedSkillValue;

  String? get selectedSkill => _selectedSkill;
  int? get selectedSkillValue => _selectedSkillValue;

  void selectSkill(String skill, int value) {
    _selectedSkill = skill;
    _selectedSkillValue = value;
    notifyListeners();
  }

  void clearSelection() {
    _selectedSkill = null;
    _selectedSkillValue = null;
    notifyListeners();
  }

  // TODO: реализовать управление выбранным навыком, стилем, фильтрами, анимациями
}
