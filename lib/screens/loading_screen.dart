import 'package:flutter/material.dart';
import 'dart:math' as math;

class LoadingScreen1 extends StatefulWidget {
  const LoadingScreen1({Key? key}) : super(key: key);
  @override
  State<LoadingScreen1> createState() => _LoadingScreen1State();
}

class _LoadingScreen1State extends State<LoadingScreen1>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final bubbles = List<Bubble>.generate(500, (index) {
    final size = math.Random().nextInt(20) + 5.0;
    final speed = math.Random().nextInt(50) + 1.0;
    final directionRandom = math.Random().nextBool();
    final colorRandom = math.Random().nextBool();
    final direction =
        math.Random().nextInt(250) * (directionRandom ? 1.0 : -1.0);
    final color = colorRandom ? Colors.deepPurple : Colors.purple;
    return Bubble(
        color: color,
        direction: direction,
        speed: speed,
        size: size,
        initialPosition: index * 10.0);
  });
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Stack(
        children: [
          Positioned(
            bottom: 200,
            height: 600,
            width: 400,
            child: ClipOval(
              child: CustomPaint(
                foregroundPainter: _CloudBubbles(_controller, bubbles),
                child: Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ElevatedButton(
              onPressed: () {
                _controller.status == AnimationStatus.completed
                    ? _controller.reverse()
                    : _controller.forward(from: 0.0);
              },
              child: const Text('Start'),
            ),
          ),
        ],
      ),
    );
  }
}

class _CloudBubbles extends CustomPainter {
  final Animation<double> animation;
  final List<Bubble> bubbles;

  const _CloudBubbles(this.animation, this.bubbles) : super(repaint: animation);
  @override
  void paint(Canvas canvas, Size size) {
    for (Bubble _bubble in bubbles) {
      final offset = Offset(
        size.width / 2 + _bubble.direction * animation.value,
        size.height * (1 - animation.value) -
            _bubble.speed * animation.value +
            _bubble.initialPosition * (1 - animation.value),
      );
      canvas.drawCircle(offset, _bubble.size, Paint()..color = _bubble.color);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class Bubble {
  final Color color;
  final double direction, speed, size, initialPosition;

  const Bubble(
      {required this.color,
      required this.direction,
      required this.speed,
      required this.size,
      required this.initialPosition});
}
