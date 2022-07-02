import 'package:flutter/material.dart';
import 'dart:math' as math;

class LoadingBubbles extends StatelessWidget {
  LoadingBubbles(
      {Key? key,
      required this.cloudAnimation,
      required this.bubbleAnimation,
      required this.progressAnimation})
      : super(key: key);
  final Animation<double> progressAnimation;
  final Animation<double> bubbleAnimation;
  final Animation<double> cloudAnimation;
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
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: Listenable.merge([progressAnimation, cloudAnimation]),
      builder: (context, _) {
        final _size = size.width * .5;
        final cirleSize = _size *
            math.pow((progressAnimation.value + cloudAnimation.value + 1), 2);
        final leftContainer = (size.width / 2 - (size.width * .3)) /
            2 *
            (1 - progressAnimation.value);
        final rightContainer = size.width * .4 * (1 - progressAnimation.value);
        final rightCMargin = size.width / 2 - (size.width * .5) / 2;

        final centerMargin = size.width - cirleSize;
        return Positioned(
          top: size.height * .45 -
              cirleSize +
              size.height * cloudAnimation.value,
          left: 0,
          right: 0,
          height: cirleSize,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: rightCMargin,
                height: leftContainer,
                width: leftContainer,
                child: _whiteContainer(),
              ),
              Positioned(
                bottom: 0,
                left: size.width * .45,
                height: rightContainer,
                width: rightContainer,
                child: _whiteContainer(),
              ),
              Positioned(
                bottom: 0,
                left: centerMargin / 2,
                height: cirleSize,
                width: cirleSize,
                child: ClipOval(
                  child: CustomPaint(
                    foregroundPainter: _CloudBubbles(bubbleAnimation, bubbles),
                    child: _whiteContainer(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _whiteContainer() => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(.2),
                blurRadius: 25,
                offset: const Offset(0, 25))
          ],
        ),
      );
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
