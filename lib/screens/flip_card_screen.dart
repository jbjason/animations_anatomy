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
    return Scaffold(
      appBar: AppBar(title: const Text('Testing Screen'), centerTitle: true),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final _val = _controller.value;
          return Stack(
            children: [
              Positioned(
                top: 60,
                left: 0,
                right: 0,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, .002)
                    ..rotateY(math.pi * _val),
                  child: _val < 0.5
                      ? Image.asset('assets/card_/11.jpg', fit: BoxFit.contain)
                      : Image.asset('assets/card_/9.jpg', fit: BoxFit.contain),
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
            ],
          );
        },
      ),
    );
  }
}
