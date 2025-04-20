import 'package:flutter/material.dart';
import 'dart:math';

class SkillsRadarChart extends StatelessWidget {
  final Map<String, int> skills;
  final void Function(String, int)? onSkillTap;
  const SkillsRadarChart({Key? key, required this.skills, this.onSkillTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final skillNames = skills.keys.toList();
    final skillValues = skills.values.toList();
    return GestureDetector(
      onTapUp: (details) {
        // MVP: определяем ближайший навык к точке касания
        final RenderBox box = context.findRenderObject() as RenderBox;
        final local = box.globalToLocal(details.globalPosition);
        final center = Offset(150, 150);
        final dx = local.dx - center.dx;
        final dy = local.dy - center.dy;
        final angle = (atan2(dy, dx) + 2 * pi) % (2 * pi);
        final angleStep = 2 * pi / skillNames.length;
        final index = (angle / angleStep).floor();
        if (index >= 0 && index < skillNames.length && onSkillTap != null) {
          onSkillTap!(skillNames[index], skillValues[index]);
        }
      },
      child: CustomPaint(
        size: const Size(300, 300),
        painter: _RadarChartPainter(skillNames, skillValues),
      ),
    );
  }
}

class _RadarChartPainter extends CustomPainter {
  final List<String> skillNames;
  final List<int> skillValues;
  _RadarChartPainter(this.skillNames, this.skillValues);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2 - 32;
    final angleStep = 2 * pi / skillNames.length;
    final paintLine =
        Paint()
          ..color = Colors.grey.shade400
          ..strokeWidth = 1;
    final paintArea =
        Paint()
          ..color = Colors.blue.withOpacity(0.3)
          ..style = PaintingStyle.fill;
    // Draw grid
    for (int i = 0; i < skillNames.length; i++) {
      final angle = i * angleStep - pi / 2;
      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);
      canvas.drawLine(center, Offset(x, y), paintLine);
    }
    // Draw area
    final path = Path();
    for (int i = 0; i < skillValues.length; i++) {
      final value = skillValues[i].clamp(0, 100) / 100.0;
      final angle = i * angleStep - pi / 2;
      final x = center.dx + radius * value * cos(angle);
      final y = center.dy + radius * value * sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paintArea);
    // Draw labels
    final textStyle = TextStyle(color: Colors.black, fontSize: 12);
    for (int i = 0; i < skillNames.length; i++) {
      final angle = i * angleStep - pi / 2;
      final x = center.dx + (radius + 18) * cos(angle);
      final y = center.dy + (radius + 18) * sin(angle);
      final textSpan = TextSpan(text: skillNames[i], style: textStyle);
      final tp = TextPainter(text: textSpan, textDirection: TextDirection.ltr);
      tp.layout();
      canvas.save();
      canvas.translate(x - tp.width / 2, y - tp.height / 2);
      tp.paint(canvas, Offset.zero);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
