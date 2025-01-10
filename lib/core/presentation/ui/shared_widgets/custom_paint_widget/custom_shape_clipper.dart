

import 'package:flutter/material.dart';

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width * 0.5, 0);
    path.quadraticBezierTo(size.width, size.height * 0.25, size.width, size.height * 0.5);
    path.quadraticBezierTo(size.width, size.height * 0.75, size.width * 0.5, size.height);
    path.quadraticBezierTo(0, size.height * 0.75, 0, size.height * 0.5);
    path.quadraticBezierTo(0, size.height * 0.25, size.width * 0.5, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }

}