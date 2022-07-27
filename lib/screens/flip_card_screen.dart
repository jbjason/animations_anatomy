import 'package:flutter/material.dart';
import 'dart:math' as math;

class FlipCardScreen extends StatefulWidget {
  const FlipCardScreen({Key? key}) : super(key: key);
  @override
  State<FlipCardScreen> createState() => _FlipCardScreenState();
}

class _FlipCardScreenState extends State<FlipCardScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlipCard Screen'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.g_translate))
        ],
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final _val = _controller.value;
          return Stack(
            children: [
              Positioned.fill(child: Container(color: Colors.white)),
              Stack(
                children: [
                  Positioned.fill(child: Container(color: Colors.blueGrey)),
                  Positioned(
                    top: 60,
                    left: 0,
                    right: 0,
                    child: Transform.translate(
                      offset: Offset(size.width * .7, 0),
                      child: Transform(
                        alignment: Alignment.centerLeft,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, .002)
                          ..rotateY(-math.pi * (_val / 2)),
                        child: Image.asset('asets/card_/7.jpg',
                            height: 300, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 50,
                    left: 150,
                    child: ElevatedButton(
                      onPressed: () => _val < 1
                          ? _controller.forward(from: 0.0)
                          : _controller.reverse(),
                      child: const Text('TextButton'),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: AppBar(
                      title: const Text('Testing Screen'),
                      centerTitle: true,
                    ),
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
