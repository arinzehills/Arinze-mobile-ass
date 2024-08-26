import 'package:flutter/material.dart';

class SalaryChangeGraph extends CustomPainter {
  final double percentage;

  SalaryChangeGraph(this.percentage);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = percentage >= 0 ? Colors.green : Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw circle
    canvas.drawCircle(center, radius, paint);

    // Draw arrow
    final arrowPaint = Paint()
      ..color = percentage >= 0 ? Colors.green : Colors.red
      ..style = PaintingStyle.fill;

    final arrowPath = Path();
    if (percentage >= 0) {
      arrowPath.moveTo(center.dx, center.dy + radius);
      arrowPath.lineTo(center.dx - 5, center.dy + radius + 10);
      arrowPath.lineTo(center.dx + 5, center.dy + radius + 10);
    } else {
      arrowPath.moveTo(center.dx, center.dy - radius);
      arrowPath.lineTo(center.dx - 5, center.dy - radius - 10);
      arrowPath.lineTo(center.dx + 5, center.dy - radius - 10);
    }
    arrowPath.close();

    canvas.drawPath(arrowPath, arrowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
