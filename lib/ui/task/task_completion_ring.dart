import 'dart:math';
import 'package:flutter/material.dart';

class TaskCompletionRing extends StatelessWidget {
  final double progress;

  const TaskCompletionRing({required this.progress, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.25,
      child: CustomPaint(
        painter: _TaskCompletionRingPainter(
            progress: progress,
            taskNotCompletedColor: Theme.of(context).primaryColorLight,
            taskCompletedColor: Theme.of(context).primaryColorDark),
      ),
    );
  }
}

class _TaskCompletionRingPainter extends CustomPainter {
  final double progress;
  final Color taskNotCompletedColor;
  final Color taskCompletedColor;

  _TaskCompletionRingPainter({
    required this.progress,
    required this.taskNotCompletedColor,
    required this.taskCompletedColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final notCompleted = progress < 1.0;
    final strokeWidth = size.width / 15;
    final center = Offset(size.width / 2, size.height / 2);
    final radius =
        notCompleted ? (size.width - strokeWidth) / 2 : size.width / 2;
    final paint = Paint()
      ..isAntiAlias = true
      ..color = taskCompletedColor
      ..strokeWidth = strokeWidth
      ..style = notCompleted ? PaintingStyle.stroke : PaintingStyle.fill;

    canvas.drawCircle(center, radius, paint);

    paint.color = taskNotCompletedColor;
    final progressAngle = 2 * pi * progress;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        progressAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant _TaskCompletionRingPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
