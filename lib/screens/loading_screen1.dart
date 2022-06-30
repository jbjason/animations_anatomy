import 'package:animations_anatomy/widgets/loading_widgets/loading_home.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

const mainDataBackupColor = Color(0xFF5113AA);
const secondaryDataBackupColor = Color(0xFFBC53FA);
const backgroundColor = Color(0xFFfce7fe);

class LoadingScreen1 extends StatefulWidget {
  const LoadingScreen1({Key? key}) : super(key: key);
  @override
  State<LoadingScreen1> createState() => _LoadingScreen1State();
}

class _LoadingScreen1State extends State<LoadingScreen1>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progessAnimation;
  late Animation<double> _bubbleAnimation;
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
        vsync: this, duration: const Duration(milliseconds: 5000));
    _progessAnimation =
        CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.65));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Stack(
          children: [
            LoadingHome(
              progressAnimation: _progessAnimation,
              onPressed: () {
                _controller.forward();
              },
            ),
          ],
        ),
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
        size.height * 1.2 * (1 - animation.value) -
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
