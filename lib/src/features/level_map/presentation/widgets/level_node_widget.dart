import 'package:flutter/material.dart';

class LevelNodeWidget extends StatelessWidget {
  final String levelId;
  final String title;
  final bool isCurrent;
  final bool isCompleted;
  final bool isLocked;
  final bool isPremium;
  final double progress;
  final VoidCallback? onTap;

  const LevelNodeWidget({
    Key? key,
    required this.levelId,
    required this.title,
    this.isCurrent = false,
    this.isCompleted = false,
    this.isLocked = false,
    this.isPremium = false,
    this.progress = 0.0,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLocked ? null : onTap,
      child: AnimatedScale(
        scale: isLocked ? 0.9 : 1.1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutBack,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color:
                isCurrent
                    ? Colors.blueAccent
                    : isCompleted
                    ? Colors.green
                    : isLocked
                    ? Colors.grey
                    : Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: isPremium ? Colors.amber : Colors.black12,
              width: isCurrent ? 3 : 1,
            ),
            boxShadow: [
              if (!isLocked)
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(title, textAlign: TextAlign.center),
              if (progress > 0 && !isCompleted)
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: 32,
                      width: 32,
                      child: CircularProgressIndicator(
                        value: progress,
                        strokeWidth: 4,
                        backgroundColor: Colors.white24,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isCurrent ? Colors.blue : Colors.green,
                        ),
                      ),
                    ),
                  ),
                ),
              if (isCompleted)
                const Icon(Icons.check_circle, color: Colors.white, size: 28),
            ],
          ),
        ),
      ),
    );
  }
}
