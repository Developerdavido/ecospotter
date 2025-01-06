

import 'dart:ui' as ui;
import 'package:flutter/material.dart';


class ImagePainter extends CustomPainter {

  final ui.Image image;

  const ImagePainter({
    required this.image,
  });


  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    canvas.drawImageRect(
        image,
        Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
        Rect.fromLTWH(0, 0, size.width, size.height),
        paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}