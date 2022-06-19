import 'package:animations_anatomy/models/trip.dart';
import 'package:flutter/material.dart';

class DiskItem extends StatefulWidget {
  const DiskItem({Key? key, required this.trip}) : super(key: key);
  final Trip trip;
  @override
  State<DiskItem> createState() => _DiskItemState();
}

class _DiskItemState extends State<DiskItem> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _animation;
  final _key = GlobalKey();
  late Position _lastPosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _animation = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _controller.forward();
    _controller.addStatusListener((status) {
      if (_controller.status == AnimationStatus.completed) {
        _lastPosition = getPosition(_key);
      }
    });
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
      builder: (context, child) {
        double x = 0, y = 0;
        if (_key.currentContext!.findRenderObject() != null) {
          final _pos = getPosition(_key);
          x = (_lastPosition.height - _pos.height).abs();
          y = (_lastPosition.width - _pos.width).abs();
        }
        return Transform.translate(
          offset:
              Offset(x * (1 - _controller.value), y * (1 - _controller.value)),
          child: Container(
            key: _key,
            child: Stack(
              children: [
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) => Positioned(
                      left: 60, // * _animation.value,
                      bottom: 5,
                      // child: Transform.rotate(
                      //     alignment: Alignment.center,
                      //     angle: vector.radians(360 * _animation.value),
                      child: Image.asset('assets/trip/disk_.png',
                          height: size.height * .16, fit: BoxFit.cover)),
                  //  ),
                ),
                Positioned(
                  left: 0,
                  child: Image.asset(widget.trip.img,
                      fit: BoxFit.fitHeight, width: 120),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class Position {
  final double height, width;
  const Position({required this.height, required this.width});
}

Position getPosition(GlobalKey _key) {
  final box = _key.currentContext!.findRenderObject() as RenderBox;
  final position = box.localToGlobal(Offset.zero);
  return Position(height: position.dy, width: position.dx);
}
