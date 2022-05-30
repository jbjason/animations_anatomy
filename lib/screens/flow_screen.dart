import 'package:flutter/material.dart';

class FlowScreen extends StatelessWidget {
  const FlowScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [Text('Jb Jason')],
      ),
      floatingActionButton: const FlowWidgets(),
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
    Icons.menu,
  ];
  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: _FloatingDelegate(controller: _controller),
      children: _icons.map(_body).toList(),
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
  const _FloatingDelegate({required this.controller});
  @override
  void paintChildren(FlowPaintingContext context) {
    final size = context.size;
    final xStart = size.width - 60;
    final yStart = size.height - 60;
    print(xStart);
    print(yStart);
    for (int i = context.childCount - 1; i >= 0; i--) {
      final childSize = context.getChildSize(i)!.width;
      final dx = (childSize + 8) * i;
      final x = xStart * controller.value;
      final y = (yStart - dx) * controller.value;
      context.paintChild(i, transform: Matrix4.translationValues(x, y, 0));
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) => false;
}
