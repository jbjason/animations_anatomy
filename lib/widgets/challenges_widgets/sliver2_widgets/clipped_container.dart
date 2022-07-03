import 'package:animations_anatomy/models/travel.dart';
import 'package:animations_anatomy/widgets/animation_widgets/sliver2_widgets/cutting_clipper.dart';
import 'package:flutter/material.dart';

class ClippedContainer extends StatelessWidget {
  const ClippedContainer(
      {Key? key,
      required this.size,
      required this.percent,
      required this.valueBack})
      : super(key: key);
  final Size size;
  final double percent, valueBack;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: SizedBox(
        height: size.height * .12,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CustomPaint(painter: CuttingClipper()),
            Positioned(
              right: 100,
              bottom: 20,
              child: Text(
                travels[2].title,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
