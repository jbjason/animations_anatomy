import 'package:animations_anatomy/models/travel.dart';
import 'package:flutter/material.dart';

class BackImages extends StatefulWidget {
  const BackImages({Key? key, required this.currentIndex, required this.travel})
      : super(key: key);
  final int currentIndex;
  final Travel travel;
  @override
  State<BackImages> createState() => _BackImagesState();
}

class _BackImagesState extends State<BackImages>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    // reverse makes the animation smoothly repeat
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) => SizedBox(
        height: size.height * .55,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              left: -100.0 * _controller.value,
              right: -100.0 * (1 - _controller.value),
              child: Image.asset(widget.travel.imageBack, fit: BoxFit.cover),
            ),
            Positioned(
              top: 40,
              left: 0,
              right: 0,
              height: 80,
              child: Center(
                child: Text(widget.travel.title,
                    style: const TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            Positioned.fill(
              left: -100.0 * _controller.value,
              right: -100.0 * (1 - _controller.value),
              child: Image.asset(widget.travel.imageFront, fit: BoxFit.cover),
            ),
          ],
        ),
      ),
    );
  }
}
