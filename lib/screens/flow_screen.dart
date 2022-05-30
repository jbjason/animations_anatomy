import 'package:flutter/material.dart';

class FlowScreen extends StatelessWidget {
  const FlowScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(),
      floatingActionButton: const FlowWidgets(),
    );
  }
}

class FlowWidgets extends StatefulWidget {
  const FlowWidgets({Key? key}) : super(key: key);

  @override
  State<FlowWidgets> createState() => _FlowWidgetsState();
}

class _FlowWidgetsState extends State<FlowWidgets> {
  final _icons = [
    Icons.menu,
    Icons.mail,
    Icons.cabin,
    Icons.notifications_active
  ];
  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: _FloatingDelegate(),
      children: [
        _body(_icons[0]),
        _body(_icons[1]),
        _body(_icons[2]),
        _body(_icons[3]),
      ],
    );
  }

  Widget _body(IconData icon_) => SizedBox(
        height: 60,
        width: 60,
        child: FloatingActionButton(
          elevation: 0,
          splashColor: Colors.grey[850],
          child: Icon(icon_, color: Colors.white, size: 40),
          onPressed: () {},
        ),
      );
}

class _FloatingDelegate extends FlowDelegate {
  @override
  void paintChildren(FlowPaintingContext context) {
    final size = context.size;
    final xStart = size.width - 60;
    final yStart = size.height - 60;
    for (int i = context.childCount - 1; i < 0; i--) {
      print(xStart + 999 + yStart);
      final childSize = size.width;
      final dx = (childSize + 8) * i;
      //  final dy = ;
      context.paintChild(i, transform: Matrix4.translationValues(dx, 0, 0));
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) => true;
}
