import 'package:animations_anatomy/models/trip.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vector;

class DiskItem extends StatefulWidget {
  const DiskItem({Key? key, required this.count, required this.trip})
      : super(key: key);
  final Trip trip;
  final int count;
  @override
  State<DiskItem> createState() => _DiskItemState();
}

class _DiskItemState extends State<DiskItem> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _animation;
  final _key = GlobalKey();
  Offset _lastPosition = Offset.zero;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _animation = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
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
    _controller.forward(from: 0);
    final size = MediaQuery.of(context).size;
    return Container(
      key: _key,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          double x = 0, y = 0;
          final f = _key.currentContext;
          if (f != null) {
            if (f.findRenderObject() != null) {
              final _pos = getPosition(_key);
              x = (_lastPosition.dx - _pos.dx);
              y = (_lastPosition.dy - _pos.dy);
            }
          }
          return Transform.translate(
            offset: Offset(
                x * (1 - _controller.value), y * (1 - _controller.value)),
            child: Stack(
              children: [
                // AnimatedBuilder(
                //   animation: _animation,
                //   builder: (context, child) =>
                Positioned(
                  left: 60, // * _animation.value,
                  bottom: 5,
                  child: Transform.rotate(
                      alignment: Alignment.center,
                      angle: vector.radians(360 * _animation.value),
                      child: Image.asset('assets/trip/disk_.png',
                          height: size.height * .16, fit: BoxFit.cover)),
                  //   ),
                ),
                Positioned(
                  left: 0,
                  child: Image.asset(widget.trip.img,
                      fit: BoxFit.fitHeight, width: 120),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

Offset getPosition(GlobalKey _key) {
  final box = _key.currentContext!.findRenderObject() as RenderBox;
  final position = box.localToGlobal(Offset.zero);
  return Offset(position.dx, position.dy);
}
