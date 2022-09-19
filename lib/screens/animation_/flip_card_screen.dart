import 'package:flutter/material.dart';
import 'dart:math';

class FlipCardScreen extends StatefulWidget {
  const FlipCardScreen({Key? key}) : super(key: key);
  @override
  State<FlipCardScreen> createState() => _FlipCardScreenState();
}

class _FlipCardScreenState extends State<FlipCardScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isBack = false;
  double angle = 0;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: size.width),
            GestureDetector(
              onVerticalDragUpdate: (details) {
                // % 360 cz degree remains 0 to 360
                angle = (angle + details.delta.dy) % 360;
                _changeImage(angle);
                setState(() {});
              },
              onVerticalDragEnd: (details) {
                // to go to initial state
                final double end = angle > 180 ? 360 : 0;
                _animation =
                    Tween<double>(begin: angle, end: end).animate(_controller)
                      ..addListener(
                        () {
                          angle = _animation.value;
                          _changeImage(angle);
                          setState(() {});
                        },
                      );
                _controller.forward(from: 0.0);
              },
              child: SizedBox(
                height: 300,
                width: 300,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, .001)
                    ..rotateX(angle / 180 * pi),
                  child: !_isBack
                      ? Image.asset('assets/card_/jb.jpg', fit: BoxFit.cover)
                      : Image.asset('assets/card_/jb1.jpg', fit: BoxFit.cover),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _changeImage(double val) {
    if (val > 90 && val < 270) {
      _isBack = true;
    } else {
      _isBack = false;
    }
  }
}
