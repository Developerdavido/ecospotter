

import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';

class CustomShapePainter extends CustomPainter {
  final Color? paintColor;

  const CustomShapePainter({
    this.paintColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = paintColor ?? AppColors.primaryColor;

    Path path = Path();
    path.moveTo(size.width * 0.5, 0);
    path.quadraticBezierTo(size.width, size.height * 0.25, size.width, size.height * 0.5);
    path.quadraticBezierTo(size.width, size.height * 0.75, size.width * 0.5, size.height);
    path.quadraticBezierTo(0, size.height * 0.75, 0, size.height * 0.5);
    path.quadraticBezierTo(0, size.height * 0.25, size.width * 0.5, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}