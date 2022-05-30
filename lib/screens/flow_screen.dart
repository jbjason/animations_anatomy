import 'dart:math' as math;
import 'package:flutter/material.dart';

class FlowScreen extends StatelessWidget {
  const FlowScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      floatingActionButton: FlowWidgets(),
    );
  }
}

class FlowWidgets extends StatefulWidget {
  const FlowWidgets({Key? key}) : super(key: key);
  @override
  State<FlowWidgets> createState() => _FlowWidgetsState();
}

class _FlowWidgetsState extends State<FlowWidgets>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final List<IconData> _icons = [
    Icons.mail,
    Icons.cabin,
    Icons.notifications_active,
    Icons.offline_pin,
    Icons.menu
  ];
  final List<IconData> _icons1 = [
    Icons.qr_code,
    Icons.yard,
    Icons.wrap_text_sharp,
    Icons.tablet_mac,
    Icons.offline_share,
  ];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Flow(
          delegate: _FloatingDelegate(controller: _controller),
          children: _icons.map(_body).toList(),
        ),
        Flow(
          delegate: _FloatingDelegate1(controller: _controller),
          children: _icons1.map(_body).toList(),
        ),
      ],
    );
  }

  Widget _body(IconData icon_) => SizedBox(
        height: 60,
        width: 60,
        child: FloatingActionButton(
          heroTag: '$icon_',
          elevation: 0,
          splashColor: Colors.grey[850],
          child: Icon(icon_, color: Colors.red, size: 40),
          onPressed: () {
            if (_controller.status == AnimationStatus.completed) {
              _controller.reverse();
            } else {
              _controller.forward();
            }
          },
        ),
      );
}

class _FloatingDelegate extends FlowDelegate {
  final Animation<double> controller;
  const _FloatingDelegate({required this.controller})
      : super(repaint: controller);
  @override
  void paintChildren(FlowPaintingContext context) {
    // ! Upper FlowWidgets
    final lastItem = context.childCount - 1;
    final length = context.childCount;
    for (int i = 0; i < length; i++) {
      final setValue = (val) => i == lastItem ? 0.0 : val * controller.value;
      final theta = i * math.pi * 0.5 / (length - 2);
      final x = 30.0 + setValue(180 * math.cos(theta));
      final y = 60.0 + setValue(180 * math.sin(theta));
      context.paintChild(i, transform: Matrix4.identity()..translate(x, y, 0));
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) => false;
}

class _FloatingDelegate1 extends FlowDelegate {
  final Animation<double> controller;
  const _FloatingDelegate1({required this.controller})
      : super(repaint: controller);
  @override
  void paintChildren(FlowPaintingContext context) {
    // ! Bottom FlowWidgets
    // ! just flow widgets with angle like-
    // ! topRight to bottomRight, left to rightBottom, 90 degree angle flow
    final size = context.size;
    final lastItem = context.childCount - 1;
    final xStart = size.width - 60;
    final yStart = size.height - 60;
    for (int i = lastItem; i >= 0; i--) {
      // getting child size
      final childSize = context.getChildSize(i)!.width;
      // +8.0 is padding between floatingIcons
      final dx = (childSize + 8.0) * i * controller.value;
      final x = xStart - dx;
      final y = yStart - dx;
      context.paintChild(i, transform: Matrix4.translationValues(x, y, 0));
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) => false;
}
