import 'package:flutter/material.dart';

class LevelConnectionWidget extends StatelessWidget {
  final Offset start;
  final Offset end;
  final bool isActive;
  final bool isCompleted;

  const LevelConnectionWidget({
    Key? key,
    required this.start,
    required this.end,
    this.isActive = false,
    this.isCompleted = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _LevelConnectionPainter(
        start: start,
        end: end,
        isActive: isActive,
        isCompleted: isCompleted,
      ),
    );
  }
}

class _LevelConnectionPainter extends CustomPainter {
  final Offset start;
  final Offset end;
  final bool isActive;
  final bool isCompleted;

  _LevelConnectionPainter({
    required this.start,
    required this.end,
    required this.isActive,
    required this.isCompleted,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color =
              isCompleted
                  ? Colors.green
                  : isActive
                  ? Colors.blueAccent
                  : Colors.grey
          ..strokeWidth = isActive ? 4 : 2
          ..style = PaintingStyle.stroke;
    final path = Path();
    path.moveTo(start.dx, start.dy);
    path.cubicTo(start.dx + 40, start.dy, end.dx - 40, end.dy, end.dx, end.dy);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
