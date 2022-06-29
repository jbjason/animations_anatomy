import 'package:flutter/material.dart';

class StarbuckHome extends StatelessWidget {
  const StarbuckHome({Key? key, required this.animation}) : super(key: key);
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: AnimatedBuilder(
            animation: animation,
            builder: (context, child_) => SlideTransition(
              position: Tween<Offset>(
                      begin: const Offset(0, -1), end: const Offset(0, 0))
                  .animate(
                CurvedAnimation(
                  parent: animation,
                  curve: const Interval(0.0, 1.0, curve: Curves.fastOutSlowIn),
                ),
              ),
              child: Transform.scale(scale: animation.value * 1, child: child_),
            ),
            child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Image.asset('assets/starbuck/logo.png')),
          ),
        ),
      ),
    );
  }
}
