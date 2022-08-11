import 'package:flutter/material.dart';

class BatmanClipper extends CustomClipper<Path> {
  const BatmanClipper({required this.progress});
  final double progress;

  @override
  getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width / 2, size.height * (1 - progress));
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => true;
}
