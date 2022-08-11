import 'package:animations_anatomy/screens/challenges_/sliver2_chlng/cutting_clipper.dart';
import 'package:flutter/material.dart';

class ClippedContainer extends StatelessWidget {
  const ClippedContainer({Key? key, required this.size, required this.percent})
      : super(key: key);
  final Size size;
  final double percent;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      left: -size.width * (percent.clamp(0, 0.35)),
      child: SizedBox(
        height: size.height * .12,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CustomPaint(painter: CuttingClipper()),
            Positioned(
              right: 100 + 100 * percent,
              bottom: 20,
              child: const Text(
                'Paris',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
