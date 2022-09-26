import 'package:animations_anatomy/constants/constants.dart';
import 'package:animations_anatomy/screens/animation_/bkash_counter/counter_button.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;

class BkashCounterScreen extends StatefulWidget {
  const BkashCounterScreen({Key? key}) : super(key: key);
  @override
  State<BkashCounterScreen> createState() => _BkashCounterScreenState();
}

class _BkashCounterScreenState extends State<BkashCounterScreen> {
  late Timer _timer;
  double _val = 0;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            // counter button
            Positioned(
              top: size.height * .4,
              left: 0,
              right: 0,
              child: const CounterButton(),
            ),
            Positioned(
              bottom: -110,
              left: -5,
              right: -5,
              child: SizedBox(
                height: 240,
                width: size.width,
                child: CustomPaint(
                  painter: _MyPainter1(color: Colors.red, val: _val / 1000),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              width: size.width,
              child: GestureDetector(
                onLongPressStart: (details) {
                  if (mounted) {
                    _timer =
                        Timer.periodic(const Duration(milliseconds: 30), (_) {
                      setState(() {
                        _val += 50;
                      });
                    });
                  }
                },
                onLongPressEnd: (_) {
                  if (_val >= 1000) _timer.cancel();
                  if (_val < 1000) {
                    _timer.cancel();
                    _val = 0;
                  }
                  setState(() {});
                },
                child: const SizedBox(
                  height: 150,
                  child: CustomPaint(
                      painter: _MyPainter(color: Colors.deepPurple)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MyPainter1 extends CustomPainter {
  final Color color;
  final double val;
  const _MyPainter1({required this.color, required this.val});
  @override
  void paint(Canvas canvas, Size size) {
    final h = size.height, w = size.width;
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    double degToRad(num deg) => deg * (math.pi / 180.0);
    final path = Path();
    path.addArc(
      Rect.fromCenter(center: Offset(w / 2, h / 2), width: w, height: h),
      degToRad(-170),
      degToRad(170 * val),
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _MyPainter extends CustomPainter {
  final Color color;

  const _MyPainter({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final h = size.height, w = size.width;
    final paint = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5
      ..color = color;
    final path = Path();
    path.moveTo(0, h);
    //path.quadraticBezierTo(w / 2, 0, w, h);
    path.cubicTo(w * .5 / 6, 0, w * 5.5 / 6, 0, w, h);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
