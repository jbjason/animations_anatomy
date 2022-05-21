import 'package:flutter/material.dart';

class Heart extends StatefulWidget {
  const Heart({Key? key}) : super(key: key);

  @override
  _HeartState createState() => _HeartState();
}

class _HeartState extends State<Heart> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _color;
  late Animation<double?> _size;
  late Animation<double> _curve;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _curve = CurvedAnimation(parent: _controller, curve: Curves.easeInCubic);

    _size = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: Tween<double>(begin: 30, end: 60), weight: 50),
      TweenSequenceItem(tween: Tween<double>(begin: 60, end: 30), weight: 50),
    ]).animate(_curve);
    _color =
        ColorTween(begin: Colors.grey[400], end: Colors.red).animate(_curve);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => _isFavorite = true);
      } else if (status == AnimationStatus.dismissed) {
        setState(() => _isFavorite = false);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return IconButton(
          onPressed: () {
            _isFavorite ? _controller.reverse() : _controller.forward();
          },
          icon: Icon(Icons.favorite, color: _color.value, size: _size.value),
        );
      },
    );
  }
}
