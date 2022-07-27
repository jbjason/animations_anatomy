import 'dart:math';
import 'package:flutter/material.dart';

class InstaStoryScreen extends StatefulWidget {
  const InstaStoryScreen({Key? key}) : super(key: key);
  @override
  State<InstaStoryScreen> createState() => _InstaStoryScreenState();
}

class _InstaStoryScreenState extends State<InstaStoryScreen>
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
          ]),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final _val = _controller.value;
          return Stack(
            children: [
              Positioned.fill(
                right: size.width * .3,
                child: Transform.translate(
                  offset: Offset(-size.width * .7 * (1 - _val), 0),
                  child: Transform(
                    alignment: Alignment.centerRight,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, .001)
                      ..rotateY(pi / 2 * (1 - _val)),
                    child: Container(color: Colors.pinkAccent),
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(size.width * .7 * _val, 0),
                child: Transform(
                  alignment: Alignment.centerLeft,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, .001)
                    ..rotateY(pi / 2 * _val),
                  child: Stack(
                    children: [
                      Positioned.fill(child: Container(color: Colors.blueGrey)),
                      Positioned(
                        top: 60,
                        left: 0,
                        right: 0,
                        child: Image.asset('assets/card_/7.jpg',
                            height: 300, fit: BoxFit.cover),
                      ),
                    ],
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
            ],
          );
        },
      ),
    );
  }
}
