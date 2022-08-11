import 'package:flutter/material.dart';

class BatmanImageAnim extends StatelessWidget {
  const BatmanImageAnim({Key? key, required this.animation}) : super(key: key);
  final Animation<double> animation;
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: animation.value,
      child:
          Image.asset('assets/batman_/batman_alone.png', fit: BoxFit.fitHeight),
    );
  }
}
