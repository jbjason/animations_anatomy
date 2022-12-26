import 'package:animations_anatomy/screens/challenges_/loading_chlng/loading_screen1.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class LoadingEnding extends StatelessWidget {
  const LoadingEnding({Key? key, required this.endingAnimation})
      : super(key: key);
  final Animation<double> endingAnimation;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: endingAnimation,
      builder: (context, _) {
        return endingAnimation.value > 0
            ? Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomPaint(
                            foregroundPainter: _EndingPaint(endingAnimation),
                            child: const SizedBox(height: 100, width: 100),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'data has successfully',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            'uploaded',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () => Navigator.maybePop(context),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        child: Text(
                          'Ok',
                          style: TextStyle(color: secondaryDataBackupColor),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Container();
      },
    );
  }
}

class _EndingPaint extends CustomPainter {
  const _EndingPaint(this.endingAnimation);
  final Animation<double> endingAnimation;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = mainDataBackupColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3;
    final circlePath = Path();
    circlePath.addArc(
      Rect.fromCenter(
          center: Offset(size.height / 2, size.width / 2),
          width: size.width,
          height: size.height),
      vector.radians(-90),
      vector.radians(360 * endingAnimation.value),
    );
    // saving it means storing the Arc into stack
    canvas.save();
    final heightPercent =
        endingAnimation.value > 0.5 ? 1 : endingAnimation.value / 0.5;
    final widthPercent =
        endingAnimation.value < 0.5 ? 0 : (endingAnimation.value - 0.5) / 0.5;
    // moving the canvas to middle of the Arc
    canvas.translate(size.height / 4, size.width / 2);
    canvas.rotate(vector.radians(-45));
    canvas.drawLine(const Offset(0, 0),
        Offset(0, (size.height * .2) * heightPercent), paint);
    canvas.drawLine(
        Offset(0, size.height * .2),
        Offset((size.width * .5) * widthPercent,
            (size.height * .2) * widthPercent),
        paint);

    // after drawing Right-Signature we restoring the Arc from stack by .restore()
    canvas.restore();
    canvas.drawPath(circlePath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
