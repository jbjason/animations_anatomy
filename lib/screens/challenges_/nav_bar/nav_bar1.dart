import 'dart:ui';
import 'package:flutter/material.dart';

class NavBar1 extends StatefulWidget {
  const NavBar1({Key? key}) : super(key: key);
  @override
  State<NavBar1> createState() => _NavBar1State();
}

class _NavBar1State extends State<NavBar1> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  static const double _maxHeight = 350;
  static const double _minHeight = 70;
  bool _isExpand = false;
  double _currentHeight = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _menuWidth = size.width * .45;
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Container(height: 100, width: size.width, color: Colors.white),
      bottomNavigationBar: GestureDetector(
        onVerticalDragUpdate: (val) {
          if (_isExpand) {
            setState(() {
              final newHeight = _currentHeight - val.delta.dy;
              _currentHeight = newHeight.clamp(_minHeight, _maxHeight);
              _controller.value = _currentHeight / _maxHeight;
            });
          }
        },
        onVerticalDragEnd: (val) {
          if (_isExpand) {
            if (_currentHeight < _maxHeight / 2) {
              // if dragValue is less than maxHeight/2 then animation goes reverse
              _controller.reverse();
              _isExpand = false;
            } else {
              // if dragValue is heigher than maxHeight/2 then animation goes Forward
              _controller.forward(from: _currentHeight / _maxHeight);
              _isExpand = true;
              _currentHeight = _maxHeight;
            }
          }
        },
        child: AnimatedBuilder(
          animation: _controller,
          builder: (ctx, _) {
            final double value = _controller.value.toDouble();
            return Stack(
              children: [
                Positioned(
                  bottom: lerpDouble(40.0, 0, value),
                  left: lerpDouble(size.width / 2 - _menuWidth / 2, 0, value),
                  height: lerpDouble(_minHeight, _maxHeight, value),
                  width: lerpDouble(_menuWidth, size.width, value),
                  child: Container(
                    decoration: BoxDecoration(
                      color: _isExpand ? Colors.deepPurple : Colors.deepOrange,
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(lerpDouble(40.0, 0, value)!),
                          top: const Radius.circular(40)),
                    ),
                    child: _isExpand ? _expandedWidget() : _initialWidget(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _expandedWidget() => Padding(
        padding: const EdgeInsets.only(top: 20),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(height: 80, width: 80, color: Colors.black),
              const SizedBox(height: 15),
              const Text('jb jason', style: TextStyle(color: Colors.white)),
              const Text('BLACK BERRY',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.close, size: 30),
                  SizedBox(width: 30),
                  Icon(Icons.pause, size: 30),
                  SizedBox(width: 30),
                  Icon(Icons.skip_next, size: 30),
                ],
              )
            ],
          ),
        ),
      );

  Widget _initialWidget() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Icon(Icons.adb, size: 30),
          InkWell(
              onTap: () {
                setState(() {
                  _isExpand = true;
                  _currentHeight = _maxHeight;
                });
                _controller.forward(from: 0.0);
              },
              child: const Icon(Icons.adb, size: 30)),
          const Icon(Icons.adb, size: 30),
        ],
      );
}
