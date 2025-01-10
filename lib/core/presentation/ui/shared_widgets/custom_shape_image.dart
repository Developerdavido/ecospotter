import 'package:citizen_app/core/presentation/ui/shared_widgets/custom_paint_widget/custom_shape_clipper.dart';
import 'package:citizen_app/core/presentation/ui/shared_widgets/custom_paint_widget/image_painter.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class CustomShapeImage extends StatelessWidget {
  final ui.Image image;
  const CustomShapeImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return  ClipPath(
      clipper: CustomShapeClipper(),
      child: CustomPaint(
        painter: ImagePainter(image: image),
        child: Container(),
      ),
    );
  }
}
